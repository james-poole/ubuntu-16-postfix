#!/bin/bash

postconf -e "myhostname = relay.${DOMAIN}"
sed -i -e "s/^smtp\(      inet  n       -       y       -       -       smtpd\)$/${SMTP_PORT}\1/g" /etc/postfix/master.cf
