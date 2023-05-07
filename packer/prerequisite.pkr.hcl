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
  run_command = ["-v", "C:\\packer-files:C:\\packer-files", "-i", "-t", "{{.Image}}", "{{.Shell}}"]
}

build {
  name    = "learn-packer"
  sources = [
    "source.docker.windows"
  ]

  provisioner "powershell" {
    inline = [
      "Invoke-WebRequest -Uri 'https://dot.net/v1/dotnet-install.ps1' -OutFile 'dotnet-install.ps1'",

      "& ./dotnet-install.ps1 -InstallDir 'C:\\Program Files\\dotnet'",

      "$env:Path += ';C:\\Program Files\\dotnet'",
      "setx /M PATH $($env:Path)",

      "dotnet --version"
    ]
  }
}
