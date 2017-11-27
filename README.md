# docker-mapcrafter

Docker image that runs Mapcrafter on a configurable schedule and with a configurable number of threads.

[Mapcrafter](https://mapcrafter.org) is a high performance Minecraft map renderer written in C++. It renders Minecraft worlds to a bunch of images which are viewable like a Google Map in any webbrowser using Leaflet.js.

## Usage
Specifying the paths to the output directory, the maps are rendered into this directory, and to the Minecraft world directory is mandatory.

The command below runs a container named **mapcrafter** with a default cron schedule (every day at 2:30 am) that runs mapcrafter with 2 threads using the
configuration file **[render.conf](https://github.com/be-me/docker-mapcrafter/blob/master/render.conf)** supplied with the image.

```
docker run -d --name mapcrafter -v <output directory>:/output -v <world directory>:/world:ro -v /etc/localtime:/etc/localtime:ro be-me/mapcrafter:2.4-1
```
## Examples
Todo