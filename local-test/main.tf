resource "null_resource" "download-file" {
  provisioner "local-exec" {
    command = <<EOT
    cat /etc/*release*
    EOT
  }
}
