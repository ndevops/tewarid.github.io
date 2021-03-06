---
layout: default
title: Active Directory domain server using Samba 4
tags: active directory ad ldap samba docker
comments: true
---

I was in need of an Active Directory domain server, to test an application that authenticates users with LDAP, and checks that user is part of a particular group.

I discovered that Samba 4 provides Active Directory capability out of the box, and found a couple of Docker images for Samba 4. I chose the simplest of these and found it works to my satisfaction on Windows 10.

Open a new Command Prompt or PowerShell console, and execute the following command to run samba, in interactive mode, in a docker container based on the `laslabs/alpine-samba-dc` image

```bash
docker run --rm -i -t --privileged -p 389:389 -e SAMBA_DC_REALM="corp.example.net" -e SAMBA_DC_DOMAIN="EXAMPLE" -e SAMBA_DC_ADMIN_PASSWD="5u3r53cur3!" -e SAMBA_DC_DNS_BACKEND="SAMBA_INTERNAL" "laslabs/alpine-samba-dc" samba
```

Running samba interactively, will show any errors on the console.

In the application, I authenticated using login `Administrator`, password `5u3r53cur3!`, and checked that the user belongs to group `Administrators`.
