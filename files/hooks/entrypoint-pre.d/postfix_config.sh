#!/bin/bash

postconf -e "myhostname = relay.${DOMAIN}"
sed -i -e "s/^smtp\(\s+inet\s+n\s+-\s+n\s+-\s+-\s+smtpd\)$/${SMTP_PORT}\1/g" /etc/postfix/master.cf
