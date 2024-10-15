#!/usr/bin/env bash

# Function to check faillock configuration for even_deny_root or root_unlock_time
f_check_faillock_config() {
    local faillock_output
    local root_unlock_time_check

    # Check for even_deny_root or root_unlock_time in faillock.conf
    faillock_output=$(grep -Pi -- '^\h*(even_deny_root|root_unlock_time\h*=\h*\d+)\b' /etc/security/faillock.conf 2>/dev/null)

    # Check if root_unlock_time is set to 60 or more
    root_unlock_time_check=$(grep -Pi -- '^\h*root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/security/faillock.conf 2>/dev/null)

    # Determine if root_unlock_time is properly set
    if [[ -n "$faillock_output" ]]; then
        echo -e "\n -- Audit Result: ** PASS **"
        echo -e " - 'even_deny_root' or 'root_unlock_time' is configured:"
        echo -e "$faillock_output"
        
        # Check if the root_unlock_time is set to 60 or more
        if [[ -z "$root_unlock_time_check" ]]; then
            echo -e " - root_unlock_time is configured correctly (60 seconds or more)."
        else
            echo -e " - root_unlock_time is set to less than 60 seconds, please review:"
            echo -e "$root_unlock_time_check"
        fi
    else
        echo -e "\n -- Audit Result: ** FAIL **"
        echo -e " - Neither 'even_deny_root' nor 'root_unlock_time' is configured."
    fi
}

# Function to check root_unlock_time in pam_faillock.so module
f_check_pam_faillock_config() {
    local pam_faillock_output

    # Check the pam_faillock.so module for root_unlock_time configuration
    pam_faillock_output=$(grep -Pi -- '^\h*auth\h+([^#\n\r]+\h+)pam_faillock\.so\h+([^#\n\r]+\h+)?root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null)

    # Determine if root_unlock_time is properly configured
    if [[ -z "$pam_faillock_output" ]]; then
        echo -e "\n -- PAM Configuration Check: ** PASS **"
        echo -e " - 'root_unlock_time' is set correctly in pam_faillock.so module."
    else
        echo -e "\n -- PAM Configuration Check: ** FAIL **"
        echo -e " - 'root_unlock_time' is set to less than 60 seconds, please review:"
        echo -e "$pam_faillock_output"
    fi
}

# Run the checks
echo -e "\n -- Starting Audit: Ensure password failed attempts lockout includes root account --"
check_faillock_config
check_pam_faillock_config
echo -e "\n -- Audit Completed --"
