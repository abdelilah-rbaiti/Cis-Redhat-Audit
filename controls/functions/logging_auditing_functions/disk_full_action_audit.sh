#!/usr/bin/env bash

f_check_audit_log_safety_actions() {
    local AUDIT_CONF="/etc/audit/auditd.conf"
    local FULL_ACTIONS="halt|single"
    local ERROR_ACTIONS="syslog|single|halt"

    if [[ ! -f "$AUDIT_CONF" ]]; then
        echo "FAIL: $AUDIT_CONF not found."
        return 1
    fi

    local full_action
    full_action=$(grep -Pso '^\h*disk_full_action\h*=\h*(halt|single)\b' "$AUDIT_CONF" | awk -F= '{print $2}' | xargs)

    if [[ -z "$full_action" ]]; then
        echo "FAIL: 'disk_full_action' not properly configured."
        return 1
    else
        echo "PASS: 'disk_full_action' is set to '$full_action'."
    fi

    local error_action
    error_action=$(grep -Pso '^\h*disk_error_action\h*=\h*(syslog|single|halt)\b' "$AUDIT_CONF" | awk -F= '{print $2}' | xargs)

    if [[ -z "$error_action" ]]; then
        echo "FAIL: 'disk_error_action' not properly configured."
        return 1
    else
        echo "PASS: 'disk_error_action' is set to '$error_action'."
    fi
}

