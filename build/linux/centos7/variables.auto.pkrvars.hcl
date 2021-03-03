# ----------------------------------------------------------------------------
# Name:         variables.auto.pkrvars.hcl
# Description:  Common vSphere variables for CentOS 7 Packer builds
# Author:       Michael Poore (@mpoore)
# URL:          https://github.com/v12n-io/packer
# Date:         22/02/2021
# ----------------------------------------------------------------------------

# ISO Settings
os_iso_file         = "CentOS-7-x86_64-DVD-2009.iso"
os_iso_path         = "os/centos/7"

# OS Meta Data
os_family           = "Linux"
os_version          = "CentOS7"

# VM Hardware Settings
vm_cpu_sockets      = 1
vm_cpu_cores        = 1
vm_mem_size         = 2048
vm_nic_type         = "vmxnet3"
vm_disk_controller  = ["pvscsi"]
vm_disk_size        = 16384
vm_disk_thin        = true
vm_cdrom_type       = "sata"

# VM OS Settings
vm_os_type          = "centos7_64Guest"

# Provisioner Settings
script_files        = [ "../../../script/linux/centos/05-repos.sh",
                        "../../../script/linux/centos/10-configure-sshd.sh",
                        "../../../script/linux/centos/20-ansibleuser.sh",
                        "../../../script/linux/centos/40-ssltrust.sh",
                        "../../../script/linux/centos/80-cloudinit.sh",
                        "../../../script/linux/centos/95-motd.sh",
                        "../../../script/linux/centos/99-cleanup.sh" ]
inline_cmds         = [ "yum update -y",
                        "yum reinstall -y ca-certificates" ]