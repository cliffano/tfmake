variable "message" {
  type        = string
  default     = "Hello World"
  description = "Message text to transform"
}

variable "module_version" {
  type        = string
  default     = "0.1.0-pre.0"
  description = "Template module version used by release tooling"
}
