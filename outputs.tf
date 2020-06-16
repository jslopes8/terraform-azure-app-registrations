output "name" {
    value   = element(azuread_application.main.*.name, 0)
}
output "application_id" {
    value   = element(azuread_application.main.*.application_id, 0)
}
output "object_id" {
    value   = element(azuread_application.main.*.object_id, 0)
}
output "secret" {
    value       = element(azuread_service_principal_password.main.*.value, 0)
    sensitive   = true
}
output "reply_urls" {
    value   = tolist(element(azuread_application.main.*.reply_urls, 0))[0]
}
output "srv_principal" {
    value = element(azuread_service_principal.main.*.display_name, 0) 
}
output "srv_princ_object_id" {
    value = element(azuread_service_principal.main.*.object_id, 0) 
}
output "tenant_id" {
    value   = data.azuread_client_config.current.tenant_id
}
