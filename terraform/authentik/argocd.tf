data "authentik_flow" "default_authorization" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "default_invalidation" {
  slug = "default-provider-invalidation-flow"
}

data "authentik_property_mapping_provider_scope" "default_oauth_scopes" {
  managed_list = [
    "goauthentik.io/providers/oauth2/scope-openid",
    "goauthentik.io/providers/oauth2/scope-email",
    "goauthentik.io/providers/oauth2/scope-profile",
  ]
}

data "authentik_certificate_key_pair" "self_signed" {
  name = "authentik Self-signed Certificate"
}

resource "authentik_property_mapping_provider_scope" "groups" {
  name       = "ArgoCD groups"
  scope_name = "groups"
  expression = <<-EOT
    return {
        "groups": [group.name for group in request.user.ak_groups.all()],
    }
  EOT
}

resource "authentik_provider_oauth2" "argocd" {
  name               = "ArgoCD"
  client_id          = "argocd"
  authorization_flow = data.authentik_flow.default_authorization.id
  invalidation_flow  = data.authentik_flow.default_invalidation.id
  signing_key        = data.authentik_certificate_key_pair.self_signed.id

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "https://argocd.manickamx2.com/auth/callback"
    }
  ]

  property_mappings = concat(
    data.authentik_property_mapping_provider_scope.default_oauth_scopes.ids,
    [authentik_property_mapping_provider_scope.groups.id],
  )
}

resource "authentik_application" "argocd" {
  name              = "ArgoCD"
  slug              = "argocd"
  protocol_provider = authentik_provider_oauth2.argocd.id
}

resource "authentik_policy_binding" "argocd_users" {
  target = authentik_application.argocd.uuid
  group  = authentik_group.argocd_users.id
  order  = 0
}

resource "authentik_policy_binding" "argocd_admins" {
  target = authentik_application.argocd.uuid
  group  = authentik_group.argocd_admins.id
  order  = 1
}
