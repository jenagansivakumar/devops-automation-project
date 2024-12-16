variable "region" {
  type = string
}
variable "ami_id" {
  type    = string
  default = "ami-05edb7c94b324f73c"
}
variable "instance_type" {
  type = string
}
variable "availability_zone" {
  type = map(string)
}

variable "vpc_name" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
variable "subnets" {
  type = any
}
variable "tg" {
  type = any
}
variable "sg" {
  type = any
}
variable "instances" {
  type = any
}
variable "rt_name" {
  type = string
}
variable "rt_cidr_block" {
  type = string
}
variable "alb_name" {
  type = string
}
variable "alb_type" {
  type = string
}
variable "alb_internal" {
  type = bool
}
variable "alb_deletion_protection" {
  type = bool
}
variable "alb_cross_zone" {
  type = bool
}
variable "alb_idle_timeout" {
  type = number
}
variable "igw" {
  type = string
}
