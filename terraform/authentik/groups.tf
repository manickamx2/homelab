resource "authentik_group" "homelab_admins" {
  name = "homelab-admins"
}

resource "authentik_group" "homelab_users" {
  name = "homelab-users"
}

resource "authentik_group" "argocd_users" {
  name = "argocd-users"
}

resource "authentik_group" "argocd_admins" {
  name = "argocd-admins"
}
