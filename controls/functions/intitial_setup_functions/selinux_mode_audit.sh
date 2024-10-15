#!/usr/bin/env bash

f_selinux_mode_audit() {
    local l_runtime_mode=""
    local l_config_mode=""
    local l_output=""

    l_runtime_mode=$(getenforce)
    l_config_mode=$(grep -i '^SELINUX=' /etc/selinux/config | awk -F= '{print $2}')

    if [[ "$l_runtime_mode" == "Enforcing" ]]; then
        l_output+="\n - SELinux is currently enforcing"
    else
        l_output+="\n - SELinux is NOT enforcing (current runtime mode: $l_runtime_mode)"
    fi

    if [[ "$l_config_mode" == "enforcing" ]]; then
        l_output+="\n - SELinux is configured to be enforcing"
    else
        l_output+="\n - SELinux is NOT configured to be enforcing (configured mode: $l_config_mode)"
    fi

    if [[ "$l_runtime_mode" == "Enforcing" && "$l_config_mode" == "enforcing" ]]; then
        printf '%s\n' "$l_output" "" "- Audit Result: **PASS**"
    else
        printf '%s\n' "$l_output" "" "- Audit Result: **FAIL**"
    fi
}
