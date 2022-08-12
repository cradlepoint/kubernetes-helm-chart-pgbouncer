FROM ubuntu:18.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -qy dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends pgbouncer=1.8.1-1build1 && \
  DEBIAN_FRONTEND=noninteractive apt-get -qy clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/log/postgresql
RUN chmod -R 755 /var/log/postgresql
RUN chown -R postgres:postgres /var/log/postgresql


ENV PG_CONFIG /etc/pgbouncer/pgbouncer.ini
ENV PG_USER postgres

USER postgres
ENTRYPOINT pgbouncer -u $PG_USER $PG_CONFIG
