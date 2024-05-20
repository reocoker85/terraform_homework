resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tftpl",

  { webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.vm
    storage    = [yandex_compute_instance.storage]
  }
  )

  filename = "${abspath(path.module)}/inventory.ini"
}


resource "null_resource" "web_hosts_provision" {
  count = var.web_provision == true ? 1 : 0 #var.web_provision ? 1 : 0
  depends_on = [yandex_compute_instance.web]

  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/inventory.ini ${abspath(path.module)}/test.yml"
    on_failure  = continue 
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  triggers = {
    always_run        = "${timestamp()}"              
    playbook_src_hash = file("${abspath(path.module)}/test.yml")
    ssh_public_key    = local.ssh
    template_rendered = "${local_file.inventory.content}"                            
  }

}
