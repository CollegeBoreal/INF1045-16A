# Grille d'evaluation


## Énoncé

-[*][Noté]

-[*] Prérequis - Openstack  [LIN]

    1) Installer un serveur Linux - Linux 16.04.1 LTS (Xenial Xerus)
    2) Créer un nuage en mode développement (devstack - Newton)

-[*] Configurer un nuage - Openstack  [OPS] 

    1) Créer un projet (Tenant) avec utilisateurs (au moins un)
    2) Attacher un reseau externe au projet (fournir le schéma du réseau proposé)
    3) installer une image de votre choix (compatible Docker)
    4) Créer une machine virtuelle
        Note: Se référer à OpenStack in Action - chapitre 3

-[ ] Lancer un service - Docker (Optionnel) 

    * Créer une machine virtuelle (docker-machine)
    * Créer une simple orchestration (docker-compose)
    * Au moins deux microservices sont requis (web,DB) ou (web,media server), ...

-[*] Recherche et attitude envers l'adversité [REC]

    1. Recherche Efficace de l'information
    2. Persistent dans sa recherche
    3. Ouvert à la nouveauté

-[*] Blog [BLG]

    1. Clarté de l'information
    2. Bonne présentation

## Notation 

(1 Faible - 5 Tres Bon)

| ID  |LIN1|LIN2|OPS1|OPS2|OPS3|OPS4|REC1|REC2|REC3|BLG1|BLG2| Points (11 * 5 = 55)             |
|----:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|----------------------------------|  
|     |    |    |    |    |    |    |    |    |    |    |    | Comments                         |
| 6ix | 5  | 4  | 5  |  2 |  1 | 3  |  3 |  1 |  3 |  3 |  5 | (Voir ci-dessous)                |  
| IR  | 5  | 5  | 2  |  2 |  2 | 2  |    |  2 |  2 |  3 |  3 | (Voir ci-dessous)                |  

--

# Greater6ix

![Toronto](http://10.13.237.2)

## Commentaires

    2. Installer OpenStack
        Trés bien, J'apprécie les explications

    3. Créer un projet (tenant)
        * Mettre commande screenrc dans 1. Install OpenStack et expliquer que ca lance les services
        
    4. Attacher un réseau externe
        * Il fallait créer un seul sous-réseau interne et l'attacher au réseau externe existant
        * Il manque le routeur pour acceder au reseau du projet
        $ ip netns
            labo (id: 0)
            qdhcp-3df057b6-4d80-4e85-8466-cd90671dd4cb
            qrouter-079bac2e-6862-4ebb-ad46-e0d14417ef18
            qdhcp-641e59da-142d-4a25-8abf-6124d5101c1d

        * Par conséquent l'accès à l'instance est impossible            
         $ sudo ip netns exec qdhcp-3df057b6-4d80-4e85-8466-cd90671dd4cb ssh cirros@172.16.220.14
         ssh: connect to host 172.16.220.14 port 22: No route to host

-- 

### Topologie

![alt tag](https://github.com/CollegeBoreal/INF1045-16A/blob/master/4.Blog/6ix_Neutron1.png)


-- 

### Graphique
![alt tag](https://github.com/CollegeBoreal/INF1045-16A/blob/master/4.Blog/6ix_Neutron2.png)
        
    5. Installer une image
        * Il fallait installer une image Ubuntu (compatible docker)
        * ou as tu trouvé l'image centos63.qcow? je ne vois ni de wget, ni de curl dans l'explication de ton blog
        


--

# IRCodes

![Mississauga](http://10.13.237.3)

## Commentaires

    1. Installing DevStack
        Trés bien, 
        précis mais manque d'explications à l'utilisateur cherchant des informations générales sur le cloud

    2. Creating Tenants (Projects)
        * Rappel: Toujours appliquer les commandes en seconnectant à l'utilisateur stack
        Bien, 
        
    3. Neutron
        Bien, un peu plus d'explications

-- 

### Topologie
![alt tag](https://github.com/CollegeBoreal/INF1045-16A/blob/master/4.Blog/IR_Neutron2.png)
-- 

### Graphique
![alt tag](https://github.com/CollegeBoreal/INF1045-16A/blob/master/4.Blog/IR_Neutron1.png)
        
    4. Glance
        Bien, manque d'explications
        
        stack@mississauga:~$ sudo ip netns exec qdhcp-a14ac27f-0ed8-4c44-87a9-0b13e6198029 ssh ubuntu@172.16.0.1
        ssh: connect to host 172.16.0.1 port 22: Connection refused
        stack@mississauga:~$ sudo ip netns exec qdhcp-a14ac27f-0ed8-4c44-87a9-0b13e6198029 ifconfig -a
        lo        Link encap:Local Loopback  
                  inet addr:127.0.0.1  Mask:255.0.0.0
                  inet6 addr: ::1/128 Scope:Host
                  UP LOOPBACK RUNNING  MTU:65536  Metric:1
                  RX packets:14 errors:0 dropped:0 overruns:0 frame:0
                  TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
                  collisions:0 txqueuelen:1 
                  RX bytes:1424 (1.4 KB)  TX bytes:1424 (1.4 KB)

        tapaccb9f87-08 Link encap:Ethernet  HWaddr fa:16:3e:24:38:89  
                  inet addr:172.16.0.2  Bcast:172.16.0.255  Mask:255.255.255.0
                  inet6 addr: fd24:7104:1ac5:0:f816:3eff:fe24:3889/64 Scope:Global
                  inet6 addr: fe80::f816:3eff:fe24:3889/64 Scope:Link
                  UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
                  RX packets:21091 errors:0 dropped:0 overruns:0 frame:0
                  TX packets:41 errors:0 dropped:0 overruns:0 carrier:0
                  collisions:0 txqueuelen:1 
                  RX bytes:2193248 (2.1 MB)  TX bytes:2174 (2.1 KB)

