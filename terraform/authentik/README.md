# authentik Terraform

This root manages authentik groups and the ArgoCD OAuth2/OIDC application.

State is stored in MinIO bucket `terraform-state` at `homelab/authentik/terraform.tfstate`.

Required environment variables:

```sh
export TF_VAR_authentik_token="..."
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."
```

Useful commands:

```sh
terraform init
terraform plan
terraform apply
terraform output -raw argocd_client_secret
```

After the first apply, store `argocd_client_secret` in the SOPS-managed ArgoCD OIDC secret as `oidc.authentik.clientSecret`.
