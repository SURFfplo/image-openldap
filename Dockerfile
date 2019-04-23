FROM alpine:3.9.3
LABEL image="openldap"
LABEL versie="0.1"
LABEL datum="2019 04 23"

RUN  apk update \
  && apk add openldap-back-mdb \
  && apk add openldap \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /run/openldap \
  && chown -R ldap.ldap /run/openldap

COPY modules/ /etc/openldap/modules

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-d", "32768", "-u", "ldap", "-g", "ldap"]
