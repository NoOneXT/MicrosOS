# MicrosOS Overview

This document serves as an overview of MicrosOS, explaining the available commands within the LegenJuice shell, the structure of the source code, and what we have done to customize it.

## 🛠️ Available Shell Commands

Once you boot into MicrosOS, enter the PIN (`1111`) and type `shell` to access the **LegenJuice** kernel-mode shell. You can run the following commands:

### General Commands
- **`sahayog`** - Shows the help menu with a list of commands.
- **`nikli`** - Exits the shell and returns to the secure boot gate.
- **`safa`** - Clears the screen.
- **`samaya`** - Shows the system uptime in HH:MM:SS format and the number of timer ticks.
- **`calc <num1> <op> <num2>`** - Performs basic arithmetic (e.g., `calc 5 + 10`).

### Filesystem Commands (In-Memory FAT)
- **`jhalak`** - Displays a summary of the FAT filesystem including free blocks.
- **`fatlist`** - Lists all created files with their sizes and starting blocks.
- **`create <name>`** - Creates a new empty file.
- **`write <name> <text>`** - Writes text into an existing file.
- **`read <name>`** - Reads and prints the text content from a file.

### Process & Scheduling Commands
- **`proclist`** - Shows the active processes and threads in a table.
- **`thlist`** - Shows the threads table.
- **`mkproc [burst]`** - Creates a dummy process with an optional burst time.
- **`mkthr <pid> [burst]`** - Creates a new thread attached to a parent process.
- **`policy [rr|srtf]`** - Sets the scheduler policy to either Round Robin (`rr`) or Shortest Remaining Time First (`srtf`).
- **`sched [n]`** - Runs the scheduler `n` times to simulate CPU execution.

---

## 📁 Source Code & Directory Structure

MicrosOS is built from scratch and organized into several core components:

- **`kernel/`** 
  - `kernel.c`: The main entry point of the OS where systems initialize and the boot banner is drawn.
  - `console.c`: Manages the secure boot gate and PIN system.
  - Interacts with interrupts (`idt.c`, `isr.c`) to keep the system responsive.
- **`shell/`**
  - `kernel_shell.c`: The heart of the **LegenJuice** shell. It parses your input and contains the logic for all the commands listed above.
- **`filesystem/`**
  - Contains the logic for the basic in-memory File Allocation Table (FAT) system.
- **`process/`**
  - Manages task creation and CPU scheduling algorithms (RR & SRTF).
- **`memory/`**
  - Handles segmentation (GDT) and basic memory paging to protect OS data.
- **`drivers/`**
  - Code allowing the OS to talk to basic hardware like the keyboard, mouse, and VGA text-mode screen.
- **`boot/`**
  - Contains the low-level assembly and Grub configurations needed to make the OS bootable by the BIOS.
- **`Makefile`**
  - A script containing instructions for the cross-compiler on how to link all these C and Assembly files together into a final `.iso` image.

---


