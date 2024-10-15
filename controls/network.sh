#!/usr/bin/env bash

# Source the functions file
source ../functions/initial_setup_functions/kernel_module_audit.sh 
source ../functions/network_functions/ssh_fd_audit.sh
source ../functions/network_functions/ssh_gssapi_audit.sh

# Audit Control 3.2.1 'Ensure dccp kernel module is not available'
echo -e "\n -- Starting Audit: Ensure dccp kernel module is not available --"
f_module_chk "dccp" "net"

# Audit Control 3.2.2 'Ensure tipc kernel module is not available'
echo -e "\n -- Starting Audit: Ensure tipc kernel module is not available --"
f_module_chk "tipc" "net"

# Audit Control 3.2.3 'Ensure rds kernel module is not available'
echo -e "\n -- Starting Audit: Ensure rds kernel module is not available --"
f_module_chk "rds" "net"

# Audit Control 3.2.4 'Ensure sctp kernel module is not available'
echo -e "\n -- Starting Audit: Ensure sctp kernel module is not available --"
f_module_chk "sctp" "net"

# Audit Control 5.1.10 Ensure sshd DisableForwarding is enabled'
echo -e "\n -- Starting Audit: Ensure sshd DisableForwarding is enabled --"
f_check_disable_forwarding 




echo -e "\n -- Audit Completed --"