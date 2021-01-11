resource "null_resource" "test-local" {
  provisioner "local-exec" {
    command = <<EOT
    echo "hello"
    EOT
  } 
}
