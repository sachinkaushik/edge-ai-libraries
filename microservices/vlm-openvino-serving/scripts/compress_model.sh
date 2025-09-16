#!/bin/bash

# Copyright (C) 2025 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

VLM_MODEL_NAME=$1
VLM_COMPRESSION_WEIGHT_FORMAT=$2
HUGGINGFACE_TOKEN=$3
source $(poetry env info --path)/bin/activate
MODEL_DIR=$(echo $VLM_MODEL_NAME | awk -F/ '{print $NF}')
MODEL_DIR="ov-model/$MODEL_DIR/$VLM_COMPRESSION_WEIGHT_FORMAT"

echo "Model Name: $VLM_MODEL_NAME"
echo "Compression Weight Format: $VLM_COMPRESSION_WEIGHT_FORMAT"
echo "Model Directory: $MODEL_DIR"

# Login to Hugging Face if token is provided and not 'none'
if [ -n "$HUGGINGFACE_TOKEN" ] && [ "$HUGGINGFACE_TOKEN" != "none" ]; then
    echo "Logging in to Hugging Face to access gated models..."
    huggingface-cli login --token "$HUGGINGFACE_TOKEN"
fi

if [ ! -d "$MODEL_DIR" ]; then
    echo "Model directory does not exist. Exporting model..."
    echo "Starting model compression..."
    optimum-cli export openvino --trust-remote-code --model $VLM_MODEL_NAME $MODEL_DIR --weight-format $VLM_COMPRESSION_WEIGHT_FORMAT
    echo "Model exported successfully to $MODEL_DIR"
else
    echo "Model directory already exists. Skipping export."
fi

echo "Model compression script completed."
