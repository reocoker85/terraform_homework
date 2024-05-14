locals {
    vm_name = "${var.instance_name}-${var.platform}"
    vm_db_name  = "${var.vm_db_instance_name}-${var.vm_db_platform}"
}
