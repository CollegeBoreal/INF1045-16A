# OpenStack


## On Mac

```
$ sudo easy_install pip
$ sudo -H pip install python-openstackclient --upgrade --ignore-installed six
```

### [ImportError: No module named xmlrpc_client] issue

```
$ sudo -H pip uninstall python-novaclient
$ sudo easy_install python-novaclient
```

### Testing Nova Commands

```
$ nova --version
$ nova floating-ip-pool-list
$ nova image-list
$ nova flavor-list
```
## Set your environment Variables

```
$ source ~/Developer/canarie.ca/collège-boréal-openrc-quebec.sh
```

http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html

## Create the Docker Machine on OpenStack

```
$ docker-machine --debug \
  create --driver openstack \
         --openstack-flavor-name m1.tiny \
         --openstack-image-name "Ubuntu 14.04" \
         --openstack-ssh-user ubuntu \
         --openstack-sec-groups default \
    INF1069
```
## Check if the VM is running

```
$ nova list
```

## Check if there's an available floating IP address

```
$ nova floating-ip-list
```

## Assign the new IP address

```
$ nova add-floating-ip cd2c796d-4280-4328-9bed-b168c8229fe3 <external IP address>
```

## SSH into the host

```
$ ssh -o BatchMode=yes \
      -o PasswordAuthentication=no \
      -o StrictHostKeyChecking=no \
      -o UserKnownHostsFile=/dev/null \
      -o IdentitiesOnly=yes \
      -o LogLevel=quiet \
      -o ConnectionAttempts=3 -o ConnectTimeout=10 \
      -o ControlMaster=no -o ControlPath=none \
      -p 22 \
      -i ~/.docker/machine/machines/INF1069/id_rsa \
    ubuntu@<external IP address>
```
