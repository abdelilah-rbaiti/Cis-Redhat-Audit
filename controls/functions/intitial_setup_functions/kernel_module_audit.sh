#!/usr/bin/env bash

# Function to check kernel module status
f_module_chk() {
    local l_mod_name="$1"
    local l_mod_type="$2"
    local l_output3=""
    local l_dl=""
    local a_output=()
    local a_output2=()
    local l_mod_path="$(readlink -f /lib/modules/**/kernel/$l_mod_type | sort -u)"
    local a_showconfig=()

    # Read modprobe config for the module
    while IFS= read -r l_showconfig; do
        a_showconfig+=("$l_showconfig")
    done < <(modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+'"${l_mod_name//-/_}"'\b')

    # Check if the module is loaded
    if ! lsmod | grep "$l_mod_name" &> /dev/null; then
        a_output+=(" - kernel module: \"$l_mod_name\" is not loaded")
    else
        a_output2+=(" - kernel module: \"$l_mod_name\" is loaded")
    fi

    # Check if the module is not loadable
    if grep -Pq -- '\binstall\h+'"${l_mod_name//-/_}"'\h+\/bin\/(true|false)\b' <<< "${a_showconfig[*]}"; then
        a_output+=(" - kernel module: \"$l_mod_name\" is not loadable")
    else
        a_output2+=(" - kernel module: \"$l_mod_name\" is loadable")
    fi

    # Check if the module is deny-listed
    if grep -Pq -- '\bblacklist\h+'"${l_mod_name//-/_}"'\b' <<< "${a_showconfig[*]}"; then
        a_output+=(" - kernel module: \"$l_mod_name\" is deny listed")
    else
        a_output2+=(" - kernel module: \"$l_mod_name\" is not deny listed")
    fi

    # Check if the module exists on the system
    for l_mod_base_directory in $l_mod_path; do
        if [ -d "$l_mod_base_directory/${l_mod_name/-/\/}" ] && [ -n "$(ls -A $l_mod_base_directory/${l_mod_name/-/\/})" ]; then
            l_output3="$l_output3\n - \"$l_mod_base_directory\""
            [ "$l_dl" != "y" ] && f_module_chk "$l_mod_name" "$l_mod_type"
        else
            a_output+=(" - kernel module: \"$l_mod_name\" doesn't exist in \"$l_mod_base_directory\"")
        fi
    done

    # Print info if the module exists
    if [ -n "$l_output3" ]; then
        echo -e "\n\n -- INFO --\n - module: \"$l_mod_name\" exists in:$l_output3"
    fi

    # Determine audit result based on conditions
    if [ "${#a_output[@]}" -gt 0 ]; then
        printf '%s\n' "" "- Audit Result:" " ** PASS **" "${a_output[@]}"
    else
        printf '%s\n' "" "- Audit Result:" " ** FAIL **" " - Reason(s) for audit failure:" "${a_output2[@]}"
    fi
}
