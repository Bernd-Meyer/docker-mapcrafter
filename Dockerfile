ARG DEBIAN_VERSION=jessie
FROM debian:$DEBIAN_VERSION

LABEL maintainer="Bernd Meyer <be.me@posteo.de>"

ARG DEBIAN_VERSION
ENV MAPCRAFTER_VERSION=2.4-1
ENV JOBS=1

# cron: minute (0 - 59)
ARG min=30
# cron: hour (0 - 23)
ARG hr=2
# cron: day (1 - 31)
ARG day=*
# cron: month (1 - 12)
ARG month=*
# cron: day of week (0 - 7, sunday is 0 or 7)
ARG dow=*

VOLUME ["/config", "/output", "/world"]

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
	apt-transport-https \
	ca-certificates\
	cron \
	wget && \
    echo "deb http://packages.mapcrafter.org/debian $DEBIAN_VERSION main" > /etc/apt/sources.list.d/mapcrafter.list && \
    wget -O /etc/apt/trusted.gpg.d/mapcrafter.gpg http://packages.mapcrafter.org/debian/keyring.gpg && \
    apt-get update && \
    apt-get -y install --no-install-recommends \
	imagemagick \
	mapcrafter=$MAPCRAFTER_VERSION \
	python && \
    apt-get -y remove --purge \
	apt-transport-https \
	ca-certificates \
	imagemagick \
	python \
	wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run-mapcrafter /run-mapcrafter
ADD render.conf /

RUN printf "%s %s %s %s %s root /run-mapcrafter >>/var/log/cron.log 2>&1\n\n" "$min" "$hr" "$day" "$month" "$dow" > /etc/cron.d/mapcrafter && \
    chmod 0644 /etc/cron.d/mapcrafter && \
    chmod 0777 /run-mapcrafter

CMD ["cron", "-f"]
