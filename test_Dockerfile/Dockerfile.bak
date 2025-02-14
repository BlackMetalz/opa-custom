# Use the official OPA image as the base image
FROM openpolicyagent/opa:latest

# Copy the policy file into the image
COPY policy.rego /etc/opa/policy.rego

# Run OPA with the policy file
CMD ["run", "--server", "/etc/opa/policy.rego"]