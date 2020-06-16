data "azuread_client_config" "current" {
}

resource "azuread_application" "main" {
    count   = var.create ? length(var.app_registration) : 0

    name                        = var.name
    homepage                    = var.homepage
    reply_urls                  = var.redirect_uri
    available_to_other_tenants  = var.available_to_other_tenants
    oauth2_allow_implicit_flow  = var.oauth2_allow_implicit_flow

    dynamic "required_resource_access" {
        for_each    = var.required_resource_access
        content {
            resource_app_id = required_resource_access.value.resource_app_id

            dynamic "resource_access" {
                for_each    = required_resource_access.value.resource_access

                content {
                    id      = resource_access.value.id
                    type    = resource_access.value.type
                }
            }
        }
    }

    dynamic "app_role" {
        for_each    = var.app_role

        content {
            allowed_member_types    = split(",", lookup(var.app_role[count.index], "member_types", join(",", var.member_types),)) 
            description             = app_role.value.description
            display_name            = app_role.value.display_name
            value                   = app_role.value.value
        }

    }
}
resource "azuread_service_principal" "main" {
    count   = var.create ? length(var.app_registration) : 0

    application_id               = element(azuread_application.main.*.application_id, count.index)
    app_role_assignment_required = var.app_role_assignment_required
}

resource "random_password" "main" {
    count   = var.password == "" ? 1 : 0

    length  = 32
    special = false
}

resource "azuread_service_principal_password" "main" {
    count   = var.create ? length(var.app_registration) : 0

    service_principal_id = element(azuread_service_principal.main.*.id, count.index)

    value                = coalesce(var.password, random_password.main[0].result)
    end_date             = var.expires
}

resource "azuread_application_password" "main" {
    count   = var.create ? length(var.app_registration) : 0

    application_object_id = element(azuread_application.main.*.id, count.index)

    value       = element(azuread_service_principal_password.main.*.value, 0)
    end_date    = var.expires
}
