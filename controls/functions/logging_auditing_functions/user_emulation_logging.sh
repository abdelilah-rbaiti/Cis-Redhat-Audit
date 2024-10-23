#!/usr/bin/env bash

f_check_audit_user_emulation_logging() {
    local AUDIT_RULES_DIR="/etc/audit/rules.d"

    if [[ ! -d "$AUDIT_RULES_DIR" ]]; then
        echo "FAIL: $AUDIT_RULES_DIR directory not found."
        return 1
    fi

    local user_emulation_rule
    user_emulation_rule=$(awk '/^ *-a *always,exit/ \
    && / -F *arch=b(32|64)/ \
    && (/ -F *auid!=unset/ || / -F *auid!=-1/ || / -F *auid!=4294967295/) \
    && (/ -C *euid!=uid/ || / -C *uid!=euid/) \
    && / -S *execve/ \
    && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' "$AUDIT_RULES_DIR"/*.rules)

    if [[ -z "$user_emulation_rule" ]]; then
        echo "FAIL: No matching audit rule found for actions as another user."
        return 1
    else
        echo "PASS: Matching audit rule found for user emulation."
        echo "$user_emulation_rule"
        return 0
    fi
}
