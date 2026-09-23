module "message" {
  source = "../"
}

output "message_original" {
  value = module.message.message_original
}

output "message_reverse" {
  value = module.message.message_reverse
}

output "message_uppercase" {
  value = module.message.message_uppercase
}

output "message_lowercase" {
  value = module.message.message_lowercase
}
