FROM 1and1internet/ubuntu-16:unstable
MAINTAINER james.wilkins@fasthosts.com
RUN \
  apt-get update && apt-get install -y postfix libsasl2-modules sasl2-bin rsyslog nano telnet && \
  postconf -e smtpd_sasl_auth_enable=yes && \
  postconf -e 'smtpd_sasl_local_domain =' && \
  postconf -e 'smtpd_sasl_auth_enable = yes' && \
  postconf -e 'smtpd_sasl_security_options = noanonymous' && \
  postconf -e 'broken_sasl_auth_clients = yes' && \
  postconf -e 'smtpd_recipient_restrictions = permit_sasl_authenticated,permit_mynetworks,reject_unauth_destination' && \
  postconf -e 'inet_interfaces = all' && \
  postconf -e 'myhostname = relay.gb-je06.live-paas.net' && \
  echo 'pwcheck_method: saslauthd' >> /etc/postfix/sasl/smtpd.conf && \
  mkdir -p /var/spool/postfix/var/run/saslauthd && \
  rm -rf /var/lib/apt/lists/* 

COPY files /
EXPOSE 2500
