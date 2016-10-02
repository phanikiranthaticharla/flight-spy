FROM php

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y vim cron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD . /flight-spy
ADD docker/crontab /etc/cron.d/flight-spy-cron
ADD docker/php.ini /usr/local/etc/php/php.ini

RUN chmod 0644 /etc/cron.d/flight-spy-cron && \
touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log