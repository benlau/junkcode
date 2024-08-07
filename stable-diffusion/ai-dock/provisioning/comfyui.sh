#!/bin/bash

# Called by the AI Dock to initialize the ComfyUI environment

DEFAULT_PROVISIONING_SCRIPT="https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh"

function run_provisioning_script() {
    echo ubw: Run workspace provisioning script
    TARGET="$1"
    SCRIPT="$2"
    curl -L -o ${TARGET} ${SCRIPT}
    if [[ "$?" -eq 0 ]]; then
        dos2unix ${TARGET}
        chmod +x ${TARGET}
        ${TARGET}
    fi
}

function run_workspace_provisioning_script() {
    for script in `find /workspace -name provisioning.sh`
    do 
        echo ubw: sudo run ${script}
        sudo ${script}    
    done
}

run_workspace_provisioning_script

echo ubw: provisioning script started
run_provisioning_script  /tmp/provision.sh ${DEFAULT_PROVISIONING_SCRIPT}

