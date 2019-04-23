FROM alpine:3.9.3
LABEL image="openldap"
LABEL versie="0.1"
LABEL datum="2019 04 23"

# install openldap
RUN  apk update \
  && apk add openldap \
  && apk add openldap-back-mdb \
  && apk add openldap-overlay-memberof \
  && apk add openldap-overlay-refint \
  && rm -rf /var/cache/apk/*

# prepare directories
RUN mkdir -p /run/openldap \
  && mkdir -p /var/lib/openldap/openldap-data \
  && mkdir -p /etc/openldap/slapd.d

# set configuration files
COPY conf /etc/openldap
COPY modules /etc/openldap/modules

# copy script to configure openldap
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-d", "32768", "-u", "ldap", "-g", "ldap"]
