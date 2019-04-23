openldap
========

Dit is openldap + memberof module op alpine.
Het voorbeeld was: https://github.com/danielguerra69/docker-openldap


Build.sh
--------

Dit script bouwt het image...


Configuration (environment variables)
-------------------------------------

For the first run, one has to set at least the first two environment variables.
After the first start of the image (and the initial configuration), these
envirnonment variables are not evaluated again.

* `SLAPD_PASSWORD` (required) - sets the password for the `admin` user.
* `SLAPD_DOMAIN` (required) - sets the DC (Domain component) parts. E.g. if one sets
it to `ldap.example.org`, the generated base DC parts would be `...,dc=ldap,dc=example,dc=org`.
* `SLAPD_ORGANIZATION` (defaults to $SLAPD_DOMAIN) - represents the human readable
company name (e.g. `Example Inc.`).
* `SLAPD_CONFIG_PASSWORD` - allows password protected access to the `dn=config`
branch. This helps to reconfigure the server without interruption (read the
[official documentation](http://www.openldap.org/doc/admin24/guide.html#Configuring%20slapd)).
* `SLAPD_ADDITIONAL_SCHEMAS` - loads additional schemas provided in the `slapd`
package that are not installed using the environment variable with comma-separated
enties. As of writing these instructions, there are the following additional schemas
available: `collective`, `corba`, `duaconf`, `dyngroup`, `java`, `misc`, `openldap`,
`pmi` and `ppolicy`.
* `SLAPD_ADDITIONAL_MODULES` - comma-separated list of modules to load. It will try
to run `.ldif` files with a corresponsing name from the `module` directory.
Currently only `memberof` and `ppolicy` are avaliable.

