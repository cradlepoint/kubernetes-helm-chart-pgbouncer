FROM ubuntu:18.04

RUN set -x \
    && apt-get -qq update \
    && apt-get install -yq --no-install-recommends pgbouncer \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/postgresql
RUN chmod -R 755 /var/log/postgresql
RUN chown -R postgres:postgres /var/log/postgresql


ENV PG_CONFIG /etc/pgbouncer/pgbouncer.ini
ENV PG_USER postgres

USER postgres
ENTRYPOINT pgbouncer -u $PG_USER $PG_CONFIG
