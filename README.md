# Usage
```
# Without -w you'd need to specify full path
docker run --rm -v $(pwd):/project openpolicyagent/conftest --policy /project/dockerfile-security.rego test /project/Dockerfile

# With -w it's cleaner
docker run --rm -v $(pwd):/project -w /project openpolicyagent/conftest --policy dockerfile-security.rego test Dockerfile
```

- The name of Dockerfile should be alway `Dockerfile`. I was tried with `Dockerfile_test` and it doesn't works!
- The policy is updated from outdate repo in Ref section with help of AI Bot xD

# Build image with custom policy for better integrate into pipeline!
```
docker run --rm -v $(pwd):/project kienlt992/opa-custom:v0.56.0 Dockerfile

5 tests, 5 passed, 0 warnings, 0 failures, 0 exceptions
```

# Ref:
- https://github.com/gbrindisi/dockerfile-security/blob/main/dockerfile-security.rego