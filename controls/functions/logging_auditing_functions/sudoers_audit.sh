#!/usr/bin/env bash


f_check_sudoers_audit() {

    local disk_rules
    disk_rules=$(awk '/^ *-w/ && /\/etc\/sudoers/ && /-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
    
    if [[ "$disk_rules" == *"-w /etc/sudoers -p wa -k scope"* ]] && [[ "$disk_rules" == *"-w /etc/sudoers.d -p wa -k scope"* ]]; then
        echo "Disk rules are correctly configured."
    else
        echo "Disk rules are not correctly configured."
    fi

    echo "Checking running configuration for sudoers audit rules..."
    local loaded_rules
    loaded_rules=$(auditctl -l | awk '/^ *-w/ && /\/etc\/sudoers/ && /-p *wa/ && (/ key= *[!-~]* *$/ || / -k *[!-~]* *$/)')

    if [[ "$loaded_rules" == *"-w /etc/sudoers -p wa -k scope"* ]] && [[ "$loaded_rules" == *"-w /etc/sudoers.d -p wa -k scope"* ]]; then
        echo "Loaded rules are correctly configured."
    else
        echo "Loaded rules are not correctly configured."
    fi
}
