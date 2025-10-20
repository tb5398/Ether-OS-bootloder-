# Ether-OS Bootloader

A bootloader for EtherOS - a custom operating system.

## ⚠️ Important Warning
**Only run EtherOS in a virtual machine (VM).** Running it on physical hardware may result in data loss or system instability.

## Prerequisites

- A virtual machine software (VirtualBox, VMware, QEMU, etc.)
- Git installed on your host system
- Basic knowledge of command-line operations
- Minimum 512MB RAM allocated to the VM
- At least 1GB of free disk space

## Installation

### Quick Install

Clone this repository and run the installation script:

```bash
git clone https://github.com/tb5398/Ether-OS-bootloder-.git
cd Ether-OS-bootloder-
chmod +x install.sh
./install.sh
```

### Manual Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/tb5398/Ether-OS-bootloder-.git
   cd Ether-OS-bootloder-
   ```

2. **Set up your virtual machine:**
   - Create a new VM with at least 512MB RAM
   - Attach a virtual hard drive (minimum 1GB)
   - Configure boot order to boot from the bootloader

3. **Install the bootloader:**
   ```bash
   # Copy bootloader files to your VM's boot partition
   # Follow specific instructions for your VM software
   ```

## Usage

After installation, boot your virtual machine. The EtherOS bootloader will:
1. Initialize the system
2. Load the operating system kernel
3. Transfer control to EtherOS

## Configuration

You can customize the bootloader by editing `boot.cfg` (if available).

## Troubleshooting

### VM won't boot
- Ensure the bootloader is properly installed on the VM's boot partition
- Check VM boot order settings
- Verify VM has sufficient resources allocated

### Installation script fails
- Make sure you have execute permissions: `chmod +x install.sh`
- Check that all dependencies are installed
- Run with verbose output: `./install.sh -v`

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## License

This project is open source. Please check the LICENSE file for details.

## Disclaimer

This is experimental software. Use at your own risk. The authors are not responsible for any damage or data loss. Always use a virtual machine for testing.
