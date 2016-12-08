# namespace labo

## Mise en place du namespace labo

* Création du namespace :
```
$ ip netns add labo
```
Mais où sont passées nos interfaces ! ;-)

```
$ ip netns exec labo ip l
$ ip netns exec labo iptables -nL
```


* On créer une paire d’interfaces :

lab1 : interface dédiée au namespace
lab0 : pont entre le lien physique (eth0) et l’interface du namespace (lab1)

```
$ ip link add lab0 type veth peer name lab1
```

On migre lab1 dans le namespace :

```
$ ip link set lab1 netns labo
$ ip netns exec labo ip link # Oooooh !
```

* On configure le réseau comme on le ferait avec n’importe quel système.  
Note : j’utilise ip mais on pourrait utiliser ifconfig…

```
$ ip netns exec labo ip a add 10.252.0.1/24 dev lab1
$ ip netns exec labo ip l set lab1 up
$ ip netns exec labo ip r add default via 10.252.0.254 dev lab1
```

* On positionne lab0 comme passerelle :

```
$ ip a add 10.252.0.254/24 dev lab0
$ ip l set jun0 up
$ iptables -t nat -A POSTROUTING -s 10.252.0.0/24 -j MASQUERADE
```
