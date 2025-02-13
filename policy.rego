package docker.policy

import input

deny contains msg if {
    image := input.image
    image_tag := split(image, ":")[1]
    image_tag == "latest"
    msg := sprintf("Image tag 'latest' is not allowed: %s", [image])
}