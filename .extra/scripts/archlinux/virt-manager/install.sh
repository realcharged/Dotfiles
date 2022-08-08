#!/bin/bash

echo "Welcome to the virt-manager installer! This script is for Arch Linux based systems only."
# Change paru and syntax to your own AUR helper if needed
echo ""
echo "This script requires the paru AUR helper."
echo ""

echo "Installing packages"
echo ""
paru -S qemu virt-manager ebtables
echo ""

echo "Enabling the libvirtd service"
echo ""
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
echo ""

echo "Adding user to libvirt group"
""
sudo usermod -G libvirt -a charged
# Change charged to your username
echo ""

echo "Installation complete!"
