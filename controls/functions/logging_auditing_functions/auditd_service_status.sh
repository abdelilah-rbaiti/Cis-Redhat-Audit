#!/usr/bin/env bash

# Function to check if auditd service is enabled and active
f_check_auditd_service() {
    local audit_status="PASS"

    echo "Checking if auditd service is enabled and active..."

    # 1. Check if auditd is enabled
    if systemctl is-enabled auditd | grep -q '^enabled'; then
        echo "auditd service is enabled."
    else
        echo "auditd service is NOT enabled."
        audit_status="FAIL"
    fi

    # 2. Check if auditd is active
    if systemctl is-active auditd | grep -q '^active'; then
        echo "auditd service is active."
    else
        echo "auditd service is NOT active."
        audit_status="FAIL"
    fi

    # 3. Final audit status
    if [ "$audit_status" == "PASS" ]; then
        echo "Audit Status: PASS"
    else
        echo "Audit Status: FAIL"
    fi
}

