###cloud vars
variable "token" {
  type        = string
  sensitive   = true
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


###vm-count vars
variable "family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS"
}

variable "web" {
  type = number
  default = 2
  description = "Number of VMs"
}

variable "platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform for physical processor"
}

variable "infrastructure" {
  type = map(number)
  default = {
    cores         = 2,
    memory        = 1,
    core_fraction = 5
  }
  description = "VM specifications"
}

variable "preemptible" {
  type        = bool
  default     = true
  description = "VM scheduling policy"
}

variable "nat" {
  type        = bool
  default     = false
  description = "External ip"
}

variable "metadata" {
  type    = object({ serial-port-enable=number, ssh-keys=string })
  default = {
    serial-port-enable = 1
    ssh-keys = "AAAAC3NzaC1lZDI1NTE5AAAAIFGUG+TvrmXYR+bZIlCuTDLzpCFs0skHsUAawaBY1YnA reocoker@reoub"
  }
}


###for_each
variable "each_vm" {
  type = list(object({  vm_name     = string,
                        hostname    = string 
                        platform    = string, 
                        cores       = number, 
                        memory      = number, 
                        core_fr     = number,
                        disk_size   = number, 
                        preemptible = bool, 
                        nat         = bool }))
  default = [
    {
      vm_name     = "master"
      hostname    = "master"
      platform    = "standard-v1"
      cores       = 2
      memory      = 2
      core_fr     = 5
      disk_size   = 5 
      preemptible = true
      nat         = true
    },
    {
      vm_name     = "replica"
      hostname    = "replica"
      platform    = "standard-v1"
      cores       = 4
      memory      = 4
      core_fr     = 20
      disk_size   = 8
      preemptible = true
      nat         = true
    }
  ]
}


###disk_vars
variable "disk_count" {
  type = number
  default = 3
  description = "Number of disks"
}

variable "disk_type" {
  type = string
  default = "network-hdd"
  description = "Disk type"
}

variable "disk_size" {
  type = number
  default = 1
  description = "Disk size"
}

variable "storage" {
  type = string
  default = "storage"
  description = "Name of vm for disks"
}

variable "storage_hostname" {
  type = string
  default = "storage"
  description = "Hostname of vm for disks"
}


###ansible_vars
variable "web_provision" {
  type    = bool
  default = true
  description="ansible provision switch variable"
}
