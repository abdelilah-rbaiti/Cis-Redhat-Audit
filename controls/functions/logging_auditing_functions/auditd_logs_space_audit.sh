#!/usr/bin/env bash

f_check_audit_log_space_warnings() {
    local AUDIT_CONF="/etc/audit/auditd.conf"
    local audit_status="PASS"  # Default status

    # Check if audit configuration file exists
    if [[ ! -f "$AUDIT_CONF" ]]; then
        echo "FAIL: $AUDIT_CONF not found."
        audit_status="FAIL"
    fi

    # Check space_left_action configuration
    local space_left_action
    space_left_action=$(grep -Pso '^\h*space_left_action\h*=\h*(email|exec|single|halt)\b' "$AUDIT_CONF")

    if [[ -z "$space_left_action" ]]; then
        echo "FAIL: 'space_left_action' not properly configured."
        audit_status="FAIL"
    else
        echo "PASS: 'space_left_action' is set correctly."
    fi

    # Check admin_space_left_action configuration
    local admin_space_left_action
    admin_space_left_action=$(grep -Pso '^\h*admin_space_left_action\h*=\h*(single|halt)\b' "$AUDIT_CONF")

    if [[ -z "$admin_space_left_action" ]]; then
        echo "FAIL: 'admin_space_left_action' not properly configured."
        audit_status="FAIL"
    else
        echo "PASS: 'admin_space_left_action' is set correctly."
    fi

    # Return final audit status
    if [[ "$audit_status" == "FAIL" ]]; then
        return 1
    else
        return 0
    fi
}
