# INF1045-16A

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
