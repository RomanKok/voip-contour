FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y build-essential libpcap-dev libsctp-dev \
    libncurses5-dev cmake init jq
WORKDIR /
ADD https://github.com/SIPp/sipp/releases/download/v3.6.1/sipp-3.6.1.tar.gz /
RUN tar -xzf /sipp-3.6.1.tar.gz

WORKDIR /sipp-3.6.1
RUN cmake . -DUSE_PCAP=1
RUN make
RUN cp /sipp-3.6.1/sipp /usr/local/bin/
