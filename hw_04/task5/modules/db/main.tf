terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.name_db
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.name_user
  password   = "user1user1"
  permission {
    database_name = yandex_mdb_mysql_database.db.name    
    roles         = ["ALL"]
  }
}
