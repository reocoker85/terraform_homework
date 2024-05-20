resource "yandex_compute_disk" "disk" {
  count = var.disk_count
  name  = "disk-${count.index + 1}"
  type  = var.disk_type
  size  = var.disk_size
}


resource "yandex_compute_instance" "storage" {
  name        = var.storage
  hostname    = var.storage_hostname
  platform_id = var.platform

  resources {
    cores         = var.infrastructure.cores
    memory        = var.infrastructure.memory
    core_fraction = var.infrastructure.core_fraction
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  
  dynamic "secondary_disk" {
    for_each  = {for i in yandex_compute_disk.disk[*]: i.name => i}
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.nat
  }

  metadata = var.metadata
}
