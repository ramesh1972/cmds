#!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# Variables
KEY_NAME="id_rsa_linode"
KEY_PATH="c:\\$HOMEPATH\\.ssh\\$KEY_NAME"
REMOTE_USER="root"
REMOTE_HOST="172.235.16.212"
REMOTE_PORT="22" # Default SSH port
REMOTE_DIR="/home/$REMOTE_USER/.ssh"
LOCAL_COPY_DIR="$HOME/.ssh/ssh_keys" # Local directory to copy the key to

# Step 1: Generate SSH Key
if [ -f "$KEY_PATH" ]; then
    echo "SSH key $KEY_PATH already exists."
else
    echo "Generating SSH key..."
    ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -N "" -C "$USER@$(hostname)"
fi

# Step 2: Create Local Directory to Copy the Key (if it doesn't exist)
if [ ! -d "$LOCAL_COPY_DIR" ]; then
    echo "Creating local directory to copy the SSH key..."
    mkdir -p "$LOCAL_COPY_DIR"
fi

# Step 3: Copy SSH Key to Local Directory
echo "Copying SSH key to local directory $LOCAL_COPY_DIR..."
cp "$KEY_PATH" "$LOCAL_COPY_DIR/"
cp "$KEY_PATH.pub" "$LOCAL_COPY_DIR/"

# Step 4: Copy SSH Key to Remote Machine
echo "Copying SSH key to remote machine $REMOTE_USER@$REMOTE_HOST..."
#ssh-copy-id -i "$KEY_PATH" -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST"
cat "$KEY_PATH.pub" | ssh $REMOTE_USER@$REMOTE_HOST "mkdir -p "$REMOTE_DIR/authorized_keys" && cat >> $REMOTE_DIR/authorized_keys/$KEY_NAME.pub"

# Step 5: Verify Key Setup on Remote Machine
echo "Verifying SSH key setup on remote machine..."
ssh -i "$KEY_PATH" -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "echo 'SSH key successfully installed on remote machine!'"

echo "Done!"
