# Copyright (c) 2023 RFull Development
# This source code is managed under the MIT license. See LICENSE in the project root.
if [ -z "$DOCKER_GID" ]; then
  echo "Docker gid is not defined. Docker setup skipped."
  exit 0
fi

# refer to https://docs.docker.com/engine/install/ubuntu/
# Installation methods
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Set up the repository
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker client
sudo apt update
sudo apt install -y docker-ce-cli docker-buildx-plugin docker-compose-plugin

# Setup user environment
sudo usermod -aG root $AGENT_USER
