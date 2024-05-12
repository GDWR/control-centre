set dotenv-load := true

# If you are not using nix development environment, you may want to change these.
tofu   := "tofu -chdir=src"
python := "python3"

# Apply all changes, then run basic tests on deployments
default:
  just apply
  sleep 10 # Give it atleast some time after deployment.
  just test

# Apply all changes, approval is requested
apply:
  {{tofu}} apply

# Destroy deployment, approval is requested
destroy:
  {{tofu}} destroy

# Run tests against the deployment
test:
  {{python}} -m venv .test-venv
  source .test-venv/bin/activate && \
    pip install --quiet --upgrade pip && \
    pip install --quiet -r test/requirements.txt

  source .test-venv/bin/activate && \
    {{tofu}} output -json | test/main.py

# Clean up the environment
[confirm]
clean:
  rm -rf .test-venv

