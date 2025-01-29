# Inprogess Project Cockpit on Ubuntu

## Commands to install services
    sudo apt install qemu qemu-kvm virt-manager bridge-utils

## Additional Commands
## Add user to appropriate groups
    sudo useradd -g $USER libvirt
    sudo useradd -g $USER libvirt-kvm
## Enable libvirt service
    sudo systemctl enable libvirtd.service && sudo systemctl start libvirtd.service



## Command to install Cockpit module
    sudo apt install cockpit-machines

## Cockpit URL
    https://serverIP:9090/


## Commands to create VM
virt-install \
 --name web_devel \
 --ram 8192 \
 --disk path=/home/doug/vm/web_devel.img,bus=virtio,size=50 \
 --cdrom focal-desktop-amd64.iso \
 --network network=default,model=virtio \
 --graphics vnc,listen=0.0.0.0 --noautoconsole --hvm --vcpus=4

 ## There are many more arguments that can be found in the virt-install manpage. However, explaining those of the example above one by one:

    --name web_devel
        The name of the new virtual machine will be web_devel.
    --ram 8192
        Specifies the amount of memory the virtual machine will use (in megabytes).
    --disk path=/home/doug/vm/web_devel.img,bus=virtio,size=50
        Indicates the path to the virtual disk which can be a file, partition, or logical volume. In this example a file named web_devel.img in the current user’s directory, with a size of 50 gigabytes, and using virtio for the disk bus. Depending on the disk path, virt-install may need to run with elevated privileges.
    --cdrom focal-desktop-amd64.iso
        File to be used as a virtual CD-ROM. The file can be either an ISO file or the path to the host’s CD-ROM device.
    --network
        Provides details related to the VM’s network interface. Here the default network is used, and the interface model is configured for virtio.
    --graphics vnc,listen=0.0.0.0
        Exports the guest’s virtual console using VNC and on all host interfaces. Typically servers have no GUI, so another GUI-based computer on the Local Area Network (LAN) can connect via VNC to complete the installation.
    --noautoconsole
        Will not automatically connect to the virtual machine’s console.
    --hvm
        creates a fully virtualised guest.
    --vcpus=4 
        allocate 4 virtual CPUs.

## Reg Commands for Virtual Windows 11
[HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig]
    "BypassTPMCheck"=dword:00000001
    "BypassSecureBootCheck"=dword:00000001
    "BypassRAMCheck"=dword:00000001
    "BypassStorageCheck"=dword:00000001
    "BypassCPUCheck"=dword:00000001