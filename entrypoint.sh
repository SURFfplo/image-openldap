#!/bin/sh

# When not limiting the open file descritors limit, the memory consumption of
# slapd is absurdly high. See https://github.com/docker/docker/issues/8231
ulimit -n 8192

set -e


# ### 1: CONFIGURE ###
# encrypt root password before replacing
MY_PASSWORD=`cat $SLAPD_PASSWORD`
MY_PASSWORD_ENC=$(slappasswd -s "$MY_PASSWORD")

# replace variables in slapd.conf
SLAPD_CONF="/etc/openldap/slapd.conf"
sed -i "s~%SLAPD_DOMAIN%~$SLAPD_DOMAIN~g" "$SLAPD_CONF"
sed -i "s~%SLAPD_USER%~$SLAPD_USER~g" "$SLAPD_CONF"
sed -i "s~%SLAPD_PASSWORD%~$MY_PASSWORD_ENC~g" "$SLAPD_CONF"


# ### 2: PERMISSIONS ###
chown -R ldap:ldap /etc/openldap/slapd.conf /etc/openldap/slapd.d /var/lib/openldap/openldap-data /run/openldap


# ### 3: CONVERT ###
# convert slapd.conf to slapd.d format
slapd -u ldap -g ldap -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d
killall slapd


# ### 4: MODULES ###
# add memberof
MEMBEROF_LDIF="/etc/openldap/modules/memberof.ldif"
slapadd -n0 -l $MEMBEROF_LDIF

# add refint
REFINT_LDIF="/etc/openldap/modules/refint.ldif"
slapadd -n0 -l $REFINT_LDIF

# ### 5: PERMISSIONS... AGAIN ###
chown -R ldap:ldap /etc/openldap/slapd.d
chmod -R 0750 /etc/openldap/slapd.d


exec "$@"
