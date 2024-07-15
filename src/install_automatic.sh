sudo apt-get install libgoogle-perftools4 libtcmalloc-minimal4 -y

cd ~/

wget -q https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh

# REFERENCE: https://stackoverflow.com/a/5789674/1019748
# Get last executed process's PID
PID=$!
# Wait for 2 seconds
sleep 2
# Kill it
kill $PID

cd stable-diffusion-webui

echo "export COMMANDLINE_ARGS=\"--ckpt-dir ~/ComfyUI/models/checkpoints \\" >> webui-user.sh
echo " --hypernetwork-dir ~/ComfyUI/models/hypernetworks \\" >> webui-user.sh
echo " --embeddings-dir ~/ComfyUI/models/embeddings \\" >> webui-user.sh
echo " --lora-dir ~/ComfyUI/models/loras \\" >> webui-user.sh
echo " --xformers\"" >> webui-user.sh


SERVICE_FILE_CONTENT="[Unit]
Description=Automatic1111 Server

[Service]
Type=simple
ExecStart=bash $(pwd)/webui.sh -f



[Install]
WantedBy=multi-user.target"

# Create the systemd service file
echo "$SERVICE_FILE_CONTENT" | sudo tee /etc/systemd/system/automatic.service > /dev/null

# Reload systemd to recognize the new service
sudo systemctl daemon-reload
sudo systemctl enable automatic.service
sudo systemctl start automatic.service

echo " "
echo " ---------------- setup completed "
echo " "
echo -e " ---------------- For health check go to this address $(curl -s httpbin.org/ip | jq -r .origin):7860 in your browser"