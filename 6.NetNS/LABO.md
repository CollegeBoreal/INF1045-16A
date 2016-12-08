# namespace labo

## Mise en place du namespace labo

* Création du namespace :
```
$ sudo ip netns add labo
```
Verification:
```
$ sudo ip netns
```
Retourne:
```
labo
<...>
```

Mais où sont passées nos interfaces ! ;-)

```
$ sudo ip netns exec labo ip l
$ sudo ip netns exec labo iptables -nL
```


* On créer une paire d’interfaces :

lab1 : interface dédiée au namespace
lab0 : pont entre le lien physique (eth0) et l’interface du namespace (lab1)

```
$ sudo ip link add lab0 type veth peer name lab1
```

On migre lab1 dans le namespace :

```
$ sudo ip link set lab1 netns labo
$ sudo ip netns exec labo ip link # Oooooh !
```

* On configure le réseau comme on le ferait avec n’importe quel système.  
Note : j’utilise ip mais on pourrait utiliser ifconfig…

```
$ sudo ip netns exec labo ip a add 10.252.0.1/24 dev lab1
$ sudo ip netns exec labo ip l set lab1 up
$ sudo ip netns exec labo ip r add default via 10.252.0.254 dev lab1
```

* On positionne lab0 comme passerelle :

```
$ sudo ip a add 10.252.0.254/24 dev lab0
$ sudo ip l set jun0 up
$ sudo iptables -t nat -A POSTROUTING -s 10.252.0.0/24 -j MASQUERADE
```
