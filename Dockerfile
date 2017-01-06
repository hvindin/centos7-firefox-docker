FROM docker.io/centos:latest
LABEL base.os="centos7" base.version="7.3.1611" firefox="45.6.0" flash="24.0.0.186"
RUN yum fs filter languages en:US && yum fs filter documentation \
  && echo "[adobe-linux-x86_64]" >> /etc/yum.repos.d/flash.repo \
  && echo "name = Adobe Systems Incorporated" >> /etc/yum.repos.d/flash.repo \
  && echo "baseurl = http://linuxdownload.adobe.com/linux/x86_64/" >> /etc/yum.repos.d/flash.repo \
  && echo "enabled = 1" .. /etc/yum.repos.d/flash.repo \
  && echo "gpgcheck = 0" >> /etc/yum.repos.d/flash.repo \
  && yum install dbus PackageKit-gtk3-module flash-plugin libcanberra-gtk2 firefox ca-certificates curl -y >&2 && yum clean all -y >&2 \
  && curl -Ss https://fpdownload.adobe.com/get/flashplayer/pdc/24.0.0.186/flash_player_npapi_linux.x86_64.tar.gz -L \
  | tar xz --exclude=usr --exclude=LGPL --exclude=license.pdf --exclude=readme.txt --directory /usr/lib/mozilla/plugins \
  && rm -f /etc/yum.repos.d/flash.repo \
  && tee /etc/machine-id <<<$(dbus-uuidgen) \
  && curl -o /usr/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64" -L \
  && chmod +x /usr/bin/dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD [ "/lib64/firefox/firefox" ]
