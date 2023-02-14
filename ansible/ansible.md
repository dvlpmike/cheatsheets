## Install ansible
**For Debian/Ubuntu**
```sh
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible
```
**For RedHat/CentOS**
```sh
sudo yum install epel-release
sudo yum install ansible
```
**For Another via pip**
```sh
pip3 install ansible
```

Check install version:
```sh
ansible --version
```
More information about installation you can find [here](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

## Components
Important components.

| Component             | Description |
|-----------------------|-------------------------------------------------|
| Ansible Management Node | Host for ansible.|
| Inventory             | A file containing a list of hosts and variables.|
| Module                | Tool to do things like installing software, configuring settings.|
| Playbook              | Tasks scenario.|
| Variables             | Variables can be used in inventory and playbooks.|
| Configuration directory | Default directory with config files (e.g. for inventory /etc/ansible/hosts).|
| The default location of the inventory file | `/etc/ansible/hosts`|

## Basic Variables
- Ansible uses variables to store values that can be reused throughout playbooks.
- To define a variable in a playbook: VARNAME: VALUE
- To reference a variable in a playbook: {{ VARNAME }}
- To pass a variable to a module: ansible HOSTNAME -m MODULE_NAME -a "MODULE_ARGUMENTS VARNAME=VALUE"

Popular variables

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
```sh
# Ping pong all hosts
ansible -m ping all

# Check 'facts' (information about yours hosts)
ansible server -m setup | less

# Check hosts uptime
ansible -m shell -a 'uptime'

# Run command in shell
ansible all -m shell -a 'ps aux | grep init'

# Copy files
ansible all -m copy -a 'src=/home/ansible/file dest=/tmp/file'

# Install package
ansible all -m package -a 'name=nginx state=present'

# Delete package
ansible all -m package -a 'name=nginx state=present'

```
## Inventory

Ansible uses an inventory file to define the hosts that it manages.

You can also specify a different inventory file by using the -i flag when running Ansible commands.

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

```sh
# The pattern
ansible SERVER -m MODULE_NAME -a ARGUMENTS

# The example
ansible all -m ping

# The default module in ansible is command. You can run ad hoc module with ARGUMENTS without MODULE_NAME
ansible all -a 'upatime'

# The command wit shell module. The default shell is bash
ansible all -m shell -a 'ps aux | grep nginx'
```
More information about the ad hoc commands you can find [here](https://docs.ansible.com/ansible/latest/command_guide/intro_adhoc.html).

More information about the modules you can find [here](https://docs.ansible.com/ansible/latest/collections/index_module.html).

## Facts
System information.
```sh
# Module setup
ansible SERVER -m setup
```
## Magic Variables
Ansible information.
```sh
# Check host groups
ansible SERVER -m debug -a 'var=groups'
```
## Playbooks
| Name | Description |
| --- | --- |
| hosts_vars | Variables for specific hosts |
| group_vars | Variables for specific group of hosts |
```sh
# Add variable to group_vars
echo "ssh_user: dvlpmike" > group_vars/all

# Create dir for playbook
mkdir playbooks
```
Generate SSH Keys:
```yaml
# Generate SSH key (local) using module openssh_keypair
- name: Generate SSH keys
  hosts: local
  tasks:
    - name: Generate SSH keys for user
      openssh_keypair:
        path: "/root/playbooks/ssh_keys/{{ item }}"
        type: ed25519
        state: present

# Generate SSH key (local) using module openssh_keypair for multiply users
- name: Generate SSH keys
  hosts: local
  tasks:
    - name: Generate SSH keys for user
      openssh_keypair:
        path: "/root/playbooks/ssh_keys/{{ item }}"
        type: ed25519
        state: present
      loop: "{{ ssh_user }}"
```
Authorized keys:
```yaml
# Add authorized_key
- name: Add authorized_key
  authorized_key:
    user: dvlpmike
    state: present
    key: "{{ lookup('file','/root/playbook/ssh_keys/dvlpmike.pub') }}"

# Add authorized_keys
- name: Add authorized_keys
  authorized_key:
    user: "{{ item }}"
    state: present
    key: "{{ lookup('file','/root/playbook/ssh_keys/' + item + '.pub') }}"
  loop: "{{ ssh_user }}"
```
Conditions:
```yaml
- name: Install bind-utils on CentOS
  package:
    name: bind-utils
    state: present
  when: ansible_facts['os_family'] == "RedHat"

- name: Update apt cache
  apt:
    update_cache: yes
  when: ansible_facts['os_family'] == "Debian"

- name: Install bind-utils on Debian
  package:
    name: bind9-utils
    state: present
  when: ansible_facts['os_family'] == "Debian"
```
Copy files:
```yaml
- name: copy file to all machines
  copy:
    src: file
    dest: /tmp/file
    owner: dvlpmike
    group: dvlpmike
    mode: u=rw,g=rw,o=r
```
Tags:
```yaml
- name: copy file to all machines
  copy:
    src: file
    dest: /tmp/file
    owner: dvlpmike
    group: dvlpmike
    mode: u=rw,g=rw,o=r
  tags: cpfile 

```
We can only run one task from the playbook
```sh
ansible-playbook --tags cpfile site.yaml
```
Firewall:
```yaml
- name: firewall Ubuntu
  include_tasks: ubuntu_firewall.yaml
  when: ansible_facts['os_family'] == "Debian"
  tags: firewall

# Content of ubuntu_firewall.yaml
- name: allow open ports
  ufw:
    rule: allow
    port: 80
    proto: tcp
  tags: firewall
  
- name: Default policy to deny and enable ufw
  ufw:
    state: enabled
    policy: deny
  tags: firewall
```

## Roles
| Feature | Description |
|---------|-------------|
| Roles | Reusable units of automation that can be shared and used across multiple playbooks |
| Directory Structure | Each role should have a defined directory structure, usually with the following subdirectories: <br> `defaults` - contains default values for variables <br> `tasks` - contains main list of actions to be executed <br> `files` - contains files that need to be deployed <br> `templates` - contains files to be used as templates <br> `vars` - contains variables that are specific to the role |
| Variables | Variables can be defined in multiple places and the precedence order is: <br> `role defaults` <br> `inventory file` <br> `playbook` <br> `command line` |
| Dependencies | Roles can depend on other roles, these dependencies are defined in a file named `meta/main.yml` |
| Using Roles | Roles can be used in playbooks by using the `roles` keyword and providing the role name |

**External roles**

```sh
# Install role for all users
ansible-galaxy install ROLE_NAME -p /etc/ansible/roles

# For example install docker
ansible-galaxy collection install community.docker

# For example install docker globally
ansible-galaxy collection install community.docker -p /etc/ansible/roles
```
More external roles you can find [here](https://galaxy.ansible.com)

**Own roles**
```sh
# Init role
ansible-galaxy init MY_OWN_ROLE

# Go to the role directory
cd /etc/ansible/roles/MY_OWN_ROLE
```
| Directory Name | Description                                                                                                   |
|----------------|---------------------------------------------------------------------------------------------------------------|
| `defaults`     | Contains default variables for the role. These variables are automatically loaded by Ansible when the role is used. |
| `files`        | Contains files that can be deployed to remote hosts by the role.                                             |
| `handlers`     | Contains handlers that can be used by the role. Handlers are tasks that are only executed when notified by other tasks. |
| `meta`         | Contains metadata for the role, including author, description, and dependencies.                              |
| `tasks`        | Contains the main tasks for the role. These are the tasks that will be executed when the role is run.           |
| `templates`    | Contains templates that can be used by the role. Templates are files that can be customized with variables.     |
| `tests`        | Contains test files for the role. These files can be used to test the role with molecule or other testing frameworks. |
| `vars`         | Contains variables that can be used by the role. These variables can be customized by users to change the behavior of the role. |
| `README.md`    | A markdown file that contains information about the role, including a description of its purpose and how to use it. |


More information about the roles you can find [here](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html)


