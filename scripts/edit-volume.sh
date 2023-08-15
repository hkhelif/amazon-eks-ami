#!/bin/bash

# Ensure the script is run with superuser privileges
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# 1.1.3 | Format new volume
echo "Formatting the new volume"
mkfs.xfs /dev/xvdf

# 1.1.3 | Mount new volume
echo "Mounting the new volume to /mnt/home"
mkdir -p /mnt/home
mount -t xfs /dev/xvdf /mnt/home

# 1.1.3 | Copy existing home directory
echo "Copying existing home directory to new volume"
cp -a /home/. /mnt/home/

# 1.1.3 | Unmount new volume
echo "Unmounting the new volume from /mnt/home"
umount /mnt/home

# 1.1.3 | Remove old home directory
echo "Removing old home directory"
rm -rf /home

# 1.1.3 | Create new home directory
echo "Creating new home directory"
mkdir -p /home

# 1.1.3 | Mount new volume to home directory
echo "Mounting the new volume to /home directory"
mount -t xfs -o nodev /dev/xvdf /home

# 1.1.3 | Set /home directory permissions
echo "Setting permissions for /home/ec2-user"
chown ec2-user:ec2-user /home/ec2-user
chmod 0700 /home/ec2-user

echo "Script completed successfully!"