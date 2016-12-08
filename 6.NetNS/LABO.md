# namespace labo

## Création du namespace :
```
$ sudo ip netns add labo
```
Verification:
```
$ sudo ip netns
labo
<...>
```

Mais où sont passées nos interfaces ! ;-)
```
$ sudo ip netns exec labo ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```
Que dire de la sécurité?
```
$ sudo ip netns exec labo iptables -nL
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination   
```

## On créer une paire d’interfaces :

lab1 : interface dédiée au namespace  
lab0 : pont entre le lien physique (eth0) et l’interface du namespace (lab1)

```
$ sudo ip link add lab0 type veth peer name lab1
```
Verification:
```
$ ifconfig -a lab0; ifconfig -a lab1
lab0      Link encap:Ethernet  HWaddr ce:60:a8:61:6f:86  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lab1      Link encap:Ethernet  HWaddr 96:30:93:2f:2f:90  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

## On migre lab1 dans le namespace :

```
$ sudo ip link set lab1 netns labo
```
Verification:
```
$ sudo ip netns exec labo ip link # Oooooh !
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
38: lab1@if39: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 96:30:93:2f:2f:90 brd ff:ff:ff:ff:ff:ff link-netnsid 0
```

## On configure le réseau comme on le ferait avec n’importe quel système.  
Note : j’utilise ip mais on pourrait utiliser ifconfig…

```
$ sudo ip netns exec labo ip a add 10.252.0.1/24 dev lab1
$ sudo ip netns exec labo ip link set lab1 up
```
Verification:
```
$ sudo ip netns exec labo ifconfig -a
lab1      Link encap:Ethernet  HWaddr 96:30:93:2f:2f:90  
          inet addr:10.252.0.1  Bcast:0.0.0.0  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          LOOPBACK  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```
on rajoute la route par defaut
```
$ sudo ip netns exec labo ip route add default via 10.252.0.254 dev lab1
```
Verification:
```
$ sudo ip netns exec labo ip route 
default via 10.252.0.254 dev lab1 linkdown 
10.252.0.0/24 dev lab1  proto kernel  scope link  src 10.252.0.1 linkdown 
```

## On positionne lab0 comme passerelle :

```
$ sudo ip a add 10.252.0.254/24 dev lab0
$ sudo ip l set lab0 up
```
Verification:
```
$ ifconfig -a lab0; ifconfig -a lab1
lab0      Link encap:Ethernet  HWaddr ce:60:a8:61:6f:86  
          inet addr:10.252.0.254  Bcast:0.0.0.0  Mask:255.255.255.0
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lab1: error fetching interface information: Device not found
```
On authorise le traffic 
```
$ sudo iptables -t nat -A POSTROUTING -s 10.252.0.0/24 -j MASQUERADE
```

## Nettoie
```
$ sudo ip netns del labo
$ sudo ip link delete lab0
```
