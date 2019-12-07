FROM postgres:12

RUN mkdir -p /docker-entrypoint-initdb.d/
RUN mkdir -p /schema-scripts/

COPY ./exec.sh /docker-entrypoint-initdb.d/exec.sh
COPY ./schema/ /schema-scripts/
