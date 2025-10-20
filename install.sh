#!/bin/bash

# EtherOS Bootloader Installation Script
# WARNING: Only run this in a virtual machine!

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verbose mode flag
VERBOSE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            echo "EtherOS Bootloader Installation Script"
            echo ""
            echo "Usage: ./install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -v, --verbose    Enable verbose output"
            echo "  -h, --help       Show this help message"
            echo ""
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to check if running in a VM
check_vm() {
    print_message "$YELLOW" "⚠️  WARNING: This should only be run in a virtual machine!"
    echo ""
    read -p "Are you running this in a virtual machine? (yes/no): " confirm
    if [[ ! "$confirm" =~ ^[Yy][Ee][Ss]$ ]]; then
        print_message "$RED" "Installation aborted. Please run this in a virtual machine."
        exit 1
    fi
}

# Function to check prerequisites
check_prerequisites() {
    print_message "$GREEN" "Checking prerequisites..."
    
    # Check for required tools
    local required_tools=("bash" "mkdir" "chmod")
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            print_message "$RED" "Error: Required tool '$tool' is not installed."
            exit 1
        fi
    done
    
    print_message "$GREEN" "✓ Prerequisites check passed"
}

# Function to create directory structure
create_directories() {
    print_message "$GREEN" "Creating directory structure..."
    
    mkdir -p boot
    mkdir -p config
    mkdir -p logs
    
    if [ "$VERBOSE" = true ]; then
        print_message "$YELLOW" "Created directories: boot, config, logs"
    fi
    
    print_message "$GREEN" "✓ Directory structure created"
}

# Function to install bootloader files
install_bootloader() {
    print_message "$GREEN" "Installing bootloader files..."
    
    # Create a basic boot configuration
    cat > boot/boot.cfg << EOF
# EtherOS Bootloader Configuration
# Generated on $(date)

# Boot timeout (seconds)
timeout=5

# Default boot entry
default=0

# Boot entries
[entry0]
title=EtherOS
kernel=/boot/etheros-kernel

EOF
    
    # Create a placeholder kernel info file
    cat > boot/README.txt << EOF
EtherOS Bootloader Boot Directory

This directory contains the bootloader configuration and kernel files.

To complete the installation:
1. Place your EtherOS kernel in this directory
2. Update boot.cfg with the correct kernel path
3. Configure your VM to boot from this bootloader

For more information, see the main README.md file.
EOF
    
    print_message "$GREEN" "✓ Bootloader files installed"
}

# Function to create example configuration
create_config() {
    print_message "$GREEN" "Creating example configuration..."
    
    cat > config/etheros.conf << EOF
# EtherOS Configuration File
# Edit this file to customize your EtherOS installation

[system]
# System name
hostname=etheros-vm

# Memory allocation (MB)
memory=512

# Enable debug mode
debug=false

[bootloader]
# Bootloader timeout in seconds
timeout=5

# Show boot menu
show_menu=true

# Bootloader log level (0=quiet, 1=normal, 2=verbose)
log_level=1

[network]
# Enable networking (if supported)
enable=false

EOF
    
    print_message "$GREEN" "✓ Configuration files created"
}

# Function to set permissions
set_permissions() {
    print_message "$GREEN" "Setting permissions..."
    
    chmod 755 boot
    chmod 644 boot/boot.cfg 2>/dev/null || true
    chmod 644 boot/README.txt 2>/dev/null || true
    chmod 755 config
    chmod 644 config/etheros.conf
    chmod 755 logs
    
    print_message "$GREEN" "✓ Permissions set"
}

# Main installation function
main() {
    print_message "$GREEN" "======================================="
    print_message "$GREEN" "  EtherOS Bootloader Installation"
    print_message "$GREEN" "======================================="
    echo ""
    
    check_vm
    check_prerequisites
    create_directories
    install_bootloader
    create_config
    set_permissions
    
    echo ""
    print_message "$GREEN" "======================================="
    print_message "$GREEN" "  Installation Complete!"
    print_message "$GREEN" "======================================="
    echo ""
    print_message "$YELLOW" "Next steps:"
    echo "1. Review the configuration in config/etheros.conf"
    echo "2. Place your EtherOS kernel in the boot/ directory"
    echo "3. Update boot/boot.cfg with your kernel path"
    echo "4. Configure your VM to boot from this bootloader"
    echo ""
    print_message "$YELLOW" "For more information, see README.md"
    echo ""
}

# Run main function
main
