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
}

