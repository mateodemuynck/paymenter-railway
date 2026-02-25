FROM ghcr.io/paymenter/paymenter:latest

COPY entrypoint.sh /app/.github/docker/railway-entrypoint.sh

ENTRYPOINT [ "/bin/ash", "/app/.github/docker/railway-entrypoint.sh" ]
CMD [ "supervisord", "-n", "-c", "/etc/supervisord.conf" ]