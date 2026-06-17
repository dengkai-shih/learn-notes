
#### 3. Create Docker Compose file
Create a ```docker-compose.yaml``` file. Paste the following in the file:
```yaml
# docker-compose.yaml file
services:
  comfyui:
    build:
      context: .
      dockerfile: Dockerfile
    image: "yanwk/comfyui-boot:cu126-slim"
    container_name: comfyui
    ports:
      #- "8188:8188"
      - ${COMFYUI_PORT-8188}:8188
    volumes:
      # persist your models, output, and settings:
      - comfyui-data:/app/ComfyUI/models

      # persist your output images:
      - comfyui-data:/app/ComfyUI/output
      
      # persist all your settings & extra nodes:
      - comfyui-data:/app/ComfyUI/user/default:rw

      # persist just your saved flows (overrides the workflows/ in default):
      - comfyui-data:/app/ComfyUI/user/default/workflows:rw
    environment:
      - CLI_ARGS=--listen # 加上listen，讓外部網路能存取ComfyUI
    ## GPU support
    # deploy:
    #   resources:
    #     reservations:
    #       devices:
    #         - driver: ${COMFYUI_GPU_DRIVER-nvidia}
    #           count: ${COMFYUI_GPU_COUNT-1}
    #           capabilities:
    #             - gpu
    restart: unless-stopped
    depends_on:
      - ollama
    extra_hosts:
      - host.docker.internal:host-gateway
    networks:
      - web-app-bridge
  volumes:
    comfyui-data: {}

  networks:
    web-app-bridge:
      external: true
```

#### + reference +
<ol>
<li><a href="https://github.com/Comfy-Org" target="_blank">Comfy Org</a></li>
<li><a href="https://github.com/Comfy-Org/ComfyUI-Manager" target="_blank">ComfyUI-Manager</a></li>
<li><a href="https://ivonblog.com/posts/comfyui-docker-installation/" target="_blank">使用Docker部署ComfyUI，建立多個不同用途的AI生圖容器</a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
</ol>