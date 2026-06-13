markdown
# MicrosOS - A Simple Operating System

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-x86-blue)
![Build](https://img.shields.io/badge/build-Make-green)

MicrosOS is a minimal, educational operating system kernel developed from scratch for x86 architecture. This project demonstrates core OS concepts including bootloading, memory management, process scheduling, filesystem operations, and a basic shell interface.

## 📋 Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Building](#building)
- [Running](#running)
- [Architecture](#architecture)
- [Components](#components)
- [Usage Guide](#usage-guide)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### Core Features
- **Custom Bootloader** - BIOS-based boot process
- **Protected Mode** - 32-bit protected mode operation
- **Memory Management** - Basic paging and heap allocation
- **Process Management** - Simple process creation and scheduling
- **FAT12 Filesystem** - Floppy disk image filesystem support
- **Shell Interface** - Command-line user interface
- **Keyboard Driver** - PS/2 keyboard input handling
- **VGA Text Mode** - Display output management

### Commands Supported
- `help` - Display available commands
- `cls` - Clear screen
- `echo <text>` - Display text
- `ls` - List files
- `cat <file>` - Display file contents
- `run <program>` - Execute a program
- `meminfo` - Show memory usage
- `ps` - List running processes
- `reboot` - Restart the system

## 📁 Project Structure
MicrosOS/
├── boot/ # Bootloader files
│ ├── boot.asm # Stage 1 bootloader
│ └── stage2.asm # Stage 2 bootloader
├── kernel/ # Core kernel code
│ ├── main.c # Kernel entry point
│ ├── interrupt.c # IDT and interrupt handlers
│ └── keyboard.c # Keyboard driver
├── memory/ # Memory management
│ ├── paging.c # Page table management
│ └── heap.c # Dynamic memory allocator
├── process/ # Process management
│ ├── scheduler.c # Round-robin scheduler
│ └── task.c # Process control blocks
├── filesystem/ # Filesystem operations
│ ├── fat12.c # FAT12 implementation
│ └── file.c # File operations
├── drivers/ # Hardware drivers
│ ├── vga.c # VGA text mode driver
│ └── timer.c # PIT timer driver
├── shell/ # Command interpreter
│ └── shell.c # Shell implementation
├── include/ # Header files
│ ├── kernel.h # Kernel definitions
│ └── types.h # Type definitions
├── build/ # Build output (generated)
├── linker.ld # Linker script
├── Makefile # Build automation
├── run.sh # QEMU launcher script
└── README.md # This file

text

## 🔧 Prerequisites

### Required Tools
| Tool | Version | Purpose | Installation |
|------|---------|---------|--------------|
| **GCC Cross-Compiler** | i686-elf | Compile kernel | `sudo apt install gcc-13-i686-linux-gnu` |
| **NASM** | 2.15+ | Assembly compiler | `sudo apt install nasm` |
| **Make** | 4.0+ | Build automation | `sudo apt install make` |
| **QEMU** | 6.0+ | Emulator | `sudo apt install qemu-system-x86` |
| **LD** | 2.38+ | Linker | `sudo apt install binutils` |
| **GRUB** | 2.06+ | Bootloader | `sudo apt install grub-pc-bin` |

### For Ubuntu/Debian (One-liner installation)
```bash
sudo apt update
sudo apt install -y build-essential nasm qemu-system-x86 grub-pc-bin xorriso
For Arch Linux
bash
sudo pacman -S base-devel nasm qemu grub xorriso
For macOS (using Homebrew)
bash
brew install nasm qemu i686-elf-gcc
🚀 Installation
1. Clone the Repository
bash
git clone https://github.com/NoOneXT/MicrosOS.git
cd MicrosOS
2. Build the Operating System
bash
make clean
make all
This will:

Compile all assembly files (.asm) to object files

Compile all C files (.c) to object files

Link everything into a kernel binary

Create a bootable ISO image

3. Verify Build Output
After successful build, you should see:

build/kernel.bin - The kernel binary

build/os-image.iso - Bootable ISO image

🎮 Running MicrosOS
Method 1: Using QEMU (Recommended)
bash
./run.sh
Or manually:

bash
qemu-system-x86_64 -cdrom build/os-image.iso -m 128M
Method 2: Using the Makefile
bash
make run
Method 3: On Real Hardware (Advanced)
Write ISO to USB drive:

bash
sudo dd if=build/os-image.iso of=/dev/sdX bs=4M status=progress
Boot from USB drive (BIOS mode, not UEFI)

🏗️ Architecture
Boot Process
BIOS → Loads first 512 bytes (bootloader)

Stage 1 → Loads stage 2 bootloader

Stage 2 → Loads kernel into memory

Kernel → Initializes subsystems

Shell → User interaction begins

Memory Layout
text
Address Range          | Usage
-----------------------|------------------
0x00000000 - 0x000003FF | Real Mode IVT
0x00000400 - 0x000004FF | BIOS Data Area
0x00000500 - 0x00007C00 | Bootloader
0x00007C00 - 0x00007E00 | Stage 1 Bootloader
0x00010000 - 0x00090000 | Kernel Code
0x00090000 - 0x000A0000 | Reserved
0x00100000 - 0x01000000 | Heap & Stack
System Calls
Interrupt	Function	Parameters
INT 0x21	Print string	AH=0x01, SI=string
INT 0x21	Read key	AH=0x02, Returns AL=char
INT 0x22	Memory alloc	AH=0x01, BX=size, Returns EAX=addr
INT 0x23	Create process	AH=0x01, BX=entry_point
💻 Usage Guide
First Boot
When MicrosOS starts, you'll see:

text
=========================================
    MicrosOS - Simple Operating System
=========================================

Kernel loaded at 0x10000
Memory size: 128 MB
Paging enabled
Initializing devices...
  [OK] VGA Driver
  [OK] Keyboard Driver
  [OK] Timer Driver
Filesystem mounted
Shell initialized

MicrosOS> 
Basic Commands
help - Show all commands
text
MicrosOS> help
Available commands:
  help      - Show this help
  cls       - Clear screen
  echo      - Display text
  ls        - List files
  cat       - Display file
  meminfo   - Show memory info
  ps        - List processes
  reboot    - Restart system
echo - Display text
text
MicrosOS> echo Hello World!
Hello World!
meminfo - Check memory usage
text
MicrosOS> meminfo
Total Memory: 128 MB
Used Memory: 12 MB
Free Memory: 116 MB
Heap blocks: 4
ps - View running processes
text
MicrosOS> ps
PID | Name          | State    | Memory
----------------------------------------
1   | kernel        | Running  | 2048 KB
2   | shell         | Ready    | 512 KB
3   | test          | Sleeping | 256 KB
🛠️ Development
Adding New Features
1. Create a new source file in appropriate directory
c
// Example: drivers/audio.c
#include <kernel.h>

void audio_init(void) {
    // Initialize audio hardware
}

void audio_play_sound(uint32_t frequency) {
    // Play PC speaker beep
}
2. Add header in include/ directory
c
// include/drivers/audio.h
#ifndef AUDIO_H
#define AUDIO_H

void audio_init(void);
void audio_play_sound(uint32_t frequency);

#endif
3. Update Makefile
makefile
# Add to C_SOURCES variable
C_SOURCES = $(wildcard kernel/*.c memory/*.c drivers/*.c filesystem/*.c process/*.c shell/*.c)
4. Call initialization in kernel/main.c
c
#include <drivers/audio.h>

void kernel_main(void) {
    // ... existing code ...
    audio_init();
    // ... more code ...
}
Debugging with GDB
bash
# Terminal 1: Run QEMU with debugging
qemu-system-x86_64 -cdrom build/os-image.iso -s -S

# Terminal 2: Connect GDB
i686-elf-gdb build/kernel.bin
(gdb) target remote localhost:1234
(gdb) break kernel_main
(gdb) continue
🔧 Troubleshooting
Common Issues
Problem	Solution
"make: command not found"	Install build-essential: sudo apt install build-essential
"nasm: command not found"	Install NASM: sudo apt install nasm
"i686-elf-gcc: command not found"	Install cross-compiler or use system GCC
QEMU shows "Boot failed"	Run make clean && make all to rebuild
Kernel panic at boot	Check memory configuration in QEMU (-m 128M)
No keyboard input	Ensure QEMU has focus (click on window)
Quick Fixes
Fix permission denied on run.sh
bash
chmod +x run.sh
Clean everything and rebuild
bash
make clean
make all
Run with more memory
bash
qemu-system-x86_64 -cdrom build/os-image.iso -m 256M
Enable QEMU logging
bash
qemu-system-x86_64 -cdrom build/os-image.iso -d int,cpu_reset -no-reboot -no-shutdown
📈 Performance
Build Statistics
Build time: ~3-5 seconds

ISO size: ~1.4 MB

Kernel size: ~50 KB

Memory usage: 128 MB (configurable)

Process limit: 64 processes

File limit: 64 open files

🤝 Contributing
Contributions are welcome! Here's how to help:

Fork the repository

Create a feature branch

bash
git checkout -b feature/amazing-feature
Make your changes

Follow coding style (K&R for C, NASM syntax for assembly)

Add comments for complex code

Update documentation

Test your changes

bash
make clean && make all && ./run.sh
Commit and push

bash
git add .
git commit -m "Add amazing feature"
git push origin feature/amazing-feature
Open a Pull Request

Areas for Improvement
Network driver support

Sound driver

GUI interface

More filesystem types

System calls documentation

User mode protection

📚 Learning Resources
Recommended Reading
OSDev Wiki - Comprehensive OS development resource

Intel x86 Manuals

The Little OS Book

Tutorials Used
Bootloader development

GDT/IDT setup

Paging implementation

Process scheduling algorithms

📄 License
This project is licensed under the MIT License - see below:

text
MIT License

Copyright (c) 2026 Saksham Smith Sunar (NoOneXT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
📞 Contact & Support
GitHub: @NoOneXT

Issues: Report a bug

🙏 Acknowledgments
OSDev community for documentation

Intel for architecture manuals

QEMU team for emulator

All contributors and testers

⚡ Quick Start Commands
bash
# Clone and build
git clone https://github.com/NoOneXT/MicrosOS.git
cd MicrosOS
make all

# Run in QEMU
./run.sh

# Or run manually
qemu-system-x86_64 -cdrom build/os-image.iso -m 128M

# Clean build
make clean && make all

# Debug with GDB
make debug
Happy OS Development! 🖥️

text

## How to Add This README to Your Project:

1. **Create the README file:**
```bash
cd /path/to/MicrosOS
nano README.md
