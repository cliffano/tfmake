output "message_original" {
  value       = local.message_original
  description = "Original message text"
}

output "message_reverse" {
  value       = local.message_reverse
  description = "Message text in reverse order"
}

output "message_uppercase" {
  value       = local.message_uppercase
  description = "Message text in upper case"
}

output "message_lowercase" {
  value       = local.message_lowercase
  description = "Message text in lower case"
}

output "module_version" {
  value       = var.module_version
  description = "Template module version"
}
