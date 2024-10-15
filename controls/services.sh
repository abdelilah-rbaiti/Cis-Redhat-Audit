#!/usr/bin/env bash

# Source the functions file
source ../functions/services_functions/x_window_audit.sh 
source ../functions/services_functions/ldap_client_audit.sh

# Audit Control 2.1.20: 'Ensure X window server services are not in use'
echo -e "\n -- Starting Audit: Ensure X window server services are not in use --"
f_x_window_audit

# Audit Control 2.2.2: 'Ensure LDAP client is not installed'
echo -e "\n -- Starting Audit: Ensure LDAP client is not installed --"
f_ldap_client_audit

echo -e "\n -- Audit Completed --"