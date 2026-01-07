#!/bin/bash

# Buat VM baru
VBoxManage createvm --name "Leakos-Test" --ostype "Linux_64" --register
VBoxManage modifyvm "Leakos-Test" --memory 2048 --vram 16
VBoxManage modifyvm "Leakos-Test" --nic1 nat
VBoxManage modifyvm "Leakos-Test" --graphicscontroller vmsvga

# Buat virtual disk
VBoxManage createmedium disk --filename "Leakos.vdi" --size 8192

# Attach storage
VBoxManage storagectl "Leakos-Test" --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach "Leakos-Test" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "Leakos.vdi"

# Attach ISO (PENTING: IDE Controller untuk CD-ROM)
VBoxManage storagectl "Leakos-Test" --name "IDE Controller" --add ide
VBoxManage storageattach "Leakos-Test" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "leakos-live-*.iso"

# Set boot order: CD-ROM dulu
VBoxManage modifyvm "Leakos-Test" --boot1 dvd --boot2 disk --boot3 none --boot4 none

# Start VM
VBoxManage startvm "Leakos-Test" --type gui
