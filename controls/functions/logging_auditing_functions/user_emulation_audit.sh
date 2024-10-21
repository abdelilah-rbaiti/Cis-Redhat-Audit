#!/usr/bin/env bash


# functions/check_user_emulation_audit.sh
f_check_user_emulation_audit() {
    echo "Checking disk configuration for user emulation audit rules..."
    local disk_rules
    disk_rules=$(awk '/^ *-a *always,exit/ && /-F *arch=b(32|64)/ && (/ -F *auid!=unset/ || / -F *auid!=-1/ || / -F *auid!=4294967295/) && (/ -C *euid!=uid/ || / -C *uid!=euid/) && / -S *execve/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
    
    if [[ "$disk_rules" == *"-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation"* ]] && [[ "$disk_rules" == *"-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation"* ]]; then
        echo "Disk rules for user emulation are correctly configured."
    else
        echo "Disk rules for user emulation are not correctly configured."
    fi

    echo "Checking running configuration for user emulation audit rules..."
    local loaded_rules
    loaded_rules=$(auditctl -l | awk '/^ *-a *always,exit/ && /-F *arch=b(32|64)/ && (/ -F *auid!=unset/ || / -F *auid!=-1/ || / -F *auid!=4294967295/) && (/ -C *euid!=uid/ || / -C *uid!=euid/) && / -S *execve/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)')

    if [[ "$loaded_rules" == *"-a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"* ]] && [[ "$loaded_rules" == *"-a always,exit -F arch=b32 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation"* ]]; then
        echo "Loaded rules for user emulation are correctly configured."
    else
        echo "Loaded rules for user emulation are not correctly configured."
    fi
}
