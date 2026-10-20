# RTMP Server for Docker

A lightweight RTMP streaming server packaged as a Docker container.

This is the **main branch** of `rtmp-server-docker`. It builds [`OpenRTMP/librtmp2-server`](https://github.com/OpenRTMP/librtmp2-server) instead of the legacy `nginx-rtmp-module` used by earlier releases.

## 🚀 Quick Start

```bash
docker run -d \
  --name rtmp-server \
  --restart unless-stopped \
  -p 8090:8080 \
  -p 1935:1935 \
  -v rtmp-server-data:/data \
  alexanderwagnerdev/rtmp-server:latest
```

## 📖 Usage

- **RTMP Port**: `1935`
- **HTTP/API Port**: `8090` on the host, mapped to `8080` inside the container
- **Health Check**: `http://YOUR_IP:8090/api/v1/health`
- **JSON Stats**: `http://YOUR_IP:8090/stats?key={stats_key}`
- **Nginx-compatible XML Stats**: `http://YOUR_IP:8090/stats-nginx?key={stats_key}`

Streams are managed through the HTTP API. On first startup, `librtmp2-server` generates an API token and prints it once to the container logs.

Show logs:

```bash
docker logs rtmp-server
```

Create a stream:

```bash
curl -X POST http://YOUR_IP:8090/api/v1/streams \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"id":"mystream","name":"My Live Stream","app":"live"}'
```

Use the returned `publish_key` as your stream key.

## 🔧 Build from Source

If you prefer to build the Docker image yourself:

1. **Clone the main branch**:
   ```bash
   git clone -b main https://github.com/AlexanderWagnerDev/rtmp-server-docker.git
   cd rtmp-server-docker
   ```

2. **Build the image**:
   ```bash
   docker build --no-cache -t rtmp-server:latest .
   ```

3. **Run the container**:
   ```bash
   docker run -d \
     --name rtmp-server \
     --restart unless-stopped \
     -p 8090:8080 \
     -p 1935:1935 \
     -v rtmp-server-data:/data \
     rtmp-server:latest
   ```

## 🐳 Docker Hub

Images for this branch use the `latest` tag:

```bash
alexanderwagnerdev/rtmp-server:latest
```

## 📝 Configuration

### Ports

- **1935**: RTMP streaming port
- **8090 → 8080**: HTTP API and statistics interface

### Persistent data

The container stores the SQLite database (streams, keys, and the generated API token) in `/data`. **Mount a volume** so the database survives container recreation — without it, every recreate loses the database and the API token, which will also break any `rtmppanel` instance configured with the old token.

Recommended volume:

```bash
-v rtmp-server-data:/data
```

### Build arguments

The Dockerfile builds `OpenRTMP/librtmp2-server` directly from GitHub.

Default values:

```bash
LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git
LIBRTMP2_SERVER_REF=v0.6.5
```

You can override them:

```bash
docker build \
  --build-arg LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git \
  --build-arg LIBRTMP2_SERVER_REF=v0.6.5 \
  -t rtmp-server:latest .
```

### Docker Compose (optional)

```yaml
version: '3'
services:
  rtmp-server:
    image: alexanderwagnerdev/rtmp-server:latest
    container_name: rtmp-server
    restart: unless-stopped
    ports:
      - "1935:1935"
      - "8090:8080"
    volumes:
      - rtmp-server-data:/data

volumes:
  rtmp-server-data:
```

## 🔗 Related Projects

- [librtmp2-server](https://github.com/OpenRTMP/librtmp2-server) — the RTMP server this image builds
- [rtmppanel-docker](https://github.com/AlexanderWagnerDev/rtmppanel-docker) — web control panel for this server
- [stream-relay-installer](https://github.com/AlexanderWagnerDev/stream-relay-installer) — one-shot installer that wires this image together with rtmppanel, SRTLA and SLSPanel

---

# RTMP-Server für Docker

Ein schlanker RTMP-Streaming-Server als Docker-Container.

Dies ist der **main-Branch** von `rtmp-server-docker`. Er baut [`OpenRTMP/librtmp2-server`](https://github.com/OpenRTMP/librtmp2-server) statt des bisherigen `nginx-rtmp-module` aus früheren Releases.

## 🚀 Schnellstart

```bash
docker run -d \
  --name rtmp-server \
  --restart unless-stopped \
  -p 8090:8080 \
  -p 1935:1935 \
  -v rtmp-server-data:/data \
  alexanderwagnerdev/rtmp-server:latest
```

## 📖 Verwendung

- **RTMP-Port**: `1935`
- **HTTP/API-Port**: `8090` am Host, intern im Container `8080`
- **Healthcheck**: `http://DEINE_IP:8090/api/v1/health`
- **JSON-Statistiken**: `http://DEINE_IP:8090/stats?key={stats_key}`
- **Nginx-kompatible XML-Statistiken**: `http://DEINE_IP:8090/stats-nginx?key={stats_key}`

Streams werden über die HTTP API verwaltet. Beim ersten Start generiert `librtmp2-server` einen API-Token und gibt ihn einmalig in den Container-Logs aus.

Logs anzeigen:

```bash
docker logs rtmp-server
```

Stream erstellen:

```bash
curl -X POST http://DEINE_IP:8090/api/v1/streams \
  -H "Authorization: Bearer DEIN_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"id":"mystream","name":"My Live Stream","app":"live"}'
```

Den zurückgegebenen `publish_key` verwendest du danach als Stream-Key.

## 🔧 Selbst bauen

1. **main-Branch klonen**:
   ```bash
   git clone -b main https://github.com/AlexanderWagnerDev/rtmp-server-docker.git
   cd rtmp-server-docker
   ```

2. **Image bauen**:
   ```bash
   docker build --no-cache -t rtmp-server:latest .
   ```

3. **Container starten**:
   ```bash
   docker run -d \
     --name rtmp-server \
     --restart unless-stopped \
     -p 8090:8080 \
     -p 1935:1935 \
     -v rtmp-server-data:/data \
     rtmp-server:latest
   ```

## 🐳 Docker Hub

Images dieses Branches verwenden den `latest`-Tag:

```bash
alexanderwagnerdev/rtmp-server:latest
```

## 📝 Konfiguration

### Ports

- **1935**: RTMP-Streaming-Port
- **8090 → 8080**: HTTP API und Statistik-Interface

### Persistente Daten

Der Container speichert die SQLite-Datenbank (Streams, Keys und den generierten API-Token) unter `/data`. **Mounte ein Volume**, damit die Datenbank ein Neuerstellen des Containers übersteht — sonst gehen bei jedem Recreate Datenbank und API-Token verloren, was auch eine mit dem alten Token konfigurierte `rtmppanel`-Instanz bricht.

Empfohlenes Volume:

```bash
-v rtmp-server-data:/data
```

### Build-Argumente

Das Dockerfile baut `OpenRTMP/librtmp2-server` direkt von GitHub.

Standardwerte:

```bash
LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git
LIBRTMP2_SERVER_REF=v0.6.5
```

Du kannst sie überschreiben:

```bash
docker build \
  --build-arg LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git \
  --build-arg LIBRTMP2_SERVER_REF=v0.6.5 \
  -t rtmp-server:latest .
```

### Docker Compose (optional)

```yaml
version: '3'
services:
  rtmp-server:
    image: alexanderwagnerdev/rtmp-server:latest
    container_name: rtmp-server
    restart: unless-stopped
    ports:
      - "1935:1935"
      - "8090:8080"
    volumes:
      - rtmp-server-data:/data

volumes:
  rtmp-server-data:
```

## 🔗 Verwandte Projekte

- [librtmp2-server](https://github.com/OpenRTMP/librtmp2-server) — der RTMP-Server, den dieses Image baut
- [rtmppanel-docker](https://github.com/AlexanderWagnerDev/rtmppanel-docker) — Web-Control-Panel für diesen Server
- [stream-relay-installer](https://github.com/AlexanderWagnerDev/stream-relay-installer) — Installer, der dieses Image mit rtmppanel, SRTLA und SLSPanel verbindet

## Migration from nginx / Migration von nginx

The main/latest image now uses OpenRTMP. Recreate with HTTP mapping `8090:8080` and volume `rtmp-server-data:/data`. Create streams in RTMPPanel; arbitrary `/publish/{key}` URLs from nginx are not migrated. Use the publish and playback URLs shown by the panel (their keys may differ). Back up your old configuration before switching.

Das main/latest-Image verwendet jetzt OpenRTMP. Container mit HTTP-Mapping `8090:8080` und Volume `rtmp-server-data:/data` neu erstellen. Streams im RTMPPanel anlegen und dessen Sende- und Wiedergabe-URLs verwenden; bisherige nginx-Keys werden nicht automatisch übernommen. Alte Konfiguration vorher sichern.
