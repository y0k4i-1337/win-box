Vagrant.configure("2") do |config|
  config.vm.box = "gusztavvargadr/windows-10"
  config.vm.boot_timeout = 900

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = 4096
    v.cpus = 2
    serial = ENV['HOST_SERIAL'] || ''
    v.customize ["setextradata", :id, "VBoxInternal/Devices/efi/0/Config/DmiSystemSerial", serial]
    v.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]
    v.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end

  config.vm.provision "shell", privileged: "true", inline: <<-'POWERSHELL'
    Set-TimeZone "Coordinated Universal Time"

    # Install boxstarter
    . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

    $env:PSModulePath = "$([System.Environment]::GetEnvironmentVariable('PSModulePath', 'User'));$([System.Environment]::GetEnvironmentVariable('PSModulePath', 'Machine'))"
    # Copy setup.ps1 to the Temp directory and then run boxstarter with our setup.ps1 script
    cp C:\vagrant\scripts\setup.ps1 $env:TEMP
    Import-Module Boxstarter.Chocolatey
    $credential = New-Object System.Management.Automation.PSCredential("vagrant", (ConvertTo-SecureString "vagrant" -AsPlainText -Force))
    Install-BoxstarterPackage -PackageName $env:TEMP\setup.ps1 -Credential $credential
  POWERSHELL
end
