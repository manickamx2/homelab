output "argocd_client_id" {
  value = authentik_provider_oauth2.argocd.client_id
}

output "argocd_client_secret" {
  value     = authentik_provider_oauth2.argocd.client_secret
  sensitive = true
}
