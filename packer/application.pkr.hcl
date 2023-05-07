packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "windows" {
  image  = "prerequisite:latest" # This is the image built from the prerequisite layer
  commit = true
  run_command = ["-v", "C:\\packer-files:C:\\packer-files", "-i", "-t", "{{.Image}}", "{{if .User}}--user={{.User}}{{end}}", "{{.Shell}}"]
}

build {
  name    = "application"
  sources = [
    "source.docker.windows"
  ]

  provisioner "file" {
    source      = "./app/publish"
    destination = "C:\\inetpub\\wwwroot"
  }
}
