package main

# Do Not store secrets in ENV variables
secrets_env = [
    "passwd",
    "password",
    "pass",
    "secret",
    "key",
    "access",
    "api_key",
    "apikey",
    "token",
    "tkn"
]

deny[msg] {    
    input[i].Cmd == "env"
    val := input[i].Value
    contains(lower(val[_]), secrets_env[_])
    msg = sprintf("Line %d: Potential secret in ENV key found: %s", [i, val])
}

# Only use trusted base images
#deny[msg] {
#    input[i].Cmd == "from"
#    val := split(input[i].Value[0], "/")
#    count(val) > 1
#    msg = sprintf("Line %d: use a trusted base image", [i])
#}

# Do not use 'latest' tag for base images
deny[msg] {
    input[i].Cmd == "from"
    val := split(input[i].Value[0], ":")
    contains(lower(val[1]), "latest")
    msg = sprintf("Line %d: do not use 'latest' tag for base images", [i])
}

# Avoid curl bashing
# deny[msg] {
#    input[i].Cmd == "run"
#    val := concat(" ", input[i].Value)
#    matches := regex.find_n("(curl|wget)[^|^>]*[|>]", lower(val), -1)
#    count(matches) > 0
#    msg = sprintf("Line %d: Avoid curl bashing", [i])
# }

# Do not upgrade your system packages
# warn[msg] {
#    input[i].Cmd == "run"
#    val := concat(" ", input[i].Value)
#    matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", lower(val))
#    msg = sprintf("Line %d: Do not upgrade your system packages: %s", [i, val])
# }

# Do not use ADD if possible
deny[msg] {
    input[i].Cmd == "add"
    msg = sprintf("Line %d: Use COPY instead of ADD", [i])
}


# Do not use forbidden users
forbidden_users = [
    "root",
    "toor",
    "0"
]

# Check if root user is used
deny[msg] {
    input[i].Cmd == "user"
    user := input[i].Value[0]  # Get the user value
    contains(lower(user), forbidden_users[_])
    msg = sprintf("Line %d: Running as root user is forbidden", [i])
}

# Do not sudo
deny[msg] {
    input[i].Cmd == "run"
    val := concat(" ", input[i].Value)
    contains(lower(val), "sudo")
    msg = sprintf("Line %d: Do not use 'sudo' command", [i])
}

# This is fucked up 
# Use multi-stage builds
# default multi_stage = false
# multi_stage {
#    input[i].Cmd == "copy"
#    val := concat(" ", input[i].Flags)
#    contains(lower(val), "--from=")
# }

# This is fucked up
#deny[msg] {
#    not multi_stage
#    msg = sprintf("You COPY, but do not appear to use multi-stage builds...", [])
#}