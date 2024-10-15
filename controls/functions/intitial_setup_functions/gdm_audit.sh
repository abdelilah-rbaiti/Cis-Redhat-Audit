#!/usr/bin/env bash

f_gdm_audit() {
    gdm_status=$(rpm -q gdm)

    if [[ "$gdm_status" == "package gdm is not installed" ]]; then
        output+="\n - GNOME Display Manager is not installed"
        output+="\n - Audit Result: **PASS**"
    else
        output+="\n - GNOME Display Manager is installed:\n$gdm_status"
        output+="\n - Audit Result: **FAIL**"
    fi
}
