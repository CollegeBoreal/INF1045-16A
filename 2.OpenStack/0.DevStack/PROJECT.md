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

# OpenVSwitch

## Vérifier configuration OVS
```
$ sudo ovs-vsctl show
```
## Vérifier configuration OVS

|  Bridge  |  Utilitée  |
|:--------:|:----------:|
| br-ex    |            |

```
$ sudo ovs-vsctl show
```


