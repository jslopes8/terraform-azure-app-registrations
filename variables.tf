variable "create" {
    type    = bool
    default = true
}
variable "app_registration" {
    type    = string
    default = 1
}
variable "name" {
    type    = string
}
variable "homepage" {
    type    = string
}
variable "redirect_uri" {
    type    = list(string)
    default = []
}
variable "available_to_other_tenants" {
    type    = bool
    default = false
}
variable "oauth2_allow_implicit_flow" {
    type    = bool
    default = true
}
variable "expires" {
    type    = string
}
variable "type" {
    type    = string
    default = "webapp/api"
}
variable "member_types" {
    type    = any
    default = [] 
}
variable "required_resource_access" {
    type    = any
    default = [] 
}
variable "app_role" {
    type    = any
    default = [] 
}
variable "app_role_assignment_required" {
    type    = bool
    default = false
}
variable "password" {
    type    = string
    default = ""
}