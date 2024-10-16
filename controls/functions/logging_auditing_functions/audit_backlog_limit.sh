#!/usr/bin/env bash

# Function to check if audit_backlog_limit is sufficient
f_check_audit_backlog_limit() {
    local min_backlog_limit=8192  
    local audit_status="PASS"     

    backlog_limit=$(grubby --info=ALL | grep -Po "\baudit_backlog_limit=\d+\b")
    if [ -n "$backlog_limit" ]; then
        local current_limit=${backlog_limit##*=}
        echo "Current audit_backlog_limit from grubby: $current_limit"

        if [[ "$current_limit" -ge "$min_backlog_limit" ]]; then
            echo "audit_backlog_limit is sufficient in grubby (current: $current_limit)."
        else
            echo "audit_backlog_limit is insufficient in grubby (current: $current_limit). Recommended: $min_backlog_limit or larger."
            audit_status="FAIL"
        fi
    else
        echo "audit_backlog_limit is NOT set in grubby configuration."
        audit_status="FAIL"
    fi

    # 2. Check audit_backlog_limit in /etc/default/grub
    if grep -Psoq '^\h*GRUB_CMDLINE_LINUX=\"([^#\n\r]+\h+)?\baudit_backlog_limit=\d+\b' /etc/default/grub; then
        local grub_backlog=$(grep -Pso -- '^\h*GRUB_CMDLINE_LINUX=\"([^#\n\r]+\h+)?\baudit_backlog_limit=\d+\b' /etc/default/grub | grep -Po "\baudit_backlog_limit=\d+\b" | head -1)
        local grub_backlog_limit=${grub_backlog##*=}
        echo "Current audit_backlog_limit from /etc/default/grub: $grub_backlog_limit"

        if [[ "$grub_backlog_limit" -ge "$min_backlog_limit" ]]; then
            echo "audit_backlog_limit is sufficient in /etc/default/grub (current: $grub_backlog_limit)."
        else
            echo "audit_backlog_limit is insufficient in /etc/default/grub (current: $grub_backlog_limit). Recommended: $min_backlog_limit or larger."
            audit_status="FAIL"
        fi
    else
        echo "audit_backlog_limit is NOT set in /etc/default/grub."
        audit_status="FAIL"
    fi

    # 3. Final audit status
    if [ "$audit_status" == "PASS" ]; then
        echo "Audit Status: PASS"
    else
        echo "Audit Status: FAIL"
    fi
}

