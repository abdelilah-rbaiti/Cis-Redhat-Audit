#!/usr/bin/env bash

# Source the functions file
source ../functions/access_control_functions/ssh_gssapi_audit.sh
source ../functions/access_control_functions/sudo_password_escalation_audit.sh
source ../functions/access_control_functions/password_lockout_root_audit.sh
source ../functions/access_control_functions/nologin_shells_check_audit.sh
source ../functions/access_control_functions/pass_min_days_audit.sh
source ../functions/access_control_functions/audit_auditd_packages_check.sh


# Audit Control 5.1.10 Ensure sshd DisableForwarding is enabled'
echo -e "\n -- Starting Audit: Ensure sshd DisableForwarding is enabled --"
f_check_disable_forwarding 

# Audit Control 5.2.4 Ensure users must provide password for escalation'
echo -e "\n -- Starting Audit: Ensure users must provide password for escalation --"
f_check_sudo_nopasswd

# Audit Control 5.3.3.1.3 'Ensure password failed attempts lockout includes root account'
echo -e "\n -- Starting Audit: Ensure password failed attempts lockout includes root account --"
f_check_faillock_config
f_check_pam_faillock_config

# Audit Control 5.4.1.2 'Ensure minimum password days is configured'
echo -e "\n -- Starting Audit: Ensure minimum password days is configured --"
f_check_pass_min_day

# Audit Control 5.4.3.1 'Ensure nologin is not listed in /etc/shells'
echo -e "\n -- Starting Audit: Ensure nologin is not listed in /etc/shells --"
f_check_nologin_in_shells

# Audit Control 6.3.1.1 'Ensure auditd packages are installed'
echo -e "\n -- Starting Audit: Ensure auditd packages are installed --"
f_check_auditd_packages_installed

echo -e "\n -- Audit Completed --"