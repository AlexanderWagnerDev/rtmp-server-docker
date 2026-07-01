# RTMP Server for Docker — Alpha

A lightweight RTMP streaming server packaged as a Docker container.

This is the **alpha branch** of `rtmp-server-docker`. It is intended as the future replacement for the current nginx-rtmp based `main` branch and builds [`OpenRTMP/librtmp2-server`](https://github.com/OpenRTMP/librtmp2-server) instead of `nginx-rtmp-module`.

> ⚠️ Alpha: This branch is for testing and development. The stable nginx-rtmp based version is still available on the `main` branch.

## 🚀 Quick Start

```bash
docker run -d \
  --name rtmp-server \
  --restart always \
  -p 8090:8080 \
  -p 1935:1935 \
  -v rtmp-server-data:/data \
  alexanderwagnerdev/rtmp-server:alpha
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

1. **Clone the alpha branch**:
   ```bash
   git clone -b alpha https://github.com/AlexanderWagnerDev/rtmp-server-docker.git
   cd rtmp-server-docker
   ```

2. **Build the image**:
   ```bash
   docker build --no-cache -t rtmp-server:alpha .
   ```

3. **Run the container**:
   ```bash
   docker run -d \
     --name rtmp-server \
     --restart always \
     -p 8090:8080 \
     -p 1935:1935 \
     -v rtmp-server-data:/data \
     rtmp-server:alpha
   ```

## 🐳 Docker Hub

Alpha images should use the `alpha` tag:

```bash
alexanderwagnerdev/rtmp-server:alpha
```

Stable images remain available as:

```bash
alexanderwagnerdev/rtmp-server:latest
```

## 📝 Configuration

### Ports

- **1935**: RTMP streaming port
- **8090 → 8080**: HTTP API and statistics interface

### Persistent data

The container stores the SQLite database in `/data`.

Recommended volume:

```bash
-v rtmp-server-data:/data
```

### Build arguments

The Dockerfile builds `OpenRTMP/librtmp2-server` directly from GitHub.

Default values:

```bash
LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git
LIBRTMP2_SERVER_REF=main
```

You can override them:

```bash
docker build \
  --build-arg LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git \
  --build-arg LIBRTMP2_SERVER_REF=main \
  -t rtmp-server:alpha .
```

### Docker Compose (optional)

```yaml
version: '3'
services:
  rtmp-server:
    image: alexanderwagnerdev/rtmp-server:alpha
    container_name: rtmp-server
    restart: always
    ports:
      - "1935:1935"
      - "8090:8080"
    volumes:
      - rtmp-server-data:/data

volumes:
  rtmp-server-data:
```

---

# RTMP-Server für Docker — Alpha

Ein schlanker RTMP-Streaming-Server als Docker-Container.

Dies ist der **Alpha-Branch** von `rtmp-server-docker`. Dieser Branch ist als zukünftiger Ersatz für den aktuellen nginx-rtmp basierten `main`-Branch gedacht und baut [`OpenRTMP/librtmp2-server`](https://github.com/OpenRTMP/librtmp2-server) statt `nginx-rtmp-module`.

> ⚠️ Alpha: Dieser Branch ist zum Testen und Entwickeln gedacht. Die stabile nginx-rtmp Variante bleibt weiterhin im `main`-Branch.

## 🚀 Schnellstart

```bash
docker run -d \
  --name rtmp-server \
  --restart always \
  -p 8090:8080 \
  -p 1935:1935 \
  -v rtmp-server-data:/data \
  alexanderwagnerdev/rtmp-server:alpha
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

Falls du das Docker-Image selbst erstellen möchtest:

1. **Alpha-Branch klonen**:
   ```bash
   git clone -b alpha https://github.com/AlexanderWagnerDev/rtmp-server-docker.git
   cd rtmp-server-docker
   ```

2. **Image bauen**:
   ```bash
   docker build --no-cache -t rtmp-server:alpha .
   ```

3. **Container starten**:
   ```bash
   docker run -d \
     --name rtmp-server \
     --restart always \
     -p 8090:8080 \
     -p 1935:1935 \
     -v rtmp-server-data:/data \
     rtmp-server:alpha
   ```

## 🐳 Docker Hub

Alpha-Images sollten den `alpha`-Tag verwenden:

```bash
alexanderwagnerdev/rtmp-server:alpha
```

Stabile Images bleiben weiterhin verfügbar als:

```bash
alexanderwagnerdev/rtmp-server:latest
```

## 📝 Konfiguration

### Ports

- **1935**: RTMP-Streaming-Port
- **8090 → 8080**: HTTP API und Statistik-Interface

### Persistente Daten

Der Container speichert die SQLite-Datenbank unter `/data`.

Empfohlenes Volume:

```bash
-v rtmp-server-data:/data
```

### Build-Argumente

Das Dockerfile baut `OpenRTMP/librtmp2-server` direkt von GitHub.

Standardwerte:

```bash
LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git
LIBRTMP2_SERVER_REF=main
```

Du kannst sie überschreiben:

```bash
docker build \
  --build-arg LIBRTMP2_SERVER_REPO=https://github.com/OpenRTMP/librtmp2-server.git \
  --build-arg LIBRTMP2_SERVER_REF=main \
  -t rtmp-server:alpha .
```

### Docker Compose (optional)

```yaml
version: '3'
services:
  rtmp-server:
    image: alexanderwagnerdev/rtmp-server:alpha
    container_name: rtmp-server
    restart: always
    ports:
      - "1935:1935"
      - "8090:8080"
    volumes:
      - rtmp-server-data:/data

volumes:
  rtmp-server-data:
```
