FROM 1and1internet/ubuntu-16:unstable
MAINTAINER james.wilkins@fasthosts.com
ARG DEBIAN_FRONTEND=noninteractive

ENV DOMAIN=example.com \
    SMTP_PORT=8025 \
    LDAP_PROTOCOL=ldaps \
    LDAP_SERVERS="ldap01.example.com ldap02.example.com" \
    LDAP_SEARCH_BASE="dc=ipa,dc=example,dc=com" \
    LDAP_FILTER="(&(memberOf=cn=users,cn=groups,cn=accounts,dc=ipa,dc=example,dc=com)(uid=%U))" \
    LDAP_BIND_DN=bob \
    LDAP_BIND_PW=bob
RUN \
  echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
  apt-get update && apt-get install -y postfix libsasl2-modules sasl2-bin rsyslog nano telnet && \
  postconf -e smtpd_sasl_auth_enable=yes && \
  postconf -e 'smtpd_sasl_local_domain =' && \
  postconf -e 'smtpd_sasl_auth_enable = yes' && \
  postconf -e 'smtpd_sasl_security_options = noanonymous' && \
  postconf -e 'broken_sasl_auth_clients = yes' && \
  postconf -e 'smtpd_recipient_restrictions = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination' && \
  postconf -e 'inet_interfaces = all' && \
  echo 'pwcheck_method: saslauthd' >> /etc/postfix/sasl/smtpd.conf && \
  mkdir -p /var/spool/postfix/var/run/saslauthd && \
  rm -rf /var/lib/apt/lists/* && \
  mkfifo -m 666 /tmp/logpipe && \
  sed -i -e '/^module(load="imklog")/g' /etc/rsyslog.conf && \
  sed -i -e '/^\$KLogPermitNonKernelFacility/d' /etc/rsyslog.conf

COPY files /
EXPOSE $SMTP_PORT
