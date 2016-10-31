FROM       ubuntu:14.04
MAINTAINER Logan Barnett <logustus@gmail.com>

RUN apt-get update
RUN apt-get install software-properties-common language-pack-en wget -y
RUN add-apt-repository ppa:nesthib/weechat-stable -y
ADD bitlbee.key /tmp/bitlbee.key
RUN apt-key add /tmp/bitlbee.key
RUN echo "deb http://code.bitlbee.org/debian/devel/trusty/amd64/ ./" >> /etc/apt/sources.list.d/bitlbee.list
RUN echo "deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_14.04 ./" >> /etc/apt/sources.list.d/jgeboski.list
RUN wget -O- https://jgeboski.github.io/obs.key | apt-key add -

RUN apt-get update
RUN apt-get install \
  weechat \
  bitlbee \
  bitlbee-plugin-otr \
  bitlbee-facebook  \
  perl \
  -y
RUN ln -sf /usr/share/zoneinfo/PST8PDT /etc/localtime

ADD bitlbee.conf /etc/bitlbee/bitlbee.conf

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
