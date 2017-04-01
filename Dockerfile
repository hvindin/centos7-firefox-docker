FROM docker.io/centos:7.3.1611
LABEL base.os="centos7" base.version="7.3.1611" firefox="52.0" flash="25.0.0.127"
RUN yum fs filter languages en:US && yum fs filter documentation \
  && printf "[adobe-linux-x86_64]\nname = Adobe Systems Incorporated\nbaseurl = http://linuxdownload.adobe.com/linux/x86_64/\nenabled = 1\ngpgcheck = 0\n" | tee /etc/yum.repos.d/flash.repo \
  && yum install dbus PackageKit-gtk3-module flash-plugin libcanberra-gtk2 firefox ca-certificates curl -y >&2 && yum clean all -y >&2 \
  && curl -Ss https://fpdownload.adobe.com/get/flashplayer/pdc/25.0.0.127/flash_player_npapi_linux.x86_64.tar.gz \
  | tar xz --exclude=usr --exclude=LGPL --exclude=license.pdf --exclude=readme.txt --directory /usr/lib/mozilla/plugins \
  && rm -f /etc/yum.repos.d/flash.repo \
  && dbus-uuidgen | tee /etc/machine-id \
  && curl -o /usr/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64" -L \
  && chmod +x /usr/bin/dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD [ "/lib64/firefox/firefox" ]
