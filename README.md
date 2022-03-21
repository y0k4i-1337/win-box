# win-box
Vagrant Windows box

Spawn a Windows box based on [gusztavvargadr/windows-10](https://app.vagrantup.com/gusztavvargadr/boxes/windows-10) image.

## Getting Started

Getting a box up and running is as easy as running:

```
vagrant up
```

### Provisioning

Provisioning is made using SHELL mode with the help of [Boxstarter](https://boxstarter.org/). Please, note that the VM could reboot one or more times in order to perform all the steps configured in [setup file](scripts/setup.ps1).

## Softwares

The included provisioning script will install the following softwares:

  - Programs:
    - Google Chrome
    - Firefox
    - 7zip
    - Git
    - Notepad++
    - WSL
  - Powershell Modules:
    - MSOnline
    - AzureAD
  - Google Chrome addons:
    - Endpoint Verification

## Setting Guest Serial Number

In case you need your guest VM to have the same serial number as your host, you need to perform some extra steps.

### Linux Host

Assign the serial number to a variable called `HOST_SERIAL` **BEFORE** running `vagrant up`. For instance:

```
HOST_SERIAL=`sudo dmidecode -s system-serial-number`
````

You can do this manually with `VBoxManage`:

```
VBoxManage setextradata "vm name" VBoxInternal/Devices/efi/0/Config/DmiSystemSerial "serial"
```

**Note**: if your are NOT using EFI, change `efi` to `pcbios` in the command above.

Restart service in order to apply your changes:

```
systemctl restart virtualbox.service
```
