#!/usr/bin/with-contenv bashio

ulimit -n 1048576

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"
cp -v -R /etc/cups /data
rm -v -fR /etc/cups

ln -v -s /data/cups /etc/cups

bashio::log.info "Uploading driver to HP printer"
cat /usr/share/foo2xqx/firmware/sihpP1005.dl > /dev/usb/lp0

bashio::log.info "Starting CUPS server as CMD from S6"

cupsd -f
