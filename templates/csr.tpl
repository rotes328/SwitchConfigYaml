====== R1 CONFIG ======

hostname {{ router1.name }}

ip domain name {{ router1.domainname }}

aaa new-model
aaa authentication login default local

interface Loopback1
  ip address {{ router1.loopback1 }} 255.255.255.255
  no shutdown

interface Loopback2
  ip address {{ router1.loopback2 }} 255.255.255.255
  no shutdown

interface {{ router1.interface2.name }}
  ip address {{ router1.interface2.ip }} 255.255.255.252
  no shutdown

interface {{ router1.interface3.name }}
  ip address {{ router1.interface3.ip }} 255.255.255.252
  no shutdown

router bgp {{ router1.bgp.asn }}
  bgp router-id {{ router1.interface1.ip }}
  bgp log-neighbor-changes
  network {{ router1.loopback1 }} mask 255.255.255.255
  network {{ router1.loopback2 }} mask 255.255.255.255
  neighbor {{ router2.interface1.ip }} remote-as {{ router2.bgp.asn }}
  neighbor {{ router2.interface1.ip }} soft-reconfiguration inbound

line vty 0 4
  privilege level 15