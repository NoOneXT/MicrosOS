#!/bin/bash
echo "Building the OS..."
make all

echo "Generating the ISO..."
make iso

echo "Running via QEMU..."
make run
