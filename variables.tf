variable "network_1" {
  description = "Nombre de la red 1"
  type        = string
  default = "Net1"
}

variable "network_2" {
  description = "Nombre de la red 2"
  type        = string
  default = "Net2"
}

variable "subnet_1" {
  description = "Nombre de la subred 1"
  type        = map(string)
  default = {
    subnet_name = "Subnet1"
    cidr        = "10.0.1.0/24"
  }
}

variable "subnet_2" {
  description = "Nombre de la subred 2"
  type        = map(string)
  default = {
    subnet_name = "Subnet2"
    cidr        = "10.0.2.0/24"
  }
}

variable "external_network_name" {
  description = "Nombre de la red externa"
  default = "ExtNet"
}

variable "dns_ip" {
  description = "Para configurar route a internet"
  type    = list(string)
  default = ["8.8.8.8", "8.8.8.4"]
}

variable "ip_default" {
  description = "Ip por defecto"
  type = string
  default = "0.0.0.0/0"
}
