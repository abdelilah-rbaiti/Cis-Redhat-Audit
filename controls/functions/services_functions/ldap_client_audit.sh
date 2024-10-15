#!/usr/bin/env bash

# Function to audit LDAP client installation
f_ldap_client_audit() {
    # Check if openldap-clients package is installed
    ldap_client_status=$(rpm -q openldap-clients)

    # Determine the audit result
    if [[ "$ldap_client_status" == *"is not installed"* ]]; then
        output+="\n - LDAP client is not installed"
        output+="\n - Audit Result: **PASS**"
    else
        output+="\n - LDAP client is installed:\n$ldap_client_status"
        output+="\n - Audit Result: **FAIL**"
    fi
}

