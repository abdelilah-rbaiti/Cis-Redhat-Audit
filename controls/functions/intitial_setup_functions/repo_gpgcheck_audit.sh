#!/usr/bin/env bash

# Function to audit the repo_gpgcheck setting globally and per repository
f_repo_gpgcheck_audit() {
    local global_gpgcheck
    local repo_files
    local REPO_URL="fedoraproject.org"
    local output=""

    # Check global configuration
    echo -e "\n -- Starting Global Configuration Audit --"
    global_gpgcheck=$(grep ^repo_gpgcheck /etc/dnf/dnf.conf)

    if [[ "$global_gpgcheck" == "repo_gpgcheck=1" ]]; then
        output+="\n - Global setting in /etc/dnf/dnf.conf: repo_gpgcheck is enabled"
        output+="\n - Audit Result: ** PASS **"
    else
        output+="\n - Global setting in /etc/dnf/dnf.conf: repo_gpgcheck is not enabled"
        output+="\n - Audit Result: ** FAIL **"
    fi

    # Check per repository configuration
    echo -e "\n -- Starting Per Repository Audit --"
    repo_files=$(grep -l "repo_gpgcheck=0" /etc/yum.repos.d/*)

    if [[ -n "$repo_files" ]]; then
        output+="\n - Repositories with repo_gpgcheck disabled:"
        for repo in $repo_files; do
            if ! grep "${REPO_URL}" "$repo" &>/dev/null; then
                output+="\n   - $repo"
            fi
        done
        output+="\n - Audit Result: ** FAIL **"
    else
        output+="\n - All repositories have repo_gpgcheck enabled"
        output+="\n - Audit Result: ** PASS **"
    fi

    echo -e "$output"
}
