# Fail2ban cheatsheet

## Install Fail2ban
Install Fail2ban from package repos.

**For Debian/Ubuntu**
```
sudo apt install fail2ban
```

**For RedHat/CentOS/Rocky**
```
# With yum package manages
sudo yum install fail2ban

# With dnf package manager
sudo dnf install fail2ban
```
## Start and stop Fail2ban
```
# Run to start Fail2ban
sudo systemctl start fail2ban

# Run to stop Fail2ban
sudo systemctl stop fail2ban
```

## Files and directories
| File/Directory  | Description |
|------------------|-------------|
| /etc/fail2ban    | Main configuration directory for Fail2ban |
| /etc/fail2ban/fail2ban.conf | Main configuration file for Fail2ban, where global settings are defined. You can define custom the file called fail2ban.local and it will allow you to rewrite the settings from fail2ban.conf |
| /etc/fail2ban/jail.conf | The most important file. Main jail configuration file, where the settings for each jail are defined. |
| /etc/fail2ban/jail.d | Directory where additional jail configuration files can be placed |
| /etc/fail2ban/filter.d  | Directory where additional filter files can be placed |
| /var/log/fail2ban.log | Fail2ban log file, where all activity is recorded |

## Basic most useful commands
```
# Start Fail2ban service
sudo fail2ban-client start

# Stop Fail2ban service
sudo fail2ban-client stop

# Reload Fail2ban service
sudo fail2ban-client reload

# Show the status of the Fail2ban service and list jails
sudo fail2ban-client status

# Remove a specific IP address from the ban list for a particular jail
sudo fail2ban-client set [jail-name] unbanip [ip-address]

# Add a specific IP address to the ban list for a particular jail
sudo fail2ban-client set [jail-name] banip [ip-address]

# Test if the Fail2ban service is running and responding to commands
sudo fail2ban-client ping

# Show the log file path for a specific jail
sudo fail2ban-client get [jail-name] logpath

# Show the findtime (time frame) for a specific jail
sudo fail2ban-client get [jail-name] findtime

# Show the bantime (ban time) for a specific jail
sudo fail2ban-client get [jail-name] bantime

# Set the bantime (ban time) for a specific jail
sudo fail2ban-client set [jail-name] bantime [seconds]

# Set the findtime (time frame) for a specific jail
sudo fail2ban-client set [jail-name] findtime [seconds]

# Set the maxretry (maximum number of attempts) for a specific jail
sudo fail2ban-client set [jail-name] maxretry [attempts]

# Show the status of a specific jail, including the number of currently banned IP addresses
sudo fail2ban-client status [jail-name]

# Add a specific IP address to the ignore list for a particular jail
sudo fail2ban-client set [jail-name] addignoreip [ip-address]

# Delete a specific IP address from the ignore list for a particular jail
sudo fail2ban-client set [jail-name] delignoreip [ip-address]

# Show the ignore list for a specific jail
sudo fail2ban-client get [jail-name] ignoreip

# Set the action for a specific jail
sudo fail2ban-client set [jail-name] action [action]

# Show the action for a specific jail
sudo fail2ban-client get [jail-name] action

# Set the backend for a specific jail
sudo fail2ban-client set [jail-name] backend [backend]

```

## References
- https://www.fail2ban.org
- https://github.com/fail2ban/fail2ban