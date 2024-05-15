variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_vpc_name" {
  type        = string
  default     = "develop-db"
  description = "VPC network & subnet name"
}

variable "vm_db_nat" {
  type        = bool
#  default     = true
  default     = false
  description = "External ip"
}



###task2 vars

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS"
}

variable "vm_db_instance_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Instance name"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform for physical processor"
}

#variable "vm_db_infrastructure" {
#  type = map(number)
#  default = {
#    cores         = 2,
#    memory        = 2,
#    core_fraction = 20
#  }
#  description = "VM specifications"
#}


variable "vms_resources" {
  type = map
  default = { 
    web = {
      cores         = 2,
      memory        = 1,
      core_fraction = 5
    }
    db = {
      cores         = 2,
      memory        = 2,
      core_fraction = 20
    }
  }
  description = "VM specifications"
}



variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "VM scheduling policy"
}

#variable "vm_db_port" {
#  type        = number
#  default     = 1
#  description = "Serial-port-enable"
#}

###ssh vars

#variable "vm_db_vms_ssh_root_key" {
#  type        = string
#  description = "ssh-keygen -t ed25519"
#}

variable "metadata" {
  type    = object({ serial-port-enable=number, ssh-keys=string })
  default = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGUG+TvrmXYR+bZIlCuTDLzpCFs0skHsUAawaBY1YnA reocoker@reoub"
  }
}
