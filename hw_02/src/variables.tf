###cloud vars
#variable "token" {
#  type        = string
#  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  sensitive   = true
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive   = true
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
  description = "VPC network & subnet name"
}

variable "nat" {
  type        = bool
#  default     = true
  default     = false
  description = "External ip"
}


###task2 vars

variable "family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS"
}

variable "instance_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instance name"
}

variable "platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform for physical processor"
}

#variable "infrastructure" {
#  type = map(number)
#  default = {
#    cores         = 2,
#    memory        = 1,
#    core_fraction = 5
#  }
#  description = "VM specifications"
#}

variable "preemptible" {
  type        = bool
  default     = true
  description = "VM scheduling policy"
}

#variable "port" {
#  type        = number
#  default     = 1
#  description = "Serial-port-enable"
#}

###ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  description = "ssh-keygen -t ed25519"
#}

###task 8

variable "test" {
  type          = list(map(list(string)))
#  type          = any 
  default       = [
    {
      "dev1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
        "10.0.1.7",
      ]
    },
    {
      "dev2" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
        "10.0.2.29",
      ]
    },
    {
      "prod1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
        "10.0.1.30",
      ]
    },
  ]
}
