# Installations Tests

## Par Devstack

Sur une machine ubuntu 16-.0.4

Suivre les instructions en clonant le repo suivant 
https://github.com/openstack-dev/devstack

```
$ git checkout stable/juno
$ ./stack.sh
```

## Par VirtualBox

http://codybum.com/openstackinaction/


## Newton Documentation

http://docs.openstack.org/newton/

## Creer une instance avec docker-machine

* Installer docker-machine
https://docs.docker.com/machine/install-machine/

* Pointer vers le controller OpenStack

```
 $ export OS_USERNAME=demo \
          OS_PASSWORD=$OPENSTACK_DEMO_PASSWORD \
          OS_TENANT_NAME=demo \
          OS_AUTH_URL=http://10.0.2.32:5000/v2.0
```

* Lancer la commande de creation de VM

```
$ docker-machine create --driver openstack \
     --openstack-flavor-name m1.small \
     --openstack-image-name "cirros-0.3.2-x86_64-uec" \
     --openstack-ssh-user "cirros" \
     --openstack-floatingip-pool public \
     --openstack-sec-groups default  \
     --openstack-nova-network \
     --openstack-net-name nova \
     INF1045
```

