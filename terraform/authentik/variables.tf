variable "authentik_url" {
  description = "Base URL for authentik."
  type        = string
  default     = "https://authentik.manickamx2.com"
}

variable "authentik_token" {
  description = "authentik API token. Set with TF_VAR_authentik_token."
  type        = string
  sensitive   = true
}
