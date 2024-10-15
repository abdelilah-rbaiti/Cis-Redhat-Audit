#!/usr/bin/env bash

f_unconfined_services_audit() {
    unconfined_services=$(ps -eZ | grep unconfined_service_t)

    if [[ -z "$unconfined_services" ]]; then
        output+="\n - No unconfined services exist"
        output+="\n - Audit Result: **PASS**"
    else
        output+="\n - Unconfined services found:\n$unconfined_services"
        output+="\n - Audit Result: **FAIL**"
    fi
}
