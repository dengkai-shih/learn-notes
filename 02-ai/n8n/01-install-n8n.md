#### 1. Create an ```.env``` file
Create a project directory to store your n8n environment configuration and Docker Compose files and navigate inside:
```sh
mkdir n8n-compose
cd n8n-compose
```
Inside the ```n8n-compose``` directory, create an ```.env``` file to customize your n8n instance's details. Change it to match your own information:
```ini
# .env file
# DOMAIN_NAME and SUBDOMAIN together determine where n8n will be reachable from
# The top level domain to serve from
DOMAIN_NAME=example.com

# The subdomain to serve from
SUBDOMAIN=n8n

# The above example serve n8n at: https://n8n.example.com

# Optional timezone to set which gets used by Cron and other scheduling nodes
# New York is the default value if not set
GENERIC_TIMEZONE=Asia/Taipei

# The email address to use for the TLS/SSL certificate creation
SSL_EMAIL=user@example.com
```
#### 2. Create local files directory
Inside your project directory, create a directory called local-files for sharing files between the n8n instance and the host system (for example, using the Read/Write Files from Disk node):
```sh
mkdir local-files
```

The Docker Compose file below can automatically create this directory, but doing it manually ensures that it's created with the right ownership and permissions.

#### 3. Create Docker Networks
```sh
sudo docker create network web-app-bridge
```

#### 4. Create Docker Compose file
Create a ```docker-compose.yaml``` file. Paste the following in the file:
```yaml
# docker-compose.yaml file
services:
  traefik:
    image: "traefik"
    container_name: traefik
    restart: always
    command:
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entrypoint.scheme=https"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.mytlschallenge.acme.tlschallenge=true"
      - "--certificatesresolvers.mytlschallenge.acme.email=${SSL_EMAIL}"
      - "--certificatesresolvers.mytlschallenge.acme.storage=/letsencrypt/acme.json"
    ports:
      #- "80:80"
      #- "443:443"
      - ${TRAEFIK_PORT_80-80}:80
      - ${TRAEFIK_PORT_443-443}:443
    volumes:
      - traefik_data:/letsencrypt
      - /var/run/docker.sock:/var/run/docker.sock:ro
    networks:
      - web-app-bridge

  n8n:
    image: docker.n8n.io/n8nio/n8n:latest
    container_name: n8n
    restart: always
    ports:
      #- "127.0.0.1:5678:5678"
      - ${N8N_WEBAPI_PORT-5678}:5678
    labels:
      - traefik.enable=true
      - traefik.http.routers.n8n.rule=Host(`${SUBDOMAIN}.${DOMAIN_NAME}`)
      - traefik.http.routers.n8n.tls=true
      - traefik.http.routers.n8n.entrypoints=web,websecure
      - traefik.http.routers.n8n.tls.certresolver=mytlschallenge
      - traefik.http.middlewares.n8n.headers.SSLRedirect=true
      - traefik.http.middlewares.n8n.headers.STSSeconds=315360000
      - traefik.http.middlewares.n8n.headers.browserXSSFilter=true
      - traefik.http.middlewares.n8n.headers.contentTypeNosniff=true
      - traefik.http.middlewares.n8n.headers.forceSTSHeader=true
      - traefik.http.middlewares.n8n.headers.SSLHost=${DOMAIN_NAME}
      - traefik.http.middlewares.n8n.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.n8n.headers.STSPreload=true
      - traefik.http.routers.n8n.middlewares=n8n@docker
    environment:
      - N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
      - N8N_HOST=${SUBDOMAIN}.${DOMAIN_NAME}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https  
      - NODE_ENV=production
      - WEBHOOK_URL=https://${SUBDOMAIN}.${DOMAIN_NAME}/
      - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
      - TZ=${GENERIC_TIMEZONE}
    volumes:
      - n8n_data:/home/node/.n8n
      - ./local-files:/files
    depends_on:
      - ollama
    extra_hosts:
      - host.docker.internal:host-gateway
    networks:
      - web-app-bridge

volumes:
  n8n_data: {}
  traefik_data: {}

networks:
  web-app-bridge:
    external: true
```

#### 

#### + reference +
<ol>
<li><a href="https://docs.n8n.io/hosting/installation/server-setups/docker-compose/" target="_blank">Hosting n8n Docker-Compose</a></li>
<li><a href="https://github.com/n8n-io/n8n" target="_blank">n8n - Secure Workflow Automation for Technical Teams</a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
</ol>
