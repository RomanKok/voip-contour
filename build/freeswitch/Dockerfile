FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get update && apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC+0 apt-get -y install tzdata

RUN apt-get install -y git subversion build-essential autoconf automake \
    libncurses5 libncurses5-dev make libjpeg-dev libtool libtool-bin \
    libsqlite3-dev libpcre3-dev libspeexdsp-dev libldns-dev libedit-dev yasm \
    liblua5.2-dev libopus-dev cmake libcurl4-openssl-dev libexpat1-dev \
    libgnutls28-dev libtiff5-dev libx11-dev unixodbc-dev libssl-dev python3-dev \
    zlib1g-dev libogg-dev libvorbis-dev libperl-dev libgdbm-dev libdb-dev \
    uuid-dev libsndfile1-dev libavformat-dev libswscale-dev libpq-dev \
    libghc-postgresql-libpq-dev init wget sngrep

RUN apt-get autoremove -y

RUN git clone https://github.com/freeswitch/sofia-sip.git /usr/local/src/sofia-sip
WORKDIR /usr/local/src/sofia-sip/
RUN ./bootstrap.sh
RUN ./configure
RUN make && make install
RUN ln -s /usr/local/lib/libsofia-sip-ua.so.0.6.0 /usr/lib/libsofia-sip-ua.so.0

RUN git clone https://github.com/freeswitch/spandsp /usr/local/src/spandsp
WORKDIR /usr/local/src/spandsp/
RUN ./bootstrap.sh
RUN ./configure
RUN make && make install

RUN git clone https://github.com/signalwire/libks.git /usr/local/src/libks
WORKDIR  /usr/local/src/libks
RUN cmake .
RUN make && make install

RUN git clone -b v1.10.11 https://github.com/signalwire/freeswitch.git /usr/local/src/freeswitch
WORKDIR /usr/local/src/freeswitch
RUN git checkout v1.10.11
RUN ./bootstrap.sh -j /usr/local/src/freeswitch/modules.conf
RUN sed -i 's|#applications/mod_curl|applications/mod_curl|' modules.conf
RUN sed -i 's|applications/mod_signalwire|#applications/mod_signalwire|' modules.conf
RUN sed -i 's|applications/mod_spandsp|#applications/mod_spandsp|' modules.conf
RUN ./configure --disable-libvpx
RUN make && make install

RUN ln -s /usr/local/freeswitch/conf /etc/freeswitch
RUN ln -s /usr/local/freeswitch/bin/fs_cli /usr/bin/fs_cli
RUN ln -s /usr/local/freeswitch/bin/freeswitch /usr/sbin/freeswitch
RUN ln -s /usr/local/lib/libspandsp.so.3 /usr/lib/libspandsp.so.3
RUN mkdir -p /var/log/freeswitch
RUN groupadd freeswitch
RUN adduser --quiet --system --home /usr/local/freeswitch \
    --gecos 'FreeSWITCH open source softswitch' \
    --ingroup freeswitch freeswitch \
    --disabled-password
RUN chown -R freeswitch:freeswitch /usr/local/freeswitch/
RUN chown -R freeswitch:freeswitch /var/log/freeswitch/
RUN chmod -R ug=rwX,o= /usr/local/freeswitch/
RUN chmod -R u=rwx,g=rx /usr/local/freeswitch/bin/*