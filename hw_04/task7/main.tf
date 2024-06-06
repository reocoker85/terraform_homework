resource "vault_generic_secret" "my_first_secret" {
  path = "secret/supersecret"

  data_json = <<EOT
{
  "Netology":   "is the best!"
}
EOT
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

data "vault_generic_secret" "my_first_secret" {
  path = "secret/supersecret"
}


output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

output "my_first_secret" {
  value = nonsensitive(data.vault_generic_secret.my_first_secret.data)
}