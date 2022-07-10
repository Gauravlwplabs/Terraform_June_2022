resource "null_resource" "provisioner" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_instance.application]
  connection {
      host = aws_instance.bastion-host.public_ip
      type = "ssh"
      user = "ubuntu"
      private_key = file("my-key.pem")
  }
  provisioner "remote-exec" {
    inline = [
       "sudo mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf-bck",   
    ]
    on_failure = continue
  }
  provisioner "file" {
    source = "000-default.conf"
    destination = "/home/ubuntu/000-default.conf"
    on_failure = fail
  }
  provisioner "file" {
    source = "app.wsgi"
    destination = "/home/ubuntu/ansible/app.wsgi"
    on_failure = fail
  }
  provisioner "file" {
    source      = "wsgi.yml"
    destination = "/home/ubuntu/ansible/wsgi.yml"
  }

  provisioner "remote-exec" {
    inline = [
       "sudo mv /home/ubuntu/000-default.conf /etc/apache2/sites-available/",
       "cd /home/ubuntu/ansible",
       "ansible-playbook wsgi.yml -i ${aws_instance.application.private_ip},"
    ]
    on_failure = fail
  }
}