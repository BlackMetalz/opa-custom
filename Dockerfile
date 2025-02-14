FROM openpolicyagent/conftest:v0.56.0

# Change working directory first
WORKDIR /project

# No need to create /policy directory since we'll use the working directory
COPY dockerfile-security.rego .

# Modify entrypoint to use the mounted policy file directly
ENTRYPOINT ["conftest", "--policy", "dockerfile-security.rego"]
