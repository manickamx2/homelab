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

variable "bootstrap_argocd_admin_usernames" {
  description = "Existing authentik usernames to add to the argocd-admins group."
  type        = set(string)
  default     = []
}
