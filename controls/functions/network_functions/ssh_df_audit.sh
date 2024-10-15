#!/usr/bin/env bash

# Function to check sshd DisableForwarding setting
f_check_disable_forwarding() {
    local disable_forwarding_output

    # Run the command to check the DisableForwarding setting
    disable_forwarding_output=$(sshd -T | grep -i disableforwarding)

    # Check if the output indicates that DisableForwarding is set to yes
    if [[ "$disable_forwarding_output" == *"disableforwarding yes"* ]]; then
        echo -e "\n -- Audit Result: ** PASS **"
        echo -e " - DisableForwarding is set to yes."
    else
        echo -e "\n -- Audit Result: ** FAIL **"
        echo -e " - DisableForwarding is not set to yes."
        echo -e " - Current setting: $disable_forwarding_output"
    fi
}