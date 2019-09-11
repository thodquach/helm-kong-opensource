FROM kong:1.2.2

# Install npm
RUN apk add --no-cache git npm supervisor

# Install kong-config-manager
# Ref: https://github.com/Maples7/kong-config-manager
RUN npm i -g kong-config-manager

# Inital configuration for kcm
RUN kcm init

# Copy current configuration of kong into container
COPY ./main /kong-config/main

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisord.conf

# Copy those steps from offical dockerfile of kong
# Ref: https://github.com/Kong/docker-kong/blob/21f7761927809788e0bbd6c9f2ecdc661afe5f84/alpine/Dockerfile
ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGQUIT
