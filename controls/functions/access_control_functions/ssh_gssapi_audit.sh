#!/usr/bin/env bash

# Function to check sshd GSSAPIAuthentication setting
f_check_gssapi_authentication() {
    local gssapi_auth_output

    # Run the command to check the GSSAPIAuthentication setting
    gssapi_auth_output=$(sshd -T | grep -i gssapiauthentication)

    # Check if the output indicates that GSSAPIAuthentication is set to no
    if [[ "$gssapi_auth_output" == *"gssapiauthentication no"* ]]; then
        echo -e "\n -- Audit Result: ** PASS **"
        echo -e " - GSSAPIAuthentication is set to no."
    else
        echo -e "\n -- Audit Result: ** FAIL **"
        echo -e " - GSSAPIAuthentication is not set to no."
        echo -e " - Current setting: $gssapi_auth_output"
    fi
}