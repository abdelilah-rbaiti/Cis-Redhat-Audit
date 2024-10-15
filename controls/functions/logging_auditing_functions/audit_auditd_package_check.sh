#!/usr/bin/env bash

# Function to check the presence of the required packages
f_check_auditd_packages_installed() {
    local packages=("audit" "audit-libs")
    local all_installed=true

    echo "Checking if auditd packages are installed..."

    # Loop through the required packages and check their installation status
    for package in "${packages[@]}"; do
        if rpm -q "$package" > /dev/null 2>&1; then
            echo "$package is installed."
        else
            echo "$package is NOT installed."
            all_installed=false
        fi
    done

    # Return the audit result based on package installation
    if [ "$all_installed" = true ]; then
        echo "Audit Passed: All auditd packages are installed."
        return 0
    else
        echo "Audit Failed: One or more auditd packages are missing."
        return 1
    fi
}