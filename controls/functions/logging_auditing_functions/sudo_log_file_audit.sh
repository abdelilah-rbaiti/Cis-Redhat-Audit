#!/usr/bin/env bash

# Function to check if sudo log file is being audited
f_check_sudo_log_file_audit() {
    local SUDOERS_CONF="/etc/sudoers"
    local AUDIT_RULES_DIR="/etc/audit/rules.d"
    local sudo_log_file
    local audit_status="PASS"

    # Extract sudo log file path from sudoers configuration
    sudo_log_file=$(grep -r 'logfile=' "$SUDOERS_CONF"* | sed -e 's/.*logfile=//;s/,.*//;s/"//g')

    if [[ -z "$sudo_log_file" ]]; then
        echo "FAIL: Sudo log file not defined in sudoers."
        return 1
    else
        echo "INFO: Sudo log file found: $sudo_log_file"
    fi

    # Check if sudo log file is being audited
    local audit_check
    audit_check=$(awk '/^ *-w/ && /'"${sudo_log_file//\//\\/}"'/ && / +-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' "$AUDIT_RULES_DIR"/*.rules)

    if [[ -z "$audit_check" ]]; then
        echo "FAIL: Sudo log file ($sudo_log_file) is not properly audited."
        audit_status="FAIL"
    else
        echo "PASS: Sudo log file ($sudo_log_file) is properly audited."
    fi

    return 0
}

