#!/usr/bin/env bash

# Function to check PASS_MIN_DAYS in /etc/login.defs
f_check_pass_min_days() {
    local MIN_PASS_DAYS=1

    local CURRENT_PASS_DAYS=$(grep -Pi -- '^\h*PASS_MIN_DAYS\h+\d+\b' /etc/login.defs | awk '{print $2}')

    if [ -z "$CURRENT_PASS_DAYS" ]; then
        echo "PASS_MIN_DAYS is not set in /etc/login.defs.."
        echo "Audit: FAIL"
    elif [ "$CURRENT_PASS_DAYS" -ge "$MIN_PASS_DAYS" ]; then
        echo "PASS_MIN_DAYS is set to $CURRENT_PASS_DAYS, which meets the requirement."
        echo "Audit: PASS"
    else
        echo "PASS_MIN_DAYS is set to $CURRENT_PASS_DAYS, which is less than the required $MIN_PASS_DAYS."
        echo "Audit: FAIL"
    fi
}