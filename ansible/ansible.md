## Install ansible
**For Debian/Ubuntu**
```
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```
**For RedHat/CentOS**
```
sudo yum install epel-release
sudo yum install ansible
```
**For Another via pip**
```
pip3 install ansible
```

Check install version:
```
ansible --version
```

## Files and directories
Important paths and files.

| Component             | Description |
|-----------------------|-------------------------------------------------|
| Ansible Management Node | Host for ansible.|
| Inventory             | A file containing a list of hosts and variables.|
| Module                | Tool to do things like installing software, configuring settings.|
| Playbook              | Tasks scenario.|
| Variables             | Variables can be used in inventory and playbooks.|
| Configuration directory | Default directory with config files (e.g. for inventory /etc/ansible/hosts).|

## Basic Variables
| Variable              | Description|
|-----------------------|---------------------------------------------------------------------------------|
| `ansible_connection`  | Connection method (e.g. `ssh` or `winrm`).|
| `ansible_user`        | Username to login to the host.|
| `ansible_host`        | The name of the host that ansible is connecting to.|
| `ansible_port`        | The port number of the host that ansible is connecting to. Default 22.|
| `ansible_become`      | Specifies whether ansible should use `sudo` when executing commands.|
| `ansible_ssh_extra_args` | Additional settings for ssh conection.|

More information you can find [here](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html).

## Most useful commands
The default module in ansible is command.
```
# Ping pong all hosts
ansible -m ping all

# Check 'facts' (information about yours hosts)
ansible server -m setup | less

# Check hosts uptime
ansible -m uptime

# Run command in shell
ansible all -m shell -a 'ps aux | grep init'

# Copy files
ansible all -m copy -a 'src=/home/ansible/file dest=/tmp/file'

# Install package
ansible all -m package -a 'name=nginx state=present'

```
More information you can find [here](https://docs.ansible.com/ansible/latest/collections/index_module.html)