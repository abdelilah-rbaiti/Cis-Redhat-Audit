#!/usr/bin/env bash

f_check_audit_log_size() {
    local MIN_LOG_SIZE=50  
    local AUDIT_CONF="/etc/audit/auditd.conf"

    if [[ ! -f "$AUDIT_CONF" ]]; then
        echo "FAIL: $AUDIT_CONF not found."
        return 1
    fi

    local max_log_file
    max_log_file=$(grep -Po '^\h*max_log_file\h*=\h*\d+' "$AUDIT_CONF" | grep -Po '\d+')

    if [[ -z "$max_log_file" ]]; then
        echo "FAIL: 'max_log_file' parameter not found in $AUDIT_CONF."
        return 1
    fi

    if [[ "$max_log_file" -lt "$MIN_LOG_SIZE" ]]; then
        echo "FAIL: 'max_log_file' is set to $max_log_file MB, which is below the required minimum of $MIN_LOG_SIZE MB."
        return 1
    else
        echo "PASS: 'max_log_file' is set to $max_log_file MB, which meets or exceeds the required minimum of $MIN_LOG_SIZE MB."
        return 0
    fi
}
