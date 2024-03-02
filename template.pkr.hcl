
source "virtualbox-iso" "example" {
  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz autoinstall 'ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ---",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_keygroup_interval = "1s"
  boot_wait        = "5s"
  disk_size        = 30720
  format           = "ova"
  guest_os_type    = "ubuntu_64"
  http_directory   = "http"
  iso_checksum     = "sha256:45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2"
  iso_url          = "https://releases.ubuntu.com/22.04/ubuntu-22.04.4-live-server-amd64.iso"
  memory           = 2048
  cpus             = 2
  output_directory = "./output-theplant-kakuyasu-ec-vpn"
  shutdown_command = "sudo -s shutdown -p now"
  ssh_password     = "changeme"
  ssh_username     = "ubuntu"
  ssh_wait_timeout = "10000s"
  vm_name          = "theplant-kakuyasu-ec-vpn"

  vboxmanage = [
    # Allow the VM to access Packer HTTP directory
    # https://github.com/hashicorp/packer/issues/12118#issuecomment-1337627122
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
  ]
}

build {
  sources = [
    "source.virtualbox-iso.example"
  ]
}

