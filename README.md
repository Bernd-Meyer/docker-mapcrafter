# docker-mapcrafter
## Usage
docker run -d --name mapcrafter -v ~/output:/output -v ~/config:/config:ro -v ~/world:/world:ro -v /etc/localtime:/etc/localtime:ro be-me/mapcrafter:2.4-1
