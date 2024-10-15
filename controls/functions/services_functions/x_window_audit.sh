#!/usr/bin/env bash

# Function to audit for X Window Server
f_x_window_audit() {
    # Check for the presence of xorg-x11-server-common
    x_window_installed=$(rpm -q xorg-x11-server-common)

    # Determine the audit result
    if [[ "$x_window_installed" == "package xorg-x11-server-common is not installed" ]]; then
        output+="\n - X Window Server is not installed"
        output+="\n - Audit Result: **PASS**"
    else
        output+="\n - X Window Server is installed:\n$x_window_installed"
        output+="\n - Audit Result: **FAIL**"
    fi
}
