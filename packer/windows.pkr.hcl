packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "windows" {
  image  = "mcr.microsoft.com/windows/server:ltsc2022"
  commit = true
}


build {
  name    = "learn-packer"
  sources = [
    "source.docker.windows"
  ]


 provisioner "powershell" {
    inline = [
      # Download the .NET installation script
      "Invoke-WebRequest -Uri 'https://dot.net/v1/dotnet-install.ps1' -OutFile 'dotnet-install.ps1'",

      # Install the .NET SDK
      "& ./dotnet-install.ps1 -InstallDir 'C:\\Program Files\\dotnet'",

      # Add .NET to PATH
      "$env:Path += ';C:\\Program Files\\dotnet'",
      "setx /M PATH $($env:Path)",

      # Verify .NET installation
      "dotnet --version"
    ]
  }
}