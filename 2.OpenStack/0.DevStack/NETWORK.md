# Utilitaires

```
$ ip link
```
Retourne:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp9s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 3c:07:54:7e:07:a0 brd ff:ff:ff:ff:ff:ff
3: enp10s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 3c:07:54:7d:e8:99 brd ff:ff:ff:ff:ff:ff
4: ovs-system: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1
    link/ether a6:6c:37:a9:64:b9 brd ff:ff:ff:ff:ff:ff
5: br-tun: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1
    link/ether 7e:34:8a:ae:4a:4f brd ff:ff:ff:ff:ff:ff
12: br-int: <BROADCAST,MULTICAST> mtu 1450 qdisc noop state DOWN mode DEFAULT group default qlen 1
    link/ether 86:c2:0e:d4:c8:4e brd ff:ff:ff:ff:ff:ff
14: br-ex: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1
    link/ether 6a:b6:4e:98:24:43 brd ff:ff:ff:ff:ff:ff
...
```

```
$ brctl show
```
Retourne:
```
bridge name	bridge id		STP enabled	interfaces
qbr0695f2ca-bf		8000.ee390677286c	no		qvb0695f2ca-bf
							tap0695f2ca-bf
qbr839737e6-15		8000.f612081e8714	no		qvb839737e6-15
							tap839737e6-15

```

```
$ sudo ovs-vsctl show
```
Retourne:
```
256fd168-a5f8-4371-ad1a-a3135b3380a5
    Manager "ptcp:6640:127.0.0.1"
        is_connected: true
    Bridge br-ex
        Controller "tcp:127.0.0.1:6633"
            is_connected: true
        fail_mode: secure
        Port br-ex
            Interface br-ex
                type: internal
        Port phy-br-ex
            Interface phy-br-ex
                type: patch
                options: {peer=int-br-ex}
    Bridge br-tun
        Controller "tcp:127.0.0.1:6633"
            is_connected: true
        fail_mode: secure
        Port br-tun
            Interface br-tun
                type: internal
        Port patch-int
            Interface patch-int
                type: patch
                options: {peer=patch-tun}
    Bridge br-int
        Controller "tcp:127.0.0.1:6633"
            is_connected: true
        fail_mode: secure
        Port patch-tun
            Interface patch-tun
                type: patch
                options: {peer=patch-int}
        Port "qr-6a5ca1ea-74"
            tag: 3
            Interface "qr-6a5ca1ea-74"
                type: internal
        Port "qr-ce849b98-cb"
            tag: 1
            Interface "qr-ce849b98-cb"
                type: internal
        Port br-int
            Interface br-int
                type: internal
        Port "qvo0695f2ca-bf"
            tag: 3
            Interface "qvo0695f2ca-bf"
        Port "qg-ea18c225-bd"
            tag: 2
            Interface "qg-ea18c225-bd"
                type: internal
        Port int-br-ex
            Interface int-br-ex
                type: patch
                options: {peer=phy-br-ex}
        Port "qr-341cade3-25"
            tag: 1
            Interface "qr-341cade3-25"
                type: internal
        Port "qvo839737e6-15"
            tag: 3
            Interface "qvo839737e6-15"
        Port "qg-d4455c51-c5"
            tag: 2
            Interface "qg-d4455c51-c5"
                type: internal
        Port "tap26593dc1-6e"
            tag: 3
            Interface "tap26593dc1-6e"
                type: internal
        Port "tap175a3b0e-2f"
            tag: 1
            Interface "tap175a3b0e-2f"
                type: internal
    ovs_version: "2.5.0"
