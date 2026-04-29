variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)

  default = {
    Project = "DevOps-Assignment"
    Owner   = "meghana.menon@company.com"
    User    = "mohan.desappan@company.com"
  }
}