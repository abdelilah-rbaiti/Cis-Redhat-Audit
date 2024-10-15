#!/usr/bin/env bash

# Function to check for NOPASSWD entries in sudoers
f_check_sudo_nopasswd() {
    local sudo_nopasswd_output

    sudo_nopasswd_output=$(grep -r "^[^#].*NOPASSWD" /etc/sudoers* 2>/dev/null)

    if [[ -z "$sudo_nopasswd_output" ]]; then
        echo -e "\n -- Audit Result: ** PASS **"
        echo -e " - Users are required to provide a password for privilege escalation."
    else
        echo -e "\n -- Audit Result: ** FAIL **"
        echo -e " - The following entries allow password-less privilege escalation:"
        echo -e "$sudo_nopasswd_output"
    fi
}
