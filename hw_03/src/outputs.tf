output "compute" {
  value = flatten([[
    for compute in yandex_compute_instance.web : [
      {
        name = compute.name
        id   = compute.id
        fqdn = compute.fqdn
      }
    ]
    ],
  [for compute in yandex_compute_instance.vm : [
      {
        name = compute.name
        id   = compute.id
        fqdn = compute.fqdn
      }
    ]
]])
}