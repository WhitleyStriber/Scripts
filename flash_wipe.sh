#!/bin/bash

# This script wipes 4 flash drives, creates an MSDOS partition label, creates a parition, and creates a FAT32 filesystem on the created partition.

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
parted /dev/sde -a optimal -s mklabel msdos
parted /dev/sdf -a optimal -s mklabel msdos

# Create a new partion for each drive (FAT32)
parted /dev/sda -s mkpart p fat32 0% 100%
parted /dev/sdb -s mkpart p fat32 0% 100%
parted /dev/sdc -s mkpart p fat32 0% 100%
parted /dev/sdd -s mkpart p fat32 0% 100%
parted /dev/sde -s mkpart p fat32 0% 100%
parted /dev/sdf -s mkpart p fat32 0% 100%

echo "Completed partitioning. Moving onto formatting"

# Format the flash drives to FAT32
mkfs.fat -F32 /dev/sda1
mkfs.fat -F32 /dev/sdb1
mkfs.fat -F32 /dev/sdc1
mkfs.fat -F32 /dev/sdd1
mkfs.fat -F32 /dev/sde1
mkfs.fat -F32 /dev/sdf1

echo "Done, mounting drives..."

mount /dev/sda1 /mnt/1
mount /dev/sdb1 /mnt/2
mount /dev/sdc1 /mnt/3
mount /dev/sdd1 /mnt/4
mount /dev/sde1 /mnt/5
mount /dev/sdf1 /mnt/6

echo "Copying files over to flash drive..."

cp -rf /home/drew/scripts/GEO_Package/ /mnt/1
cp -rf /home/drew/scripts/GEO_Package/ /mnt/2
cp -rf /home/drew/scripts/GEO_Package/ /mnt/3
cp -rf /home/drew/scripts/GEO_Package/ /mnt/4
cp -rf /home/drew/scripts/GEO_Package/ /mnt/5
cp -rf /home/drew/scripts/GEO_Package/ /mnt/6

umount -f /dev/sd*
echo "Done! Remove these flash drives and load up another tray."

echo "Results:"
lsblk
