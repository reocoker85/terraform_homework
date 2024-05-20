data "yandex_compute_image" "ubuntu" {
  family = var.family
}

resource "yandex_compute_instance" "web" {

  depends_on = [ yandex_compute_instance.vm ]

  count       = var.web

  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  platform_id = var.platform

  resources {
    cores         = var.infrastructure.cores
    memory        = var.infrastructure.memory
    core_fraction = var.infrastructure.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }                                                                        
  }
                                                                                                                   
  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.nat
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }

  #metadata = var.metadata
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh}"
  }
}
