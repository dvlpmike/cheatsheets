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

More information about the variables you can find [here](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html).

## Most useful commands
You can use ad-hoc module. The default module in ansible is command.
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

# Delete package
ansible all -m package -a 'name=nginx state=present'

```

## Ad-hoc modules
Ansible ad-hoc commands are commands that allow you to perform a one-time execution of one or more tasks on selected hosts, without the need to create and run playbooks.

The most popular ad hoc modules:
| Module Name | Description |
| --- | --- |
| `ping` | Allows to check if host is available |
| `shell` | Allows to run command on remote host using shell |
| `command` | Allows to run command on remote host |
| `copy` | Allows to copy files to remote host |
| `fetch` | Allows to download files from remote host |
| `file` | Allows to manage files and directories on remote host |
| `service` | Allows to manage services on remote host |
| `apt` | Allows to manage apt-based packages on Ubuntu/Debian systems on remote host |
| `yum` | Allows to manage yum-based packages on Red Hat/CentOS systems on remote host |
| `script` | Allows to run scripts on remote host |

```
# The pattern
ansible WHERE -m MODULE_NAME -a ARGUMENTS

# The example
ansible all -m ping

# The default module in ansible is command. You can run ad hoc module with ARGUMENTS without MODULE_NAME
ansible all -a 'upatime'

# The command wit shell module. The default shell is bash
ansible all -m shell -a 'ps aux | grep nginx'
```

More information about the ad hoc commands you can find [here](https://docs.ansible.com/ansible/latest/command_guide/intro_adhoc.html).

More information about the modules you can find [here](https://docs.ansible.com/ansible/latest/collections/index_module.html).