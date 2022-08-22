====== R1 CONFIG ======

hostname {{ global.dc }}-{{ router1.name }}

ip name-server {{ global.dns.ns1 }} {{ global.dns.ns2 }}

interface Loopback1
  ip address {{ router1.loopback1 }} 255.255.255.255
  no shutdown

interface Loopback2
  ip address {{ router1.loopback2 }} 255.255.255.255
  no shutdown

interface {{ router1.interface1.name }}
  ip address {{ router1.interface1.ip }} 255.255.255.252
  no shutdown

router bgp {{ router1.bgp.asn }}
  bgp router-id {{ router1.loopback1 }}
  bgp log-neighbor-changes
  network {{ router1.loopback1 }} mask 255.255.255.255
  network {{ router1.loopback2 }} mask 255.255.255.255
  passive-interface default
  neigbor {{ router2.interface1.ip }} remote-as {{ router2.bgp.asn }}
  neigbor {{ router2.interface1.ip }} soft-reconfiguration inbound



====== R2 CONFIG ======

hostname {{ global.dc }}-{{ router2.name }}

ip name-server {{ global.dns.ns1 }} {{ global.dns.ns2 }}

interface Loopback1
  ip address {{ router2.loopback1 }} 255.255.255.255
  no shutdown

interface Loopback2
  ip address {{ router2.loopback2 }} 255.255.255.255
  no shutdown

interface {{ router2.interface1.name }}
  ip address {{ router2.interface1.ip }} 255.255.255.252
  no shutdown

router bgp {{ router2.bgp.asn }}
  bgp router-id {{ router2.loopback1 }}
  bgp log-neighbor-changes
  network {{ router2.loopback1 }} mask 255.255.255.255
  network {{ router2.loopback2 }} mask 255.255.255.255
  passive-interface default
  neigbor {{ router1.interface1.ip }} remote-as {{ router1.bgp.asn }}
  neigbor {{ router1.interface1.ip }} soft-reconfiguration inbound