```
```
$ sudo ovs-ofctl dump-flows br-tun
```
Retourne:
```
NXST_FLOW reply (xid=0x4):
 cookie=0xba7f503029ce9008, duration=12257.804s, table=0, n_packets=6676, n_bytes=301928, idle_age=0, priority=1,in_port=1 actions=resubmit(,2)
 cookie=0xba7f503029ce9008, duration=12257.802s, table=0, n_packets=0, n_bytes=0, idle_age=12257, priority=0 actions=drop
 cookie=0xba7f503029ce9008, duration=12257.800s, table=2, n_packets=0, n_bytes=0, idle_age=12257, priority=0,dl_dst=00:00:00:00:00:00/01:00:00:00:00:00 actions=resubmit(,20)
 cookie=0xba7f503029ce9008, duration=12257.797s, table=2, n_packets=6676, n_bytes=301928, idle_age=0, priority=0,dl_dst=01:00:00:00:00:00/01:00:00:00:00:00 actions=resubmit(,22)
 cookie=0xba7f503029ce9008, duration=12257.796s, table=3, n_packets=0, n_bytes=0, idle_age=12257, priority=0 actions=drop
 cookie=0xba7f503029ce9008, duration=12253.830s, table=4, n_packets=0, n_bytes=0, idle_age=12253, priority=1,tun_id=0x3c actions=mod_vlan_vid:1,resubmit(,10)
 cookie=0xba7f503029ce9008, duration=12253.826s, table=4, n_packets=0, n_bytes=0, idle_age=12253, priority=1,tun_id=0x1a actions=mod_vlan_vid:3,resubmit(,10)
 cookie=0xba7f503029ce9008, duration=12257.795s, table=4, n_packets=0, n_bytes=0, idle_age=12257, priority=0 actions=drop
 cookie=0xba7f503029ce9008, duration=12257.794s, table=6, n_packets=0, n_bytes=0, idle_age=12257, priority=0 actions=drop
 cookie=0xba7f503029ce9008, duration=12257.792s, table=10, n_packets=0, n_bytes=0, idle_age=12257, priority=1 actions=learn(table=20,hard_timeout=300,priority=1,cookie=0xba7f503029ce9008,NXM_OF_VLAN_TCI[0..11],NXM_OF_ETH_DST[]=NXM_OF_ETH_SRC[],load:0->NXM_OF_VLAN_TCI[],load:NXM_NX_TUN_ID[]->NXM_NX_TUN_ID[],output:OXM_OF_IN_PORT[]),output:1
 cookie=0xba7f503029ce9008, duration=12257.789s, table=20, n_packets=0, n_bytes=0, idle_age=12257, priority=0 actions=resubmit(,22)
 cookie=0xba7f503029ce9008, duration=12257.787s, table=22, n_packets=6676, n_bytes=301928, idle_age=0, priority=0 actions=drop
 ```

```
$ sudo iptables-save
```
Retourne: 
```
 # Generated by iptables-save v1.6.0 on Tue Dec  6 16:50:57 2016
*raw
:PREROUTING ACCEPT [668254:229949456]
:OUTPUT ACCEPT [593879:867553343]
:neutron-openvswi-OUTPUT - [0:0]
:neutron-openvswi-PREROUTING - [0:0]
-A PREROUTING -j neutron-openvswi-PREROUTING
-A OUTPUT -j neutron-openvswi-OUTPUT
-A neutron-openvswi-PREROUTING -m physdev --physdev-in qvb0695f2ca-bf -j CT --zone 1
-A neutron-openvswi-PREROUTING -m physdev --physdev-in tap0695f2ca-bf -j CT --zone 1
-A neutron-openvswi-PREROUTING -m physdev --physdev-in qvb839737e6-15 -j CT --zone 2
-A neutron-openvswi-PREROUTING -m physdev --physdev-in tap839737e6-15 -j CT --zone 2
COMMIT
# Completed on Tue Dec  6 16:50:57 2016
# Generated by iptables-save v1.6.0 on Tue Dec  6 16:50:57 2016
*mangle
:PREROUTING ACCEPT [1006247:701792462]
:INPUT ACCEPT [1003444:701585990]
:FORWARD ACCEPT [2817:211044]
:OUTPUT ACCEPT [928586:1343199439]
:POSTROUTING ACCEPT [931397:1343408515]
:neutron-openvswi-FORWARD - [0:0]
:neutron-openvswi-INPUT - [0:0]
:neutron-openvswi-OUTPUT - [0:0]
:neutron-openvswi-POSTROUTING - [0:0]
:neutron-openvswi-PREROUTING - [0:0]
:neutron-openvswi-mark - [0:0]
:nova-api-POSTROUTING - [0:0]
-A PREROUTING -j neutron-openvswi-PREROUTING
-A INPUT -j neutron-openvswi-INPUT
-A FORWARD -j neutron-openvswi-FORWARD
-A OUTPUT -j neutron-openvswi-OUTPUT
-A POSTROUTING -j neutron-openvswi-POSTROUTING
-A POSTROUTING -j nova-api-POSTROUTING
-A POSTROUTING -o virbr0 -p udp -m udp --dport 68 -j CHECKSUM --checksum-fill
-A neutron-openvswi-PREROUTING -j neutron-openvswi-mark
COMMIT
# Completed on Tue Dec  6 16:50:57 2016
# Generated by iptables-save v1.6.0 on Tue Dec  6 16:50:57 2016
*nat
:PREROUTING ACCEPT [686:48444]
:INPUT ACCEPT [70:5056]
:OUTPUT ACCEPT [2686:160596]
:POSTROUTING ACCEPT [3302:203984]
:neutron-openvswi-OUTPUT - [0:0]
:neutron-openvswi-POSTROUTING - [0:0]
:neutron-openvswi-PREROUTING - [0:0]
:neutron-openvswi-float-snat - [0:0]
:neutron-openvswi-snat - [0:0]
:neutron-postrouting-bottom - [0:0]
:nova-api-OUTPUT - [0:0]
:nova-api-POSTROUTING - [0:0]
:nova-api-PREROUTING - [0:0]
:nova-api-float-snat - [0:0]
:nova-api-snat - [0:0]
:nova-postrouting-bottom - [0:0]
-A PREROUTING -j neutron-openvswi-PREROUTING
-A PREROUTING -j nova-api-PREROUTING
-A OUTPUT -j neutron-openvswi-OUTPUT
-A OUTPUT -j nova-api-OUTPUT
-A POSTROUTING -j neutron-openvswi-POSTROUTING
-A POSTROUTING -j neutron-postrouting-bottom
-A POSTROUTING -j nova-api-POSTROUTING
-A POSTROUTING -j nova-postrouting-bottom
-A POSTROUTING -s 192.168.122.0/24 -d 224.0.0.0/24 -j RETURN
-A POSTROUTING -s 192.168.122.0/24 -d 255.255.255.255/32 -j RETURN
-A POSTROUTING -s 192.168.122.0/24 ! -d 192.168.122.0/24 -p tcp -j MASQUERADE --to-ports 1024-65535
-A POSTROUTING -s 192.168.122.0/24 ! -d 192.168.122.0/24 -p udp -j MASQUERADE --to-ports 1024-65535
-A POSTROUTING -s 192.168.122.0/24 ! -d 192.168.122.0/24 -j MASQUERADE
-A neutron-openvswi-snat -j neutron-openvswi-float-snat
-A neutron-postrouting-bottom -m comment --comment "Perform source NAT on outgoing traffic." -j neutron-openvswi-snat
-A nova-api-snat -j nova-api-float-snat
-A nova-postrouting-bottom -j nova-api-snat
COMMIT
# Completed on Tue Dec  6 16:50:57 2016
# Generated by iptables-save v1.6.0 on Tue Dec  6 16:50:57 2016
*filter
:INPUT ACCEPT [622109:207290282]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [549692:844806351]
:neutron-filter-top - [0:0]
:neutron-openvswi-FORWARD - [0:0]
:neutron-openvswi-INPUT - [0:0]
:neutron-openvswi-OUTPUT - [0:0]
:neutron-openvswi-i0695f2ca-b - [0:0]
:neutron-openvswi-i839737e6-1 - [0:0]
:neutron-openvswi-local - [0:0]
:neutron-openvswi-o0695f2ca-b - [0:0]
:neutron-openvswi-o839737e6-1 - [0:0]
:neutron-openvswi-s0695f2ca-b - [0:0]
:neutron-openvswi-s839737e6-1 - [0:0]
:neutron-openvswi-sg-chain - [0:0]
:neutron-openvswi-sg-fallback - [0:0]
:nova-api-FORWARD - [0:0]
:nova-api-INPUT - [0:0]
:nova-api-OUTPUT - [0:0]
:nova-api-local - [0:0]
:nova-filter-top - [0:0]
-A INPUT -j neutron-openvswi-INPUT
-A INPUT -j nova-api-INPUT
-A INPUT -i virbr0 -p udp -m udp --dport 53 -j ACCEPT
-A INPUT -i virbr0 -p tcp -m tcp --dport 53 -j ACCEPT
-A INPUT -i virbr0 -p udp -m udp --dport 67 -j ACCEPT
-A INPUT -i virbr0 -p tcp -m tcp --dport 67 -j ACCEPT
-A FORWARD -j neutron-filter-top
-A FORWARD -j neutron-openvswi-FORWARD
-A FORWARD -j nova-filter-top
-A FORWARD -j nova-api-FORWARD
-A FORWARD -d 192.168.122.0/24 -o virbr0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -s 192.168.122.0/24 -i virbr0 -j ACCEPT
-A FORWARD -i virbr0 -o virbr0 -j ACCEPT
-A FORWARD -o virbr0 -j REJECT --reject-with icmp-port-unreachable
-A FORWARD -i virbr0 -j REJECT --reject-with icmp-port-unreachable
-A FORWARD
-A FORWARD
-A OUTPUT -j neutron-filter-top
-A OUTPUT -j neutron-openvswi-OUTPUT
-A OUTPUT -j nova-filter-top
-A OUTPUT -j nova-api-OUTPUT
-A OUTPUT -o virbr0 -p udp -m udp --dport 68 -j ACCEPT
-A neutron-filter-top -j neutron-openvswi-local
-A neutron-openvswi-FORWARD -m physdev --physdev-out tap0695f2ca-bf --physdev-is-bridged -m comment --comment "Direct traffic from the VM interface to the security group chain." -j neutron-openvswi-sg-chain
-A neutron-openvswi-FORWARD -m physdev --physdev-in tap0695f2ca-bf --physdev-is-bridged -m comment --comment "Direct traffic from the VM interface to the security group chain." -j neutron-openvswi-sg-chain
-A neutron-openvswi-FORWARD -m physdev --physdev-out tap839737e6-15 --physdev-is-bridged -m comment --comment "Direct traffic from the VM interface to the security group chain." -j neutron-openvswi-sg-chain
-A neutron-openvswi-FORWARD -m physdev --physdev-in tap839737e6-15 --physdev-is-bridged -m comment --comment "Direct traffic from the VM interface to the security group chain." -j neutron-openvswi-sg-chain
-A neutron-openvswi-INPUT -m physdev --physdev-in tap0695f2ca-bf --physdev-is-bridged -m comment --comment "Direct incoming traffic from VM to the security group chain." -j neutron-openvswi-o0695f2ca-b
-A neutron-openvswi-INPUT -m physdev --physdev-in tap839737e6-15 --physdev-is-bridged -m comment --comment "Direct incoming traffic from VM to the security group chain." -j neutron-openvswi-o839737e6-1
-A neutron-openvswi-i0695f2ca-b -m state --state RELATED,ESTABLISHED -m comment --comment "Direct packets associated with a known session to the RETURN chain." -j RETURN
-A neutron-openvswi-i0695f2ca-b -s 172.24.220.3/32 -p udp -m udp --sport 67 -m udp --dport 68 -j RETURN
-A neutron-openvswi-i0695f2ca-b -s 172.24.220.2/32 -p udp -m udp --sport 67 -m udp --dport 68 -j RETURN
-A neutron-openvswi-i0695f2ca-b -p tcp -m tcp --dport 22 -j RETURN
-A neutron-openvswi-i0695f2ca-b -m set --match-set NIPv4e7b85005-a11b-405e-a60f- src -j RETURN
-A neutron-openvswi-i0695f2ca-b -m state --state INVALID -m comment --comment "Drop packets that appear related to an existing connection (e.g. TCP ACK/FIN) but do not have an entry in conntrack." -j DROP
-A neutron-openvswi-i0695f2ca-b -m comment --comment "Send unmatched traffic to the fallback chain." -j neutron-openvswi-sg-fallback
-A neutron-openvswi-i839737e6-1 -m state --state RELATED,ESTABLISHED -m comment --comment "Direct packets associated with a known session to the RETURN chain." -j RETURN
-A neutron-openvswi-i839737e6-1 -s 172.24.220.3/32 -p udp -m udp --sport 67 -m udp --dport 68 -j RETURN
-A neutron-openvswi-i839737e6-1 -s 172.24.220.2/32 -p udp -m udp --sport 67 -m udp --dport 68 -j RETURN
-A neutron-openvswi-i839737e6-1 -p tcp -m tcp --dport 22 -j RETURN
-A neutron-openvswi-i839737e6-1 -m set --match-set NIPv4e7b85005-a11b-405e-a60f- src -j RETURN
-A neutron-openvswi-i839737e6-1 -m state --state INVALID -m comment --comment "Drop packets that appear related to an existing connection (e.g. TCP ACK/FIN) but do not have an entry in conntrack." -j DROP
-A neutron-openvswi-i839737e6-1 -m comment --comment "Send unmatched traffic to the fallback chain." -j neutron-openvswi-sg-fallback
-A neutron-openvswi-o0695f2ca-b -s 0.0.0.0/32 -d 255.255.255.255/32 -p udp -m udp --sport 68 --dport 67 -m comment --comment "Allow DHCP client traffic." -j RETURN
-A neutron-openvswi-o0695f2ca-b -j neutron-openvswi-s0695f2ca-b
-A neutron-openvswi-o0695f2ca-b -p udp -m udp --sport 68 --dport 67 -m comment --comment "Allow DHCP client traffic." -j RETURN
-A neutron-openvswi-o0695f2ca-b -p udp -m udp --sport 67 -m udp --dport 68 -m comment --comment "Prevent DHCP Spoofing by VM." -j DROP
-A neutron-openvswi-o0695f2ca-b -m state --state RELATED,ESTABLISHED -m comment --comment "Direct packets associated with a known session to the RETURN chain." -j RETURN
-A neutron-openvswi-o0695f2ca-b -j RETURN
-A neutron-openvswi-o0695f2ca-b -m state --state INVALID -m comment --comment "Drop packets that appear related to an existing connection (e.g. TCP ACK/FIN) but do not have an entry in conntrack." -j DROP
-A neutron-openvswi-o0695f2ca-b -m comment --comment "Send unmatched traffic to the fallback chain." -j neutron-openvswi-sg-fallback
-A neutron-openvswi-o839737e6-1 -s 0.0.0.0/32 -d 255.255.255.255/32 -p udp -m udp --sport 68 --dport 67 -m comment --comment "Allow DHCP client traffic." -j RETURN
-A neutron-openvswi-o839737e6-1 -j neutron-openvswi-s839737e6-1
-A neutron-openvswi-o839737e6-1 -p udp -m udp --sport 68 --dport 67 -m comment --comment "Allow DHCP client traffic." -j RETURN
-A neutron-openvswi-o839737e6-1 -p udp -m udp --sport 67 -m udp --dport 68 -m comment --comment "Prevent DHCP Spoofing by VM." -j DROP
-A neutron-openvswi-o839737e6-1 -m state --state RELATED,ESTABLISHED -m comment --comment "Direct packets associated with a known session to the RETURN chain." -j RETURN
-A neutron-openvswi-o839737e6-1 -j RETURN
-A neutron-openvswi-o839737e6-1 -m state --state INVALID -m comment --comment "Drop packets that appear related to an existing connection (e.g. TCP ACK/FIN) but do not have an entry in conntrack." -j DROP
-A neutron-openvswi-o839737e6-1 -m comment --comment "Send unmatched traffic to the fallback chain." -j neutron-openvswi-sg-fallback
-A neutron-openvswi-s0695f2ca-b -s 172.24.220.12/32 -m mac --mac-source FA:16:3E:99:44:9E -m comment --comment "Allow traffic from defined IP/MAC pairs." -j RETURN
-A neutron-openvswi-s0695f2ca-b -m comment --comment "Drop traffic without an IP/MAC allow rule." -j DROP
-A neutron-openvswi-s839737e6-1 -s 172.24.220.5/32 -m mac --mac-source FA:16:3E:80:E1:45 -m comment --comment "Allow traffic from defined IP/MAC pairs." -j RETURN
-A neutron-openvswi-s839737e6-1 -m comment --comment "Drop traffic without an IP/MAC allow rule." -j DROP
-A neutron-openvswi-sg-chain -m physdev --physdev-out tap0695f2ca-bf --physdev-is-bridged -m comment --comment "Jump to the VM specific chain." -j neutron-openvswi-i0695f2ca-b
-A neutron-openvswi-sg-chain -m physdev --physdev-in tap0695f2ca-bf --physdev-is-bridged -m comment --comment "Jump to the VM specific chain." -j neutron-openvswi-o0695f2ca-b
-A neutron-openvswi-sg-chain -m physdev --physdev-out tap839737e6-15 --physdev-is-bridged -m comment --comment "Jump to the VM specific chain." -j neutron-openvswi-i839737e6-1
-A neutron-openvswi-sg-chain -m physdev --physdev-in tap839737e6-15 --physdev-is-bridged -m comment --comment "Jump to the VM specific chain." -j neutron-openvswi-o839737e6-1
-A neutron-openvswi-sg-chain -j ACCEPT
-A neutron-openvswi-sg-fallback -m comment --comment "Default drop rule for unmatched traffic." -j DROP
-A nova-api-INPUT -d 10.13.237.4/32 -p tcp -m tcp --dport 8775 -j ACCEPT
-A nova-filter-top -j nova-api-local
COMMIT
# Completed on Tue Dec  6 16:50:57 2016
