variable "azure_tenant_id" {
  type = string
  description = "802fd31a-c0e1-41d0-a03b-1d50c6c702a0"
}

variable "azure_subscription_id" {
  type = string
  description = "38124f02-dea5-441d-9190-d4455ffbe3ee"
}

variable "azure_tag" {
  type = map(string)
  default = {
    생성자 = "최광덕"
    서비스용도 = "Test"
  }
}

#Jump-A
variable "jb-a" {
  type = string
  default = "10.11.1.9"  
}
#Jump-B
variable "jb-b" {
  type = string
  default = "10.11.1.10"  
}
#server-A
variable "sv-a" {
  type = string
  default = "10.12.1.9"  
}
#server-B
variable "sv-b" {
  type = string
  default = "10.12.1.10"  
}

#접속 아이피
variable "Local_ip" {
  type = string
  default = "58.151.57.2"
}
