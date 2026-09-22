resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1cd"
  instance_type = "t3.micro"

  monitoring = true

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  root_block_device {
    encrypted = true
  }
}
