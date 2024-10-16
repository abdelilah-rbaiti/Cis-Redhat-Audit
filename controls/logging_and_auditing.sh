#!/usr/bin/env bash

# Source the functions file
source ../functions/logging_auditing_functions/audit_auditd_packages_check.sh
source ../functions/logging_auditing_functions/enabled_prior_to_auditd_check.sh
source ../functions/logging_auditing_functions/audit_bachlog_limit.sh
source ../functions/access_control_functions/audit_auditd_packages_check.sh
source ../functions/access_control_functions/max_log_file_action.sh
source ../functions/access_control_functions/disk_full_action_audit.sh


# Audit Control 6.3.1.1 'Ensure auditd packages are installed'
echo -e "\n -- Starting Audit: Ensure auditd packages are installed --"
f_check_auditd_packages_installed

# Audit Control 6.3.1.2 'Ensure auditing for processes that start prior to auditd is enabled'
echo -e "\n -- Starting Audit: Ensure auditing for processes that start prior to auditd is enabled --"
f_check_audit_enabled_prior_to_auditd

# Audit Control 6.3.1.3 'Ensure audit_backlog_limit is sufficient'
echo -e "\n -- Starting Audit: Ensure audit_backlog_limit is sufficient --"
f_check_audit_backlog_limit

# Audit Control 6.3.1.4 'Ensure auditd service is enabled and active'
echo -e "\n -- Starting Audit: Ensure auditd service is enabled and active --"
f_check_auditd_service

# Audit Control 6.3.2.1 'Ensure audit log storage size is configured'
echo -e "\n -- Starting Audit: Ensure audit log storage size is configured --"
f_check_audit_log_size

# Audit Control 6.3.2.2 'Ensure audit logs are not automatically deleted'
echo -e "\n -- Starting Audit: Ensure audit logs are not automatically deleted --"
f_check_audit_log_retention

# Audit Control 6.3.2.3 'Ensure system is disabled when audit logs are full'
echo -e "\n -- Starting Audit: Ensure system is disabled when audit logs are full --"
f_check_audit_log_safety_actions


echo -e "\n -- Audit Completed --"