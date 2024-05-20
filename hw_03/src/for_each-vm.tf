resource "yandex_compute_instance" "vm" {
  for_each = {
    for index, vm in var.each_vm:
    vm.vm_name => vm
  }
  name        = each.value.vm_name
  hostname    = each.value.hostname
  platform_id = each.value.platform

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fr
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_size
    }
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = each.value.nat
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }
  
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh}"
  }
  
}

