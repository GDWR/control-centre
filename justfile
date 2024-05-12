set dotenv-load := true

# If you are not using nix development environment, you may want to change these.
tofu   := "tofu -chdir=src"
python := "python3"

# Apply all changes, then run basic tests on deployments
default:
  just refresh
  just apply
  sleep 10 # Give it atleast some time after deployment.
  just test

init:
  {{tofu}} init

# Apply all changes, approval is requested
apply: init
  {{tofu}} apply

# Destroy deployment, approval is requested
destroy: init
  {{tofu}} destroy

# Refresh the deployment state locally
refresh: init
  {{tofu}} refresh

# Setup the test environment
test-venv:
  {{python}} -m venv .test-venv
  source .test-venv/bin/activate && \
    pip install --quiet --upgrade pip && \
    pip install --quiet -r test/requirements.txt

# Run tests against the deployment
test: refresh test-venv
  source .test-venv/bin/activate && \
    {{tofu}} output -json | test/main.py

# Run tests against the deployment, output results as JSON to `./failures.json`
test-ci: refresh test-venv
  source .test-venv/bin/activate && \
    {{tofu}} output -json | test/main.py --json

# Clean up the environment
[confirm]
clean:
  rm -rf .test-venv

