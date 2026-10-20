# RTMP Server for Docker

A lightweight RTMP streaming server packaged as a Docker container, perfect for self-hosted streaming solutions.

## 🚀 Quick Start

```bash
docker run -d \
  --name rtmp-server \
  --restart always \
  -p 8090:80 \
  -p 1935:1935 \
  alexanderwagnerdev/rtmp-server:latest
```

## 📖 Usage

- **Stream URL**: `rtmp://YOUR_IP:1935/publish/{streamkey}`
- **Watch URL**: `rtmp://YOUR_IP:1935/publish/{streamkey}`
- **Statistics**: `http://YOUR_IP:8090/stats`

Replace `{streamkey}` with any custom stream key of your choice.

## 🔧 Build from Source

If you prefer to build the Docker image yourself:

1. **Download the Dockerfile**:
   ```bash
   wget https://raw.githubusercontent.com/AlexanderWagnerDev/rtmp-server-docker/main/Dockerfile
   ```

2. **Build the image**:
   ```bash
   docker build --no-cache -t rtmp-server .
   ```

3. **Run the container**:
   ```bash
   docker run -d \
     --name rtmp-server \
     --restart always \
     -p 8090:80 \
     -p 1935:1935 \
     rtmp-server
   ```

## 🐳 Docker Hub

Pre-built images are available on Docker Hub: [alexanderwagnerdev/rtmp-server](https://hub.docker.com/r/alexanderwagnerdev/rtmp-server)

## 📝 Configuration

### Ports
- **1935**: RTMP streaming port
- **8090**: HTTP statistics interface

### Docker Compose (optional)

```yaml
version: '3'
services:
  rtmp-server:
    image: alexanderwagnerdev/rtmp-server:latest
    container_name: rtmp-server
    restart: always
    ports:
      - "1935:1935"
      - "8090:80"
```

---

# RTMP-Server für Docker

Ein schlanker RTMP-Streaming-Server als Docker-Container, ideal für selbstgehostete Streaming-Lösungen.

## 🚀 Schnellstart

```bash
docker run -d \
  --name rtmp-server \
  --restart always \
  -p 8090:80 \
  -p 1935:1935 \
  alexanderwagnerdev/rtmp-server:latest
```

## 📖 Verwendung

- **Stream-URL**: `rtmp://DEINE_IP:1935/publish/{streamkey}`
- **Wiedergabe-URL**: `rtmp://DEINE_IP:1935/publish/{streamkey}`
- **Statistiken**: `http://DEINE_IP:8090/stats`

Ersetze `{streamkey}` mit einem beliebigen Stream-Key deiner Wahl.

## 🔧 Selbst bauen

Falls du das Docker-Image selbst erstellen möchtest:

1. **Dockerfile herunterladen**:
   ```bash
   wget https://raw.githubusercontent.com/AlexanderWagnerDev/rtmp-server-docker/main/Dockerfile
   ```

2. **Image bauen**:
   ```bash
   docker build --no-cache -t rtmp-server .
   ```

3. **Container starten**:
   ```bash
   docker run -d \
     --name rtmp-server \
     --restart always \
     -p 8090:80 \
     -p 1935:1935 \
     rtmp-server
   ```

## 🐳 Docker Hub

Fertige Images sind auf Docker Hub verfügbar: [alexanderwagnerdev/rtmp-server](https://hub.docker.com/r/alexanderwagnerdev/rtmp-server)

## 📝 Konfiguration

### Ports
- **1935**: RTMP-Streaming-Port
- **8090**: HTTP-Statistik-Interface

### Docker Compose (optional)

```yaml
version: '3'
services:
  rtmp-server:
    container_name: rtmp-server
    image: alexanderwagnerdev/rtmp-server:latest
    restart: always
    ports:
      - "1935:1935"
      - "8090:80"
```
