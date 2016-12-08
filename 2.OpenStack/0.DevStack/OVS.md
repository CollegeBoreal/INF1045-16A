

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
