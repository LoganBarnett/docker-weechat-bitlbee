FROM       ubuntu:17.04
MAINTAINER Logan Barnett <logustus@gmail.com>

RUN apt-get update
RUN apt-get install software-properties-common language-pack-en wget apt-transport-https -y
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
# Instructions for installing weechat-stable can be found here:
# https://launchpad.net/~nesthib/+archive/ubuntu/weechat-stable
RUN add-apt-repository "deb https://weechat.org/ubuntu $(lsb_release -cs) main"
ADD bitlbee.key /tmp/bitlbee.key
RUN apt-key add /tmp/bitlbee.key
RUN echo "deb http://code.bitlbee.org/debian/master/zesty/amd64/ ./" >> /etc/apt/sources.list.d/bitlbee.list
RUN echo "deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_17.04 ./" >> /etc/apt/sources.list.d/jgeboski.list
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
