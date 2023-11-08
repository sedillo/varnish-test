variable "k8s_masters" {
        description = "number of worker instances to be join on cluster."
        default = 2
}
variable "k8s_workers" {
        description = "number of worker instances to be join on cluster."
        default = 2
}

variable "region" {
        description = "AWS Region"
        default = "us-west-1"
}

variable "ubuntu_ami" {
        description = "ubuntu"
        default = "ami-0f8e81a3da6e2510a"
}

variable "k8s_size" {
        default = "t2.medium" #the best type to start k8s with it,
}
