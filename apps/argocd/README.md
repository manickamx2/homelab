# ArgoCD Self-Management

This directory contains the ArgoCD configuration that allows ArgoCD to manage itself.

## Bootstrap Process

1. **Initial Installation (Day 0)**: Run the Ansible playbook to install ArgoCD for the first time:
   ```bash
   ansible-playbook ansible/playbooks/argocd.yml
   ```

2. **Self-Management (Day 1+)**: After the root ApplicationSet is deployed, ArgoCD will automatically pick up this `apps/argocd/` directory and begin managing itself.

## What's Included

- **Base Installation**: ArgoCD stable manifests from upstream
- **KSOPS Integration**: Configured repo-server with KSOPS for SOPS-encrypted secrets
- **SOPS Age Secret**: The Age key for decrypting secrets (managed separately for security)
- **Kustomize Plugins**: Enabled via ConfigMap patch

## Important Notes

- The SOPS Age secret (`sops-age`) is created by Ansible during initial bootstrap
- For production, consider using External Secrets Operator or sealed secrets for the Age key
- Any changes to ArgoCD configuration should be made in this directory and committed to Git
- ArgoCD will automatically sync changes (automated sync enabled in root ApplicationSet)
