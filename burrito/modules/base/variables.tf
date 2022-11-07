variable "env" {
    description = "unique/short environment name"
}

variable "service" {
    description = "unique service name"
    default     = "burrito"
}

locals {
    bucket_name = "${var.service}-${var.env}-${random_pet.server.id}"

}
