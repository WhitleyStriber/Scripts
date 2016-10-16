#!/bin/bash

# This script wipes 4 flash drives, creates an MSDOS partition label, creates a paritionand creates a FAT32 partition
# This is to be used with a USB hub for quick and easy paritioning

# Author: Whitley Striber

# ensure all of the partitions on every drive are unmounted
umount -f /dev/sd*

echo "Unmount complete"

# Remove any redundant partitions by recreateing the label/partition table of each drive
parted /dev/sda -a optimal -s mklabel msdos
parted /dev/sdb -a optimal -s mklabel msdos
parted /dev/sdc -a optimal -s mklabel msdos
parted /dev/sdd -a optimal -s mklabel msdos

# Create a new partion for each drive (FAT32)
parted /dev/sda -s mkpart p fat32 0% 100%
parted /dev/sdb -s mkpart p fat32 0% 100%
parted /dev/sdc -s mkpart p fat32 0% 100%
parted /dev/sdd -s mkpart p fat32 0% 100%

echo "Completed partitioning. Moving onto formatting"

# Format the flash drives to FAT32
mkfs.fat -F32 /dev/sda1
mkfs.fat -F32 /dev/sdb1
mkfs.fat -F32 /dev/sdc1
mkfs.fat -F32 /dev/sdd1

echo "Done! Remove these flash drives and load up another tray."
