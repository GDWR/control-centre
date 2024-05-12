# GDWR Infra

Infrastructure deployed to Azure and Cloudflare via OpenTofu. With some post-deployment testing via Python.

1. Login with Azure CLI
```bash
az login
```
2. Grab your Cloudflare Token and stick it in a `.env`, use `.env.sample` as template.
3. Run `just`, this will apply (with approval) and then test the deployment.

---
Available commands, can be seen with `just -l`.
```yaml
Available recipes:
    apply   # Apply all changes, approval is requested
    clean   # Clean up the environment
    default # Apply all changes, then run basic tests on deployments
    destroy # Destroy deployment, approval is requested
    test    # Run tests against the deployment
```

