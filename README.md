Control Centre
==============
[![Services Health Check](https://github.com/GDWR/control-centre/actions/workflows/test.yml/badge.svg?branch=main&event=schedule)](https://github.com/GDWR/control-centre/actions/workflows/test.yml)


Control Centre for all deployments.

This uses Azure and Cloudflare via OpenTofu with some post-deployment testing via Python.


Quick Start
-----------
1. Login with Azure CLI
```bash
az login
```
2. Grab your Cloudflare Token and stick it in a `.env`, use `.env.sample` as template.
3. Run `just`, this will apply (with approval) and then test the deployment.


Commands
--------
Available commands, can be seen with `just -l`.
```yaml
Available recipes:
    apply   # Apply all changes, approval is requested
    clean   # Clean up the environment
    default # Apply all changes, then run basic tests on deployments
    destroy # Destroy deployment, approval is requested
    test    # Run tests against the deployment
```

