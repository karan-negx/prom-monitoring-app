terraform {
    required_providers{
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 3.0"
        }
    }
}

provider "docker" {}

resource "docker_image" "nginx-image" {
    name = "nginx:latest"
}

resource "docker_container" "nginx-container" {
    name = "nginx-server"
    image = docker_image.nginx-image.name
    ports{
        internal = 80
        external = 8080
    }
}

resource "docker_image" "my-python-app-image" {
    name = "my-python-app"
    build {
        context = "${path.module}"
        dockerfile = "${path.module}/Dockerfile"
    }
}

resource "docker_container" "my-python-app-container" {
    count = 10
    name = "my-app-container-${count.index}"
    image = docker_image.my-python-app-image.name
    ports{
        internal = 8000
        external = 8000 + count.index
    }
}





resource "docker_network" "application_network"{
    name = "app_network"
}

resource "docker_image" "app" {
    name = "python-prom-app-image"
    build {
        context = "$(path.module)"
        dockerfile = "${path.module}/Dockerfile"

    }
}

resource "docker_container" "app" {
    name = "python-prom-app"
    image = docker_image.app.name
    ports{
        internal = 8000
        external = 8000
    }
    networks_advanced {
        name = docker_network.application_network.name
    }

}

resource "docker_image" "prometheus" {
    name = "prom/prometheus"
}

resource "docker_container" "prometheus" {
    name = "prometheus"
    image = docker_image.prometheus.name
    ports{
        internal = 9090
        external = 9090
    }
    networks_advanced {
        name = docker_network.application_network.name
    }
    volumes{
        host_path = abspath("$(path.module)/prometheus.yaml")
        container_path = "/etc/prometheus/prometheus.yml"
    }
    volumes{
        host_path = abspath("$(path.module)/alert_rules.yaml")
        container_path = "/etc/prometheus/alert_rules.yml"
    }

}