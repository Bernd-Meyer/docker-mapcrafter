# docker-mapcrafter

Docker image that runs Mapcrafter on a configurable schedule and with a configurable number of threads.

[Mapcrafter](https://mapcrafter.org) is a high performance Minecraft map renderer written in C++. It renders Minecraft worlds to a bunch of images which are viewable like a Google Map in any webbrowser using Leaflet.js.

---

## Usage
Specifying the paths to the output directory, the maps are rendered into this directory, and to the Minecraft world directory is mandatory.

The command below runs a container named **mapcrafter** with a default cron schedule (every day at 2:30 am) that runs mapcrafter with 2 threads using the configuration file **[render.conf](https://github.com/be-me/docker-mapcrafter/blob/master/render.conf)** supplied with the image.

```
docker run -d --name mapcrafter -v <output directory>:/output -v <world directory>:/world:ro -v /etc/localtime:/etc/localtime:ro be-me/mapcrafter:2.4-1
```

The next command specifies the path to the directory with your Mapcrafter configuration file. It schedules cron to run Mapcrafter at the specified time with the specified number of threads.

```
docker run -d --name mapcrafter -e CRON_HR=<hr> -e CRON_MIN=<min> -e JOBS=<number of threads> -v <output directory>:/output -v <world directory>:/world:ro -v <config directory>:/config:ro -v /etc/localtime:/etc/localtime:ro be-me/mapcrafter:2.4-1
```

***The config file must be named 'render.conf'. Config file parameter output_dir must point to /output. Config file parameter input_dir must point to /world***.

---

## Available environment variables
### cron
CRON_MIN=<minute> : minute (0 - 59)  
CRON_HR=<hour> : (0 - 23)  
CRON_D=<day> : day of month (1 - 31)  
CRON_M=<month> : month (1 - 12)  
CRON_DOW=<dow> : day of week (0 - 6) (Sunday to Saturday; 7 is also Sunday on some systems)

For more infos about cron visit [Cron Wikipedia](https://en.wikipedia.org/wiki/Cron).

### Mapcrafter
JOBS=<value> : The count of threads to use when rendering the map

---

## Example
Lets say John Doe wants to run Mapcrafter ***each sunday at 1:00 am*** using ***4 threads***.   
He has a special ***render.conf*** file in ***/home/johndoe/config***.   
The map should be generated in ***/home/johndoe/minecraft-map***.   
Minecraft's world directory is located in ***/opt/minecraft/world***.

The command looks like this:

```
docker run -d --name mapcrafter -e CRON_HR=1 -e CRON_MIN=0 -e CRON_DOW=0 -e JOBS=4 -v /home/johndoe/minecraft-map:/output -v /opt/minecraft/world:/world:ro -v /home/johndoe/config:/config:ro -v /etc/localtime:/etc/localtime:ro be-me/mapcrafter:2.4-1
```
