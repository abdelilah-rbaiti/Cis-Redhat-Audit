#!/usr/bin/env bash

f_check_audit_log_retention() {

    local AUDIT_CONF="/etc/audit/auditd.conf"
    local DESIRED_ACTION="keep_logs"

    if [[ ! -f "$AUDIT_CONF" ]]; then
        echo "FAIL: $AUDIT_CONF not found."
        return 1
    fi

    local log_action
    log_action=$(grep -Pso '^\h*max_log_file_action\h*=\h*\w+' "$AUDIT_CONF" | awk -F= '{print $2}' | xargs)

    if [[ -z "$log_action" ]]; then
        echo "FAIL: 'max_log_file_action' parameter not found in $AUDIT_CONF."
        return 1
    elif [[ "$log_action" == "$DESIRED_ACTION" ]]; then
        echo "PASS: 'max_log_file_action' is set to '$log_action'."
        return 0
    else
        echo "FAIL: 'max_log_file_action' is set to '$log_action', expected '$DESIRED_ACTION'."
        return 1
    fi
}

