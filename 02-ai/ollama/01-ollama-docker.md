# Deploying an Open WebUI + Ollama language model web interface using Docker[[reference]](https://ivonblog.com/posts/ollama-llm-docker/)
## 1. [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
### 1-1. Uninstall old versions
```sh
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
```
### 1-2. Install using the apt repository
### 1-2-1. Set up Docker's apt repository
```sh
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Update system packages
sudo apt update
```
### 1-2-2. Install the Docker packages
```sh
# Install docker
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# start services
sudo systemctl enable docker
sudo systemctl status docker
sudo systemctl start docker
```
### 1-2-3. Verify that the installation is successful by running the hello-world image
```sh
sudo docker run hello-world
```
## 2. [Installing the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
### 2-1. Installing the NVIDIA Container Toolkit
```sh
sudo apt-get update && sudo apt-get install -y --no-install-recommends curl gnupg2
```
### 2-2. Configure the production repository
```sh
# Configure the production repository
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# configure the repository to use experimental packages
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list
```
### 2-3. Update the packages list from the repository
```sh
sudo apt-get update
```
### 2-4. Install the NVIDIA Container Toolkit packages
```sh
export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.1-1
sudo apt-get install -y nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}
```
### 2-5. Configuring Docker
```sh
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```
## 3. get Open WebUI repository
```sh
git clone https://github.com/open-webui/open-webui.git
cd open-webui
cp .env.example .env
```
## 4. Use docker-compose to start the Open WebUI container service
```sh
# The default is pure CPU calculation:
docker compose -f docker-compose.yaml up -d

# To use Nvidia GPU acceleration, add the `docker-compose.gpu.yaml` file:
docker compose -f docker-compose.yaml -f docker-compose.gpu.yaml up -d

# Ollama's API servers are only accessible through the Open WebUI. If you have other services that need to use Ollama, please use this command to start an additional API server:
docker compose -f docker-compose.yaml -f docker-compose.gpu.yaml -f docker-compose.api.yaml up -d
```
### 4-1. It's worth mentioning here that the contents of the three files can actually be rewritten and merged into a single docker-compose.yml file, for example:
```yml
services:
  ollama:
    volumes:
      - ollama:/root/.ollama
    container_name: ollama
    pull_policy: always
    tty: true
    restart: unless-stopped
    image: ollama/ollama:${OLLAMA_DOCKER_TAG-latest}
    # Expose Ollama API outside the container stack
    ports:
      - ${OLLAMA_WEBAPI_PORT-11434}:11434
    # GPU support
    deploy:
      resources:
        reservations:
          devices:
            - driver: ${OLLAMA_GPU_DRIVER-nvidia}
              count: ${OLLAMA_GPU_COUNT-1}
              capabilities:
                - gpu

  open-webui:
    build:
      context: .
      dockerfile: Dockerfile
    image: ghcr.io/open-webui/open-webui:${WEBUI_DOCKER_TAG-main}
    container_name: open-webui
    volumes:
      - open-webui:/app/backend/data
    depends_on:
      - ollama
    ports:
      - ${OPEN_WEBUI_PORT-3000}:8080
    environment:
      - 'OLLAMA_BASE_URL=http://ollama:11434'
      - 'WEBUI_SECRET_KEY='
    extra_hosts:
      - host.docker.internal:host-gateway
    restart: unless-stopped

volumes:
  ollama: {}
  open-webui: {}
```
## 5. get LLM
```sh
# ex.
sudo docker exec -it ollama ollama pull qwen3-vl:latest
sudo docker exec -it ollama ollama pull qwen3.5:latest
sudo docker exec -it ollama ollama pull llama3.1:latest
sudo docker exec -it ollama ollama pull gemma:7b
```
## 6. check container status
### 6-1. Find the Container ID or Name
```sh
sudo docker ps
```
### 6-2. Stop the Container
```sh
sudo docker stop <CONTAINER_ID_OR_NAME>
```
## 7. update container
### 7-1. Pull newest github data
```sh
sudo git pull origin main
```
### 7-2. Pull updated image
```sh
sudo docker compose pull
```
### 7-3. Recreate containers
```sh
sudo docker compose up -d
```
### 7-4. Prune Old Images
```sh
sudo docker image prune -f
```
## + DEMO +
### **ollama in Docker Desktop state**
![](img/docker-desktop-windows.png "ollama in Docker Desktop state")

### **ollama open webui (chatapp)**
![](img/ollama-open-webui.png "ollama open webui")