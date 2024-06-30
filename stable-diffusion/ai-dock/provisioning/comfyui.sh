#!/bin/bash

# Called by the AI Dock to initialize the ComfyUI environment

DEFAULT_PROVISIONING_SCRIPT="https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh"

function run_provisioning_script() {
    TARGET="$1"
    SCRIPT="$2"
    curl -L -o ${TARGET} ${SCRIPT}
    if [[ "$?" -eq 0 ]]; then
        dos2unix ${TARGET}
        chmod +x ${TARGET}
        ${TARGET}
    fi
}

run_provisioning_script  /tmp/provision.sh ${DEFAULT_PROVISIONING_SCRIPT}

apt-get update && \
    apt-get install -y -qq aria2 && \
    apt-get clean

micromamba run -n comfyui pip install spandrel matplotlib omegaconf
