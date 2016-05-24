ssl/tls for postfix inbound and outgoing - mostly done - waiting for ssl certs for smtpd incoming

check ldap bind creds on startup - terminate if invalid/not working
ldap query rewrite to cope with disabled users
- need to get the freeipa CA in here somehow - probably openshift secret

create separate project for postfix relay (service name depends on project)
current name: postfix.default.svc.cluster.local


rate limiting per user - looks like it will need a separate policy service of some sort

