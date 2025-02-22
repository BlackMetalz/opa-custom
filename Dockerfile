FROM openpolicyagent/conftest:v0.56.0

# Change working directory first
WORKDIR /project

# Copy the dockerfile-security.rego file into the image
COPY dockerfile-security.rego /policy/

# Copy the entrypoint script into the image
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Use the entrypoint script as the entrypoint
ENTRYPOINT ["entrypoint.sh"]