# RTMP-Server for Docker

For all systems: docker run -d --name rtmp-server --restart always -p 8090:80 -p 1935:1935 alexanderwagnerdev/rtmp-server:latest

## Usage:

Stream-URL: rtmp://ip:1935/publish/{live}

Watch-URL: rtmp://ip:1935/publish/{live}

Stats-URL: http://ip:8090/stats

{live} is your streamkey, that can be anything

## Build Docker Image self:

wget https://raw.githubusercontent.com/AlexanderWagnerDev/rtmp-server-docker/main/Dockerfile

Build Image: docker build --no-cache -t rtmp-server .

Run Container: docker run -d --name rtmp-server --restart always -p 8090:80 -p 1935:1935 rtmp-server

Docker Hub: https://hub.docker.com/r/alexanderwagnerdev/rtmp-server
