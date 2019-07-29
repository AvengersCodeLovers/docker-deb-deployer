FROM php:7.2.18-fpm-alpine3.9

RUN apk --update add git openssh bash curl && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

RUN wget http://rocketeer.autopergamene.eu/versions/rocketeer.phar
RUN chmod +x rocketeer.phar

RUN mv rocketeer.phar /usr/local/bin/rocketeer

RUN curl -LO https://deployer.org/deployer.phar
RUN mv deployer.phar /usr/local/bin/dep
RUN chmod +x /usr/local/bin/dep

COPY ./commands.sh /scripts/commands.sh
RUN ["chmod", "+x", "/scripts/commands.sh"]

RUN chmod 666 /dev/tty

ENTRYPOINT ["/scripts/commands.sh"]

WORKDIR /workdir

