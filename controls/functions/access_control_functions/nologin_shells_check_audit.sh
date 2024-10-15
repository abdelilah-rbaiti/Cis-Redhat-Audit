#!/usr/bin/env bash

# Function to check if nologin is listed in /etc/shells
f_check_nologin_in_shells() {
    local NOLOGIN_ENTRY

    NOLOGIN_ENTRY=$(grep -Ps '^\h*([^#\n\r]+)?\/nologin\b' /etc/shells)

    # If grep returns nothing, nologin is not listed
    if [ -z "$NOLOGIN_ENTRY" ]; then
        echo "nologin is not listed in /etc/shells."
        echo "Audit: PASS"
    else
        echo "nologin is listed in /etc/shells, which is not recommended."
        echo "Audit: FAIL"
    fi
}