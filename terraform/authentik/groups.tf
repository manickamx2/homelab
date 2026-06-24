data "authentik_user" "bootstrap_argocd_admins" {
  for_each = var.bootstrap_argocd_admin_usernames

  username = each.value
}

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
  name  = "argocd-admins"
  users = [for user in data.authentik_user.bootstrap_argocd_admins : user.pk]
}
