#!/usr/bin/env bash

# Source the functions file
source ../functions/partition_audit.sh
source ../functions/kernel_module_check.sh

# Audit Control 1.1.1.7 'Ensure squashfs kernel module is not available'
echo -e "\n -- Starting Audit 1.1.1.6: Ensure squashfs kernel module is not available --"
f_module_chk "squashfs" "fs"

# Audit Control 1.1.1.7 'Ensure udf kernel module is not available'
echo -e "\n -- Starting Audit 1.1.1.7: Ensure udf kernel module is not available --"
f_module_chk "udf" "fs"

# Audit Control 1.1.2.3.1: Ensure separate partition exists for /home
echo -e "\n -- Starting Audit: Ensure separate partition exists for specified directories --"
f_partition_audit "/home"

# Audit Control 1.1.2.4.1: Ensure separate partition exists for /var
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var --"
f_partition_audit "/var"

# Audit Control 1.1.2.5.1: Ensure separate partition exists for /vat/tmp
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var/tmp --"
f_partition_audit "/var/tmp"

# Audit Control 1.1.2.6.1: Ensure separate partition exists for /var/log
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var/log --"
f_partition_audit "/var/log"

# Audit Control 1.1.2.7.1: Ensure separate partition exists for /var/log/audit
echo -e "\n -- Starting Audit: Ensure separate partition exists for /var/log/audit --"
f_partition_audit "/var/log/audit"









echo -e "\n -- Audit Completed --"
