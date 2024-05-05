data "template_file" "inventory" {
    template = "${file("compose")}"

    vars = {
        root_pass           = "${random_password.root_pass.result}"
        user_pass           = "${random_password.user_pass.result}" 
    }
    
}

resource "null_resource" "update_inventory" {

    triggers = {
        template = "${data.template_file.inventory.rendered}"
    }

    provisioner "local-exec" {
        command = "echo '${data.template_file.inventory.rendered}' > ./compose.yaml"
    }
}

