terraform {
  required_version = "~> 1.14.0"
}

locals {
  message_original  = var.message
  message_reverse   = join("", reverse(regexall(".", var.message)))
  message_uppercase = upper(var.message)
  message_lowercase = lower(var.message)
}
