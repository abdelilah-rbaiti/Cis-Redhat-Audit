#!/usr/bin/env bash

# Source the functions file
source ../functions/logging_auditing_functions/audit_auditd_packages_check.sh
source ../functions/logging_auditing_functions/enabled_prior_to_auditd_check.sh


# Audit Control 6.3.1.1 'Ensure auditd packages are installed'
echo -e "\n -- Starting Audit: Ensure auditd packages are installed --"
f_check_auditd_packages_installed

# Audit Control 6.3.1.2 'Ensure auditing for processes that start prior to auditd is enabled'
echo -e "\n -- Starting Audit: Ensure auditing for processes that start prior to auditd is enabled --"
f_check_audit_enabled_prior_to_auditd

echo -e "\n -- Audit Completed --"