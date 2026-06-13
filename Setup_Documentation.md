# MicrosOS Setup Documentation

Welcome to **MicrosOS**. This operating system is maintained and created by **Legen**. It is a 32-bit x86 OS built from scratch, featuring its own custom shell, LegenJuice, memory manager, scheduler, and an in-memory FAT filesystem.

## Prerequisites
To build natively, you need a cross-compiler. The easiest way on Windows is using WSL (Windows Subsystem for Linux - Ubuntu) and running via QEMU.

1. Open WSL (Ubuntu) and install the toolchain:
   ```bash
   sudo apt update
   sudo apt install qemu-system-x86 nasm gcc-i686-linux-gnu binutils-i686-linux-gnu make xorriso grub-pc-bin mtools python3 grub-common
   ```

2. Link the expected commands inside WSL:
   ```bash
   sudo ln -s /usr/bin/i686-linux-gnu-gcc /usr/local/bin/i686-elf-gcc
   sudo ln -s /usr/bin/i686-linux-gnu-ld /usr/local/bin/i686-elf-ld
   sudo ln -s /usr/bin/i686-linux-gnu-objcopy /usr/local/bin/i686-elf-objcopy
   ```

3. Build the OS:
   ```bash
   make all
   make iso
   ```

4. Run the OS via QEMU:
   ```bash
   make run
   ```

## Included Features
- **LegenJuice Shell**: A rich kernel-level shell interface.
- **Process Scheduler**: Supports Round Robin and SRTF policies.
- **Memory Management**: Basic paging and segmentation (GDT/IDT).
- **FAT Filesystem**: In-memory FAT for basic file creation, reading, and writing.

**Security Pin**: When the OS boots in the console, you will be prompted for a PIN. The default PIN is `1111`. Type the PIN, press Enter, then type `shell` to access LegenJuice!
