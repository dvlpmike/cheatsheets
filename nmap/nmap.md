## Install nmap
**For Debian/Ubuntu**
```sh
sudo apt-get update
sudo apt-get install nmap
```
**For RedHat/CentOS**
```sh
sudo yum install nmap
```
Check install version:
```sh
nmap -version
```
Official docs [here](https://nmap.org/book/man.html)

## Basic scan
```sh
# Scan one target
nmap <target>

# Scan multiple targets
nmap <target1> <target2> <target3>

# Scan range of IP addresses
nmap <start-end>
nmap 192.168.1.1-100

# Scan network
nmap 192.168.0.0/24
```

## Port scan
```sh
# Scan all ports
nmap -p- <target>

# Scan specific port
nmap -p <port> <target>

# Scan multiple ports
nmap -p <port1,port2,port3> <target>

#Scan top N ports:
nmap --top-ports <N> <target>
nmap --top-ports 10 192.168.1.1

# Fast mode - Scan fewer ports than the default scan
nmap -F <target>
```

## Host Discovery
```sh
# The fast way to check active hosts in the network
nmap -sn <target>
nmap -sn 192.168.1.0/24

# Treat all hosts as online -- skip host discovery (when icmp are block)
nmap -Pn <target>
```