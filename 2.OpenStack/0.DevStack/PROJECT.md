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

## Créer un réseau interne
```
$ neutron net-create --tenant-id bb39b2d8b3b2468a8fb06f5572568956 INTERNAL_NETWORK
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
| created_at                | 2016-12-01T22:59:11Z                 |
| description               |                                      |
| id                        | 201a3d60-1fab-4d36-93fb-bc2a1216e030 |
| ipv4_address_scope        |                                      |
| ipv6_address_scope        |                                      |
| mtu                       | 1450                                 |
| name                      | INTERNAL_NETWORK                     |
| port_security_enabled     | True                                 |
| project_id                | bb39b2d8b3b2468a8fb06f5572568956     |
| provider:network_type     | vxlan                                |
| provider:physical_network |                                      |
| provider:segmentation_id  | 65                                   |
| revision_number           | 3                                    |
| router:external           | False                                |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tags                      |                                      |
| tenant_id                 | bb39b2d8b3b2468a8fb06f5572568956     |
| updated_at                | 2016-12-01T22:59:11Z                 |
+---------------------------+--------------------------------------+
```

# OpenVSwitch

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

```
$ sudo ovs-vsctl show
```


