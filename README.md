# Terraform module to Azure APP registrations
Criando um app registrations

O codigo irá prover os seguintes recursos
* []()

## Usage
Example de criação usando o module.

```hcl
module "new_registration" {
    source  = "git@gitlab.uoldiveo.intranet:ump/devtools/terraform-azure-modules/terraform-azure-app_registrations.git?ref=v1.0"

    name            = "CustomerName-CompassoUOL-MGMTCost"
    homepage        = "https://apps.cloudhealthtech.com"
    redirect_uri    = [ "https://apps.cloudhealthtech.com" ]

    expires = "2025-03-25T01:02:03Z"

    # API Permissions    
    required_resource_access   =   [
        {
            # API Name Windows Azure Active Directory
            # Application ID 00000002-0000-0000-c000-000000000000
            resource_app_id = "00000002-0000-0000-c000-000000000000"

            resource_access = [
                {
                    # Sign in and read user profile
                    # Value User.Read
                    id      = "311a71cc-e848-46a1-bdf8-97ff7156d8e6"
                    type    = "Scope"
                }
            ]
        },
        {
            # API Name Microsoft Graph
            # Application ID 00000003-0000-0000-c000-000000000000
            resource_app_id = "00000003-0000-0000-c000-000000000000"

            resource_access = [
                {
                    # Sign in and read user profile
                    # Value User.Read                    
                    id      = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
                    type    = "Scope"
                }
            ]
        }
    ]

    # Application roles are used to assign permissions to users
    app_role    = [
        {
            member_types    = "Application"
            display_name    = "Admin"
            description     = "Admins can manage roles and perform all task actions"
            value           = "Admin"
        }
    ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Variables Inputs
| Name | Description | Required | Type | Default |
| ---- | ----------- | --------- | ---- | ------- |
| name | The name of the aplication and service principal | yes | `string` | `" "` |
| homepage | The URL to the application's home page.| yes | `string` | `" "` |
| redirect_uri | A list of URLs that user tokens are sent to for sign in, or the redirect URIs that OAuth 2.0 authorization codes and access tokens are sent to.  | yes | `list` | `[]` |
| expires | The End Date which the Password is valid until, formatted as a RFC3339 date string (e.g. 2018-01-01T01:02:03Z | yes | `string` | `" "` |
| app_role | A collection of app_role blocks as documented below. For more information https://docs.microsoft.com/en-us/azure/architecture/multitenant-identity/app-roles | yes | `list(map)` | `[ ]` |
| required_resource_access | The block with supports the following, `resource_app_id`, `resource_access` | yes | `list(map)` | `[ ]` |



## Variable Outputs
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
| Name | Description |
| ---- | ----------- |
| name | The application name |
| application_id | The application id |
| object_id | The Object ID |
| secret | The Secret of the service principal |
| reply_urls | The URI web applicataion |
| srv_principal | The name of the service principal |
| srv_princ_object_id | The Object Id Service Principal |
| tenant_id | The Tenant Id of the project |
