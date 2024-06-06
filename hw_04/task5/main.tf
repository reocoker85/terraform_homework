
module "vpc_dev" {
  source       = "./modules/vpc_dev"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "test_cluster" {
  source     = "./modules/cluster"
  name       = "example"
  network_id = module.vpc_dev.network_id.id
  subnet_id  = module.vpc_dev.subnet_id.id  
}

module "test_db" {
  source     = "./modules/db"
  name_db    = "test"
  name_user  = "app" 
  cluster_id = module.test_cluster.cluster_id
}




#resource "yandex_mdb_mysql_database" "db" {
#  cluster_id = module.test_cluster.cluster_id
#  name       = "db"
#}
#
#resource "yandex_mdb_mysql_user" "user" {
#  cluster_id = module.test_cluster.cluster_id
#  name       = "user"
#  password   = "user1user1"
#  permission {
#    database_name = yandex_mdb_mysql_database.db.name
#    roles         = ["ALL"]
#  }
#}
