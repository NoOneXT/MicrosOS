# MicrosOS

> A 32-bit x86 operating system built from scratch in C and Assembly.

MicrosOS is a bare-metal operating system developed by **Legen** ([@NoOneXT](https://github.com/NoOneXT)). It boots via GRUB, runs on the i686 architecture, and features a custom kernel-mode shell called **LegenJuice**, complete with process scheduling, memory management, hardware drivers, and an in-memory FAT filesystem — all written without any standard library.

---

## ✨ Features

- **LegenJuice Shell** — A kernel-mode interactive shell with Nepali-inspired command names
- **Process Scheduler** — Supports Round Robin (RR) and Shortest Remaining Time First (SRTF) algorithms
- **Thread Management** — Create and track threads attached to parent processes
- **In-Memory FAT Filesystem** — Create, write, and read files entirely in RAM
- **Memory Management** — GDT-based segmentation and basic paging to protect OS memory
- **Hardware Drivers** — Keyboard, mouse, VGA text-mode screen, and PIT timer
- **Interrupt Handling** — IDT, ISR, and IRQ support via NASM assembly stubs
- **Secure Boot Gate** — PIN-protected console before shell access (default PIN: `1111`)
- **System Uptime** — Real-time HH:MM:SS clock via timer ticks
- **Built-in Calculator** — Arithmetic expressions evaluated directly in the shell

---

## 📁 Repository Structure

```
MicrosOS/
├── boot/
│   └── grub/           # GRUB bootloader configuration
├── drivers/
│   ├── keyboard.c      # PS/2 keyboard driver
│   ├── mouse.c         # PS/2 mouse driver
│   ├── screen.c        # VGA text-mode display driver
│   ├── printf.c        # Kernel printf implementation
│   └── timer.c         # PIT timer driver
├── filesystem/
│   ├── fat.c           # FAT allocation table logic
│   └── filesystem.c    # High-level filesystem operations
├── include/            # Shared header files
├── kernel/
│   ├── kernel.c        # Main entry point — boot banner & subsystem init
│   ├── kernel_entry.asm# Multiboot entry point (NASM)
│   ├── interrupts.asm  # Low-level interrupt stubs (NASM)
│   ├── idt.c           # Interrupt Descriptor Table setup
│   ├── isr.c           # Interrupt Service Routines
│   └── console.c       # Secure boot gate & PIN system
├── memory/
│   └── memory.c        # GDT, segmentation, and paging
├── process/
│   └── process.c       # Process/thread creation and CPU scheduling
├── shell/
│   └── kernel_shell.c  # LegenJuice shell — command parser & handlers
├── linker.ld           # Linker script for kernel ELF layout
├── Makefile            # Build system (cross-compiler + QEMU)
├── run.sh              # Quick run script
├── OS_Overview.md      # Shell commands & architecture overview
└── Setup_Documentation.md  # Build & setup guide
```

---

## 🚀 Quick Start

### Prerequisites

You need a cross-compiler targeting `i686-elf`. On Windows, the easiest approach is **WSL (Ubuntu)**.

**Install the toolchain:**
```bash
sudo apt update
sudo apt install qemu-system-x86 nasm gcc-i686-linux-gnu binutils-i686-linux-gnu \
  make xorriso grub-pc-bin mtools python3 grub-common
```

**Link the cross-compiler binaries:**
```bash
sudo ln -s /usr/bin/i686-linux-gnu-gcc    /usr/local/bin/i686-elf-gcc
sudo ln -s /usr/bin/i686-linux-gnu-ld     /usr/local/bin/i686-elf-ld
sudo ln -s /usr/bin/i686-linux-gnu-objcopy /usr/local/bin/i686-elf-objcopy
```

### Build & Run

```bash
# Clone the repository
git clone https://github.com/NoOneXT/MicrosOS.git
cd MicrosOS

# Build the kernel binary
make all

# Create a bootable ISO image
make iso

# Run in QEMU
make run
```

For debug output (interrupt logs saved to `build/qemu.log`):
```bash
make run-debug
```

To clean the build directory:
```bash
make clean
```

---

## 🖥️ Using MicrosOS

When the OS boots:

1. You will see the boot banner and be prompted for a **PIN**.
2. Enter the default PIN: **`1111`** and press Enter.
3. Type **`shell`** to enter the **LegenJuice** kernel shell.

---

## 💻 Shell Commands (LegenJuice)

### General

| Command | Description |
|---|---|
| `sahayog` | Show the help menu |
| `nikli` | Exit the shell back to the boot gate |
| `safa` | Clear the screen |
| `samaya` | Show system uptime (HH:MM:SS) and timer tick count |
| `calc <n1> <op> <n2>` | Basic arithmetic — e.g., `calc 5 + 10` |

### Filesystem (In-Memory FAT)

| Command | Description |
|---|---|
| `jhalak` | Show FAT filesystem summary and free block count |
| `fatlist` | List all files with their sizes and starting blocks |
| `create <name>` | Create a new empty file |
| `write <name> <text>` | Write text into an existing file |
| `read <name>` | Read and print a file's content |

### Process & Scheduling

| Command | Description |
|---|---|
| `proclist` | Show active processes and threads |
| `thlist` | Show the thread table |
| `mkproc [burst]` | Create a dummy process with optional burst time |
| `mkthr <pid> [burst]` | Create a thread attached to a parent process |
| `policy [rr\|srtf]` | Set scheduler to Round Robin or SRTF |
| `sched [n]` | Simulate `n` rounds of CPU scheduling |

---

## 🛠️ Build System Details

The `Makefile` uses `i686-elf-gcc` (cross-compiler), `nasm` (assembler), and `grub-mkrescue` to produce a bootable `build/os.iso`.

Key compiler flags: `-ffreestanding -O2 -Wall -Wextra` — no standard library, optimized, with warnings.

The `linker.ld` script controls the final memory layout of the kernel ELF binary.

---

## 🧰 Tech Stack

| Tool | Role |
|---|---|
| C (93%) | Kernel, drivers, shell, memory, filesystem, process management |
| NASM Assembly | Bootloader entry point, interrupt stubs |
| GNU Make | Build automation |
| GRUB | Bootloader (Multiboot specification) |
| QEMU | Emulation and testing (`qemu-system-i386`) |
| i686-elf-gcc | Bare-metal cross-compiler |

---

## 📄 Documentation

- [`OS_Overview.md`](./OS_Overview.md) — Shell command reference and source code architecture
- [`Setup_Documentation.md`](./Setup_Documentation.md) — Detailed build and setup guide

---

## 👤 About the Author

MicrosOS is built and maintained by **Legen** ([@NoOneXT](https://github.com/NoOneXT)).

---

## 📜 License

This project is currently unlicensed. All rights reserved by the author.
