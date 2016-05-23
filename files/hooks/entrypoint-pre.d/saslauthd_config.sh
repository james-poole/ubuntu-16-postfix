#!/bin/bash

die () {
  echo $1
  exit 1
}

[ -z "${LDAP_SERVERS}" ] && die "LDAP_SERVERS not specified"
[ -z "${LDAP_SEARCH_BASE}" ] && die "LDAP_SEARCH_BASE not specified"
[ -z "${LDAP_FILTER}" ] && die "LDAP_FILTER not specified"
[ -z "${LDAP_BIND_DN}" ] && die "LDAP_BIND_DN not specified"
[ -z "${LDAP_BIND_PW}" ] && die "LDAP_BIND_PW not specified"
[ -z "${LDAP_PROTOCOL}" ] && die "LDAP_PROTOCOL not specified"

cat <<EOF > /etc/saslauthd.conf
ldap_auth_method: bind
ldap_servers: $(for s in ${LDAP_SERVERS}; do echo -n "${LDAP_PROTOCOL}://${s} "; done)
ldap_search_base: ${LDAP_SEARCH_BASE}
ldap_filter: ${LDAP_FILTER}
ldap_bind_dn: ${LDAP_BIND_DN}
ldap_bind_pw: ${LDAP_BIND_PW}
EOF

# ldap_servers: ldap://109.228.48.235
# ldap_search_base: dc=ipa,dc=gb-je06,dc=live-paas,dc=net
# ldap_filter: (&(memberOf=cn=smtpsenders,cn=groups,cn=accounts,dc=ipa,dc=gb-je06,dc=live-paas,dc=net)(uid=%U))
# ldap_bind_dn: uid=ldapsearch,cn=users,cn=accounts,dc=ipa,dc=gb-je06,dc=live-paas,dc=net
# ldap_bind_pw: IamAPassword1
# ldap_auth_method: bind
