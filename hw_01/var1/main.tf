variable "yandex_cloud_token" {
  description = "Yandex_cloud_token"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Cloud_id"
  type        = string
  sensitive   = true
}

variable "folder_id" {
  description = "Folder_id"
  type        = string
  sensitive   = true
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
   
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }

  }
  required_version = ">= 1.00"
}


provider "docker" {
  host     = "ssh://user@${yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"] 
}

provider "yandex" {
  token     = var.yandex_cloud_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}
data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}


resource "random_password" "root_pass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "user_pass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "yandex_compute_instance" "instance-based-on-coi" {
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat = true
  }
  resources {
    cores = 2
    memory = 4
    core_fraction = 20
  } 
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = file("./meta.txt")
  }
}

resource "yandex_vpc_network" "devops-network" {
  name = "devops-network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.devops-network.id
  v4_cidr_blocks = ["192.168.10.0/28"]
}


resource "docker_image" "mysql"  {
  name         = "mysql:8"
}

resource "docker_container" "db" {
  image = docker_image.mysql.image_id
  name  = "db"
  env = [
          "MYSQL_ROOT_PASSWORD=${random_password.root_pass.result}",
          "MYSQL_DATABASE=wordpress",
          "MYSQL_USER=wordpress",
          "MYSQL_PASSWORD=${random_password.user_pass.result}",
          "MYSQL_ROOT_HOST=127.0.0.1"  
        ]
  ports {
    internal = 3306
    external = 3306
    ip = "127.0.0.1"
  }
  depends_on   = [
                    docker_image.mysql
                 ]
}


output "external_ip" {
  value = yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address
}

