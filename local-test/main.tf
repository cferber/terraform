resource "null_resource" "download-file" {
  provisioner "local-exec" {
    command = <<EOT
    apk add curl
    EOT
  }
}

resource "null_resource" "test-local" {
  provisioner "local-exec" {
    command = <<EOT
    curl -Is https://www.google.de | head -n 1
    EOT
  } 
}
