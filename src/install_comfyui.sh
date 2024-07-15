#!/bin/bash

pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118
git clone https://github.com/comfyanonymous/ComfyUI
pip install -r ComfyUI/requirements.txt

# For instantid
pip install insightface==0.7.3 onnxruntime onnxruntime-gpu

# make it work as if it doesnt run.