variable "rgName" {
  default = "ait-terraform-labs"
}

variable "loc" {
  default = "westeurope"
  description = "default resource location"
}

variable "tags" {
  type = "map"
  default = {
      customer = "AIT"
  }
}
