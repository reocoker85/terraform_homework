variable "network_id" {
  type        = string
}

variable "subnet_id" {
  type        = string
}

variable "name" {
  type        = string
  description = "Cluster name"
}

variable "environment" {
  type        = string
  default     = "PRODUCTION"
  description = "Environment stable or test"
}

variable "ver" {
  type        = string
  default     = "8.0"
  description = "Version of MYSQL"
}


variable "resources" {
    type = map(object({
                        resource_preset_id = string
                        disk_type_id       = string
                        disk_size          = number
    }))
    default = {
               host = {    
                       resource_preset_id = "s1.micro"
                       disk_type_id       = "network-hdd"
                       disk_size          = 10
              }
    }
}



variable "HA" {
   type     = bool
   default  = true
   description = "High Availability"
}
