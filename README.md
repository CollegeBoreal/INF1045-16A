# INF1045-16A

```
$ docker-machine create --driver openstack 
     --openstack-flavor-name m1.small 
     --openstack-image-name "Ubuntu 14.04" 
     --openstack-ssh-user ubuntu 
     --openstack-floatingip-pool nova 
     --openstack-sec-groups default  
     --openstack-nova-network 
     --openstack-net-name nova 
     INF1045
```
