Prerequisite
============

```
sudo apt-get install -y ansible python-psutil

# Don't run by root
ansible-playbook UbunutDevMachine-1804.yml

```


```
curl  https://api.github.com/users/benlau/keys  | sed 's/.*\(ssh.*\)"/\1/g' | grep ssh >> ~/.ssh/authorized_keys
```


