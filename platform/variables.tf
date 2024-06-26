variable "prefix" {
  default     = "demo"
  type        = string
  description = "Prefix for resources"
}

variable "python_runtime" {
  default     = "python3.12"
  description = "Runtime for Python"
  type        = string
}

variable "handler" {
  default     = "lambda_function.lambda_handler"
  type        = string
  description = "Reference to Python start point"
}

variable "region" {
  default     = "ap-southeast-1"
  type        = string
  description = "AWS Region"
}

variable "vault_addr" {
  type    = string
}

variable "vault_namespace" {
  type    = string
  default = "admin"
}