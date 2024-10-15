#!/usr/bin/env bash

# Source the functions file
source ../functions/initial_setup_functions/partition_audit.sh
source ../functions/initial_setup_functions/kernel_module_audit.sh
source ../functions/initial_setup_functions/partition_audit.sh
source ../functions/initial_setup_functions/selinux_audit.sh
source ../functions/initial_setup_functions/gdm_audit.sh
source ../functions/initial_setup_functions/repo_gpgcheck_audit.sh
source ../functions/initial_setup_functions/unconfined_services_audit.sh

# Audit Control 1.1.1.7 'Ensure squashfs kernel module is not available'
echo -e "\n -- Starting Audit: Ensure squashfs kernel module is not available --"
f_module_chk "squashfs" "fs"

# Audit Control 1.1.1.7 'Ensure udf kernel module is not available'
echo -e "\n -- Starting Audit: Ensure udf kernel module is not available --"
f_module_chk "udf" "fs"

# Audit Control 1.1.2.3.1: 'Ensure separate partition exists for /home'
echo -e "\n -- Starting Audit: Ensure separate partition exists for specified directories --"
f_partition_audit "/home"

# Audit Control 1.1.2.4.1: 'Ensure separate partition exists for /var'
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var --"
f_partition_audit "/var"

# Audit Control 1.1.2.5.1: 'Ensure separate partition exists for /vat/tmp'
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var/tmp --"
f_partition_audit "/var/tmp"

# Audit Control 1.1.2.6.1: 'Ensure separate partition exists for /var/log'
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var/log --"
f_partition_audit "/var/log"

# Audit Control 1.1.2.7.1: 'Ensure separate partition exists for /var/log/audit'
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var/log/audit --"
f_partition_audit "/var/log/audit"

# Audit Control 1.2.1.3 'Ensure repo_gpgcheck is globally activated'
echo -e "\n -- Starting Audit: Ensure repo_gpgcheck is globally activated --"
f_repo_gpgcheck_audit

# Audit Control 1.3.1.5 'Ensure the SELinux mode is enforcing'
echo -e "\n -- Starting Audit: Ensure the SELinux mode is enforcing --"
f_selinux_audit 

# Audit Control 1.3.1.6 'Ensure no unconfined services exist'
echo -e "\n -- Starting Audit: Ensure no unconfined services exist --"
f_unconfined_services_audit

# Audit Control 1.8.1: 'Ensure GNOME Display Manager is removed'
echo -e "\n -- Starting Audit: Ensure GNOME Display Manager is removed --"
f_gdm_audit 


echo -e "\n -- Audit Completed --"
