# Documentation
http://docs.openstack.org/admin-guide/networking-use.html   
http://docs.openstack.org/user-guide/cli-create-and-manage-networks.html  
http://blogs.igalia.com/dpino/2016/04/10/network-namespaces/  


# Créer son propre projet

## établir son environnement (admin)
```
$ sudo -i -u stack
$ cd /opt/devstack
$ source openrc admin admin
```

## Créer son projet
* Créer le projet General
```
$ openstack project create General
```
Retourne:
```
+-------------+----------------------------------+
| Field       | Value                            |
+-------------+----------------------------------+
| description | None                             |
| enabled     | True                             |
| id          | bb39b2d8b3b2468a8fb06f5572568956 |
| name        | General                          |
+-------------+----------------------------------+
```
* Lister les projets
```
$ openstack project list
```
Retourne:
```
+----------------------------------+--------------------+
| ID                               | Name               |
+----------------------------------+--------------------+
| 11b792e092164d98b3e12793366e503b | invisible_to_admin |
| 266243ee745e4eb0b7549ad0daa1e5f9 | alt_demo           |
| 26c2a062b4e84ad7bd81b7efc1974527 | admin              |
| 468617395c9b4b0f928ccd0e30f1ae18 | demo               |
| 84171fc996ea413388b139b6522217ac | service            |
| bb39b2d8b3b2468a8fb06f5572568956 | General            |
+----------------------------------+--------------------+
```

## Créer un utilisateur
```
$ openstack user create --password openstack1 --project General --email=johndoe@testco.com johndoe
```
Retourne:
```
+------------+----------------------------------+
| Field      | Value                            |
+------------+----------------------------------+
| email      | johndoe@testco.com               |
| enabled    | True                             |
| id         | fc6f210ea633406a978e83010af6b351 |
| name       | johndoe                          |
| project_id | bb39b2d8b3b2468a8fb06f5572568956 |
| username   | johndoe                          |
+------------+----------------------------------+
```
Vérification:
```
$ openstack user list
```

## Assigner un role à l'utilisateur
```
$ openstack role list
```
Retourne:
```
+----------------------------------+---------------+
| ID                               | Name          |
+----------------------------------+---------------+
| 1bd192821845403db911dad0e88f75fa | anotherrole   |
| 361dc1e8ebbe406e91b745b492056ad9 | service       |
| 6654acbdae4d4c24a622fe01f2a4dc0e | Member        |
| 9fe2ff9ee4384b1894a90878d3e92bab | _member_      |
| c8a2a58216ab4673a25c9e54029473fb | admin         |
| deb17ed230d84ec7b75c24603c336ee5 | ResellerAdmin |
+----------------------------------+---------------+
```
Retourne:
```
$ openstack role add --project General --user johndoe Member
```
Retourne:
```
+-----------+----------------------------------+
| Field     | Value                            |
+-----------+----------------------------------+
| domain_id | None                             |
| id        | 6654acbdae4d4c24a622fe01f2a4dc0e |
| name      | Member                           |
+-----------+----------------------------------+
```


## Créer un réseau interne
```
$ neutron net-create --tenant-id bb39b2d8b3b2468a8fb06f5572568956 GENERAL_NETWORK
```
Retourne:
```
Created a new network:
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| availability_zone_hints   |                                      |
| availability_zones        |                                      |
| created_at                | 2016-12-01T23:03:16Z                 |
| description               |                                      |
| id                        | db8714ed-ac3e-49a7-aec8-3b7e68cf33a5 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1450                                 |
| name                      | GENERAL_NETWORK                      |
| port_security_enabled     | True                                 |
| project_id                | bb39b2d8b3b2468a8fb06f5572568956     |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 26                                   |
| revision_number           | 3                                    |
| router:external           | False                                |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | bb39b2d8b3b2468a8fb06f5572568956     |
| updated_at                | 2016-12-01T23:03:16Z                 |
+---------------------------+--------------------------------------+
```
Vérification:
```
$ openstack network list
```

## Créer un sous-réseau interne
```
$ neutron subnet-create --tenant-id bb39b2d8b3b2468a8fb06f5572568956 GENERAL_NETWORK 172.24.220.0/24
```
Retourne:
```
Created a new subnet:
+-------------------+----------------------------------------------------+
| Field             | Value                                              |
+-------------------+----------------------------------------------------+
| allocation_pools  | {"start": "172.24.220.2", "end": "172.24.220.254"} |
| cidr              | 172.24.220.0/24                                    |
| created_at        | 2016-12-01T23:05:02Z                               |
| description       |                                                    |
| dns_nameservers   |                                                    |
| enable_dhcp       | True                                               |
| gateway_ip        | 172.24.220.1                                       |
| host_routes       |                                                    |
| id                | 9e2a6697-7ddc-4f7d-8a59-b2acc0f384d1               |
| ip_version        | 4                                                  |
| ipv6_address_mode |                                                    |
| ipv6_ra_mode      |                                                    |
| name              |                                                    |
| network_id        | db8714ed-ac3e-49a7-aec8-3b7e68cf33a5               |
| project_id        | bb39b2d8b3b2468a8fb06f5572568956                   |
| revision_number   | 2                                                  |
| service_types     |                                                    |
| subnetpool_id     |                                                    |
| tenant_id         | bb39b2d8b3b2468a8fb06f5572568956                   |
| updated_at        | 2016-12-01T23:05:02Z                               |
+-------------------+----------------------------------------------------+
```
Vérification:
```
$ openstack subnet list
```

