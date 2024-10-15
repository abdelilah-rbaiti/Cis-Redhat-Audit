#!/usr/bin/env bash

# Function to audit if a separate partition exists for specified directories
f_partition_audit() {
    local dir_path="$1"
    local output=""
    local partition_check
    partition_check=$(findmnt -kn "$dir_path")

    if [[ -n "$partition_check" ]]; then
        output+="\n\n -- INFO --\n - $dir_path is mounted on a separate partition:\n $partition_check"
        
        # Check for recommended mount options
        if [[ "$partition_check" == *"nosuid"* && "$partition_check" == *"nodev"* && "$partition_check" == *"noexec"* ]]; then
            output+="\n - $dir_path is mounted with recommended options: nosuid, nodev, noexec"
            output+="\n - Audit Result: ** PASS **"
        else
            output+="\n - $dir_path is not mounted with recommended options: nosuid, nodev, noexec"
            output+="\n - Audit Result: ** FAIL **"
        fi
    else
        output+="\n - $dir_path is not mounted on a separate partition"
        output+="\n - Audit Result: ** FAIL **"
    fi

    # Print the output for the current directory
    echo -e "$output"
}
