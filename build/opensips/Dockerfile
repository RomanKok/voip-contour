FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /
RUN apt-get clean && apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y wget gnupg make devscripts build-essential \
    bison flex gcc libconfuse-dev libexpat1-dev libmysqlclient-dev libncurses5-dev uuid-dev \
    libpcre3-dev libperl-dev libpq-dev libpq5 libmemcached-dev libsctp-dev \
    libsnmp-dev libxml2 libxml2-dev libxmlrpc-core-c3-dev libjson-c-dev libcurl4-gnutls-dev\
    libhiredis-dev openssl libpcap-dev cmake init jq sngrep \
    python3 python3-dev python3-pip python3-psycopg2

RUN wget https://opensips.org/pub/opensips/3.4.2/opensips-3.4.2.tar.gz -P ${HOME} \
    && cd ${HOME} && tar xvf opensips-3.4.2.tar.gz && cd opensips-3.4.2 && make \
    && sed -i 's/^include_modules?=/include_modules?=compression regex mi_xmlrpc_ng json cachedb_redis db_postgres sip_i rest_client/' Makefile.conf \
    && make modules && make install


RUN git clone https://github.com/opensips/opensips-cli /usr/local/src/opensips-cli
WORKDIR /usr/local/src/opensips-cli
RUN python3 setup.py install clean