## Créer un router
```
neutron router-create --tenant-id bb39b2d8b3b2468a8fb06f5572568956 GENERAL_ROUTER
```
Retourne:
```
Created a new router:
+-------------------------+--------------------------------------+
| Field                   | Value                                |
+-------------------------+--------------------------------------+
| admin_state_up          | True                                 |
| availability_zone_hints |                                      |
| availability_zones      |                                      |
| created_at              | 2016-12-01T23:07:44Z                 |
| description             |                                      |
| distributed             | False                                |
| external_gateway_info   |                                      |
| flavor_id               |                                      |
| ha                      | False                                |
| id                      | 19fe12e6-5bfe-4136-95ad-50ca3d4167ef |
| name                    | GENERAL_ROUTER                       |
| project_id              | bb39b2d8b3b2468a8fb06f5572568956     |
| revision_number         | 2                                    |
| routes                  |                                      |
| status                  | ACTIVE                               |
| tenant_id               | bb39b2d8b3b2468a8fb06f5572568956     |
| updated_at              | 2016-12-01T23:07:44Z                 |
+-------------------------+--------------------------------------+
```
Vérification:
```
$ openstack router list
```

## Rajout du sous-réseau au routeur
```
$ # neutron router-interface-add <router ID>  <subnet ID>
$ neutron router-interface-add 19fe12e6-5bfe-4136-95ad-50ca3d4167ef  9e2a6697-7ddc-4f7d-8a59-b2acc0f384d1
```
Retourne:
```
Added interface 6a5ca1ea-747a-4b05-b89c-90f126243bbd to router 19fe12e6-5bfe-4136-95ad-50ca3d4167ef.
```

## Rattacher le routeur au réseau externe

* Prendre la liste des sous-réseaux externes

```
$ neutron net-external-list
```
Retourne:
```
+--------------------------------------+--------+------------------------------------------------------+
| id                                   | name   | subnets                                              |
+--------------------------------------+--------+------------------------------------------------------+
| 45622527-184e-4a9a-a256-cc9b638a8b05 | public | a5c01daf-1a48-4a5e-a39c-564d8a0582ff 2001:db8::/64   |
|                                      |        | 08bfa6fe-b9ff-4377-a3f6-4f044da90b8a 10.13.237.80/28 |
+--------------------------------------+--------+------------------------------------------------------+
```

* Joindre la passerelle du routeur au réseau externe

```
$ neutron router-gateway-set <router ID>  <subnet ID>
$ neutron router-gateway-set 19fe12e6-5bfe-4136-95ad-50ca3d4167ef 45622527-184e-4a9a-a256-cc9b638a8b05
```
Retourne:
```
Set gateway for router 19fe12e6-5bfe-4136-95ad-50ca3d4167ef
```
Vérification:
```
$ neutron router-list
```
Retourne:
```
+--------------------------------------+----------------+---------------------------------------------------------------------------------------------------------------------------+-------------+-------+
| id                                   | name           | external_gateway_info                                                                                                     | distributed | ha    |
+--------------------------------------+----------------+---------------------------------------------------------------------------------------------------------------------------+-------------+-------+
| 19fe12e6-5bfe-4136-95ad-50ca3d4167ef | GENERAL_ROUTER | {"network_id": "45622527-184e-4a9a-a256-cc9b638a8b05", "enable_snat": true, "external_fixed_ips": [{"subnet_id":          | False       | False |
|                                      |                | "a5c01daf-1a48-4a5e-a39c-564d8a0582ff", "ip_address": "2001:db8::a"}, {"subnet_id": "08bfa6fe-                            |             |       |
|                                      |                | b9ff-4377-a3f6-4f044da90b8a", "ip_address": "10.13.237.92"}]}                                                             |             |       |
| e64e5e35-1d4a-4604-8bc7-2888bbba3c25 | router1        | {"network_id": "45622527-184e-4a9a-a256-cc9b638a8b05", "enable_snat": true, "external_fixed_ips": [{"subnet_id":          | False       | False |
|                                      |                | "a5c01daf-1a48-4a5e-a39c-564d8a0582ff", "ip_address": "2001:db8::1"}, {"subnet_id": "08bfa6fe-                            |             |       |
|                                      |                | b9ff-4377-a3f6-4f044da90b8a", "ip_address": "10.13.237.85"}]}                                                             |             |       |
+--------------------------------------+----------------+---------------------------------------------------------------------------------------------------------------------------+-------------+-------+
```

Vérification:
```
$ neutron router-port-list GENERAL_ROUTER
```
Retourne:
```
+--------------------------------------+------+-------------------+-------------------------------------------------------------------------------------+
| id                                   | name | mac_address       | fixed_ips                                                                           |
+--------------------------------------+------+-------------------+-------------------------------------------------------------------------------------+
| 6a5ca1ea-747a-4b05-b89c-90f126243bbd |      | fa:16:3e:6e:24:02 | {"subnet_id": "9e2a6697-7ddc-4f7d-8a59-b2acc0f384d1", "ip_address": "172.24.220.1"} |
| d4455c51-c52b-4448-9406-eebd89c14255 |      | fa:16:3e:4d:9d:e8 | {"subnet_id": "08bfa6fe-b9ff-4377-a3f6-4f044da90b8a", "ip_address": "10.13.237.92"} |
|                                      |      |                   | {"subnet_id": "a5c01daf-1a48-4a5e-a39c-564d8a0582ff", "ip_address": "2001:db8::a"}  |
+--------------------------------------+------+-------------------+-------------------------------------------------------------------------------------+
```

# Neutron

## OpenVSwitch

## Vérifier configuration OVS
```
$ sudo ovs-vsctl show
```
## Vérifier configuration OVS

|  Pont (Bridge) |  Utilitée                     |
|:--------------:|:------------------------------|
| br-ex          |                               |
| br-int         |                               |
| br-tun         |                               |
| ovs-system     |  Modules Noyaux d'OVS (actif) |

## Consulter les 'Linux Network Namespaces'

```
$ sudo ip netns list
```
Retourne:
```
qrouter-19fe12e6-5bfe-4136-95ad-50ca3d4167ef
qdhcp-db8714ed-ac3e-49a7-aec8-3b7e68cf33a5
qrouter-e64e5e35-1d4a-4604-8bc7-2888bbba3c25
qdhcp-77b611a4-08b6-43dd-a31d-e3d2827a051c
```

## Exécuter une commande sur un namespace particulier

* Example la configuration réseau d'un routeur particulier
```
$ # sudo ip netns exec <NameSpace ID> <Commande>
$ sudo ip netns exec qrouter-19fe12e6-5bfe-4136-95ad-50ca3d4167ef ifconfig -a
```
Retourne:
```
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

qg-d4455c51-c5 Link encap:Ethernet  HWaddr fa:16:3e:4d:9d:e8  
          inet addr:10.13.237.92  Bcast:10.13.237.95  Mask:255.255.255.240
          inet6 addr: fe80::f816:3eff:fe4d:9de8/64 Scope:Link
          inet6 addr: 2001:db8::a/64 Scope:Global
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:21 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:28 (28.0 B)  TX bytes:1510 (1.5 KB)

qr-6a5ca1ea-74 Link encap:Ethernet  HWaddr fa:16:3e:6e:24:02  
          inet addr:172.24.220.1  Bcast:172.24.220.255  Mask:255.255.255.0
          inet6 addr: fe80::f816:3eff:fe6e:2402/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
          RX packets:25 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1 
          RX bytes:3378 (3.3 KB)  TX bytes:990 (990.0 B)
```

## Sortir du host
* Modifier les paramètres du noyau permettant le 'forwarding' des routes
```
$ sudo vi /etc/sysctl.conf

net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.all.rp_filter=0
net.ipv4.ip_forward=1
```
* valider la configuration
```
$ sudo sysctl -p
```



# Glance

## Installer ubuntu 16.04 Cloud

```
$ wget http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
```

## Installer l'image d'ubuntu 16.04 Cloud dans glance

```
$ openstack image create \
         --disk-format qcow2 \
         --container-format bare \
         --public \
         --file ./xenial-server-cloudimg-amd64-disk1.img \
         Ubuntu-16.04
```
Retourne:
```
+------------------+------------------------------------------------------+
| Field            | Value                                                |
+------------------+------------------------------------------------------+
| checksum         | 35fd929b17d6c3532d04aa66e3d6ab7e                     |
| container_format | bare                                                 |
| created_at       | 2016-12-06T18:46:55Z                                 |
| disk_format      | qcow2                                                |
| file             | /v2/images/ceaf26e9-edc6-4048-980f-3a0d25202b85/file |
| id               | ceaf26e9-edc6-4048-980f-3a0d25202b85                 |
| min_disk         | 0                                                    |
| min_ram          | 0                                                    |
| name             | Ubuntu-16.04                                         |
| owner            | 26c2a062b4e84ad7bd81b7efc1974527                     |
| protected        | False                                                |
| schema           | /v2/schemas/image                                    |
| size             | 315228160                                            |
| status           | active                                               |
| tags             |                                                      |
| updated_at       | 2016-12-06T18:47:03Z                                 |
| virtual_size     | None                                                 |
| visibility       | public                                               |
+------------------+------------------------------------------------------+
```

$ nova boot --flavor m1.tiny --image Ubuntu-16.04 --nic net-id=<NET_ID> --key-name <KEY_PAIR> instancetest1
$ ssh -i <KEY_PAIR> ubuntu@<INSTANCE_FLOATING_IP>


