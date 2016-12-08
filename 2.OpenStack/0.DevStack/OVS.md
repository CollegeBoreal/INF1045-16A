

```
$ sudo ovs-vsctl show
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

Mac Address du bridge externe

```
$ sudo ovs-appctl fdb/show br-ex
 port  VLAN  MAC                Age
    1     0  fa:16:3e:4d:9d:e8    0
```

Mac Address du bridge interne

```
$ sudo ovs-appctl fdb/show br-int
 port  VLAN  MAC                Age
    8     1  fa:16:3e:61:7d:34   40
   12     3  fa:16:3e:6e:24:02    9
   17     3  fa:16:3e:00:ae:10    2
   18     3  fa:16:3e:80:e1:45    2
   14     2  fa:16:3e:4d:9d:e8    1
```
```
$ sudo ovs-ofctl show br-ex
OFPT_FEATURES_REPLY (xid=0x2): dpid:00006ab64e982443
n_tables:254, n_buffers:256
capabilities: FLOW_STATS TABLE_STATS PORT_STATS QUEUE_STATS ARP_MATCH_IP
actions: output enqueue set_vlan_vid set_vlan_pcp strip_vlan mod_dl_src mod_dl_dst mod_nw_src mod_nw_dst mod_nw_tos mod_tp_src mod_tp_dst
 1(phy-br-ex): addr:c2:a4:db:81:60:32
     config:     0
     state:      0
     speed: 0 Mbps now, 0 Mbps max
 LOCAL(br-ex): addr:6a:b6:4e:98:24:43
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
OFPT_GET_CONFIG_REPLY (xid=0x4): frags=normal miss_send_len=0
```
mapping of OpenFlow ports to system ports
```
$ sudo ovs-ofctl show br-int
OFPT_FEATURES_REPLY (xid=0x2): dpid:000086c20ed4c84e
n_tables:254, n_buffers:256
capabilities: FLOW_STATS TABLE_STATS PORT_STATS QUEUE_STATS ARP_MATCH_IP
actions: output enqueue set_vlan_vid set_vlan_pcp strip_vlan mod_dl_src mod_dl_dst mod_nw_src mod_nw_dst mod_nw_tos mod_tp_src mod_tp_dst
 1(int-br-ex): addr:5a:aa:75:84:06:ca
     config:     0
     state:      0
     speed: 0 Mbps now, 0 Mbps max
 2(patch-tun): addr:02:f0:32:64:18:6e
     config:     0
     state:      0
     speed: 0 Mbps now, 0 Mbps max
 7(qvo0695f2ca-bf): addr:c2:ad:11:a1:86:e4
     config:     0
     state:      0
     current:    10GB-FD COPPER
     speed: 10000 Mbps now, 0 Mbps max
 8(qr-341cade3-25): addr:d4:47:00:00:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 12(qr-6a5ca1ea-74): addr:ab:e2:00:00:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 13(qr-ce849b98-cb): addr:93:d4:00:00:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 14(qg-d4455c51-c5): addr:7f:3d:00:00:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 15(qg-ea18c225-bd): addr:2a:ed:00:00:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 16(tap175a3b0e-2f): addr:9e:cb:fe:7f:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 17(tap26593dc1-6e): addr:9e:cb:fe:7f:00:00
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
 18(qvo839737e6-15): addr:06:a3:98:1e:99:59
     config:     0
     state:      0
     current:    10GB-FD COPPER
     speed: 10000 Mbps now, 0 Mbps max
 LOCAL(br-int): addr:86:c2:0e:d4:c8:4e
     config:     PORT_DOWN
     state:      LINK_DOWN
     speed: 0 Mbps now, 0 Mbps max
OFPT_GET_CONFIG_REPLY (xid=0x4): frags=normal miss_send_len=0
```

flow entries (OpenFlow) on mybridge
```
$ sudo ovs-ofctl dump-flows br-ex
NXST_FLOW reply (xid=0x4):
 cookie=0xb350d75db5c5ee65, duration=186909.559s, table=0, n_packets=55564, n_bytes=2333844, idle_age=3, hard_age=65534, priority=4,in_port=1,dl_vlan=2 actions=strip_vlan,NORMAL
 cookie=0xb350d75db5c5ee65, duration=186913.792s, table=0, n_packets=58534, n_bytes=2683172, idle_age=0, hard_age=65534, priority=2,in_port=1 actions=drop
 cookie=0xb350d75db5c5ee65, duration=186913.801s, table=0, n_packets=0, n_bytes=0, idle_age=65534, hard_age=65534, priority=0 actions=NORMAL
```
