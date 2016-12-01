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


