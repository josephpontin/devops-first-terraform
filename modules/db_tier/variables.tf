# Values of these variables are set when the module is called in the main main.tf file

variable "app_sg_id"{
  description = "sg id of app"
}

variable "instance_name"{
  description = "the name of the instanc to be created"
}
variable "vpc_id"{
  description = "the vpc id where the app is to be launched"
}

variable "ami_db_id"{
  description = "id of the ami"
}
