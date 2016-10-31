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
 $ export OS_AUTH_URL=http://10.0.2.32:5000/v2.0 \
          OS_TENANT_NAME=demo \
          OS_USERNAME=demo \
          OS_PASSWORD=$OPENSTACK_DEMO_PASSWORD          
```

* Lancer la commande de creation de VM

```
$ docker-machine --debug create --driver openstack \
     --openstack-flavor-name m1.small \
     --openstack-image-name "cirros-0.3.2-x86_64-uec" \
     --openstack-ssh-user "cirros" \
     --openstack-floatingip-pool public \
     --openstack-sec-groups default  \
     --openstack-nova-network \
     --openstack-net-name nova \
     INF1045
```

```
$ export DOCKER_TLS_VERIFY="1" \
       DOCKER_HOST="tcp://172.24.4.4:2376" \
       DOCKER_CERT_PATH="${HOME}/.docker/machine/machines/INF1045" \
       DOCKER_MACHINE_NAME="INF1045"
```

http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-amd64-disk1.img

Ubuntu 16.04 Image

```
$ wget http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img
```

```
$ glance --os-username=admin --os-password devstack \
         --os-tenant-name=admin \
         --os-auth-url=http://10.0.2.32:5000/v2.0 \
         image-create \
         --name="Ubuntu-16.04" \
         --is-public=true \
         --disk-format=qcow2 \
         --container-format=bare \
         --file xenial-server-cloudimg-amd64-disk1.img
```
