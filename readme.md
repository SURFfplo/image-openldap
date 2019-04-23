openldap
========

Dit is openldap + memberof module op alpine.

Het voorbeeld was: 
- https://github.com/danielguerra69/docker-openldap (maar die werkt niet... )
- die is gebaseerd op een debian distributie, die ook in de fplo versie 2018 gebruikt werd: https://github.com/dinkel/docker-openldap
- een en ander is gecombineerd met deze alpine versie: https://github.com/gitphill/ldap-alpine
- nog meer info is hier te vinden: http://www.zytrax.com/books/ldap/ch6/slapd-config.html


Build.sh
--------

Dit script bouwt het image en gebruikt daarbij
- conf/slapd.conf
- modules/memberof.ldif & modules/refint.ldif


Entrypoint.sh
-------------

Dit script beschrijft de configuratie van openldap, deze was lastig... Dus lees even de comments in dit script voor de juiste volgorde. Komt hier op neer:
- configureren van slapd.conf met onderstaande variabelen
- permissies goed zetten
- omzetten naar slapd.d formaat
- toevoegen van modules


Configuration (environment variables)
-------------------------------------

- SLAPD_USER: admin user (admin)
- SLAPD_PASSWORD: password for the admin user (secret)
- SLAPD_DOMAIN: the ldap domain, dc=example,dc=com

