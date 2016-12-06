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
