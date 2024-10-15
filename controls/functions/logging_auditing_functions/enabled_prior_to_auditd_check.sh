#!/usr/bin/env bash

f_check_audit_enabled_prior_to_auditd() {
    local audit_param="audit=1"
    local grub_file="/etc/default/grub"

    echo "Checking for auditing for processes that start prior to auditd..."

    # Check if the audit=1 parameter is set in the grubby configuration
    if grubby --info=ALL | grep -qP "\b$audit_param\b"; then
        echo "$audit_param is set in grubby configuration."
    else
        echo "$audit_param is NOT set in grubby configuration."
    fi

    # Check if the audit=1 parameter is set in /etc/default/grub
    if grep -qP "^\h*GRUB_CMDLINE_LINUX=\"([^#\n\r]+\h+)?$audit_param\b" "$grub_file"; then
        echo "$audit_param is set in $grub_file."
    else
        echo "$audit_param is NOT set in $grub_file."
    fi
}