# Values of these variables are set when the module is called in the main main.tf file

variable "vpc_id"{
  description = "the vpc id where the app is to be launched"
}
variable "instance_name"{
  description = "the name of the instanc to be created"
}

variable "ig_id"{
  description = "id of internet gateway"
}

variable "ami_id"{
  description = "id of the ami"
}
