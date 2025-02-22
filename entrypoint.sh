#!/bin/sh

# Copy the policy file to the mounted directory
cp /policy/dockerfile-security.rego /project/

# Run conftest with the provided arguments
conftest test --policy /project/dockerfile-security.rego "$@"