terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {
  host    = "unix:///var/run/docker.sock"
}
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "brendacruz25"  // Cambiarla dinámicamente por la Variable env.DOCKER_REPO que está en el Jenkins 
  ports {
    internal = 80
    external = 81  // Cambiarla dinámicamente por la variable CONTAINER_PORT que está en el Jenkins
  }
}
