# Nginx cheatsheet

## Install Nginx
Install nginx from official NGINX packages repository.

**For Debian/Ubuntu**

```
apt-get update

apt install -y curl gnupg2 ca-certificates lsb-release \
    debian-archive-keyring 

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
| tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

OS=$(lsb_release -is | tr '[:upper:]' '[:lower:]') RELEASE=$(lsb_release -cs)
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/${OS} ${RELEASE} nginx" \ | tee /etc/apt/sources.list.d/nginx.list

apt-get update

apt-get install -y nginx
```

**For RedHat/CentOS**

```
/etc/yum.repos.d/nginx.repo <<EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
gpgcheck=0
enabled=1
EOF

yum -y install nginx

systemctl enable nginx

systemctl start nginx

firewall-cmd --permanent --zone=public --add-port=80/tcp

firewall-cmd --reload
```

**Anohter options/versions**

You can check available versions of Nginx. For example for Debian/Ubuntu:
```
apt search nginx | grep nginx
```
You can also install a diffrent version of nginx [more information](https://wiki.debian.org/Nginx).

## Files and directories
Important paths and files.

| path                  | Description                                                    |
| ----------------------|:--------------------------------------------------------------:|
| /etc/nginx/           | The default configuration root for the NGINX server            |
| /var/log/nginx/       | The default log location for NGINX                             |
| /etc/nginx/conf.d/    | Contains the default HTTP server configuration file            |
| /etc/nginx/nginx.conf | The default configuration entry point used by the NGINX service|

## Basic most useful commands
 The most useful Nginx commands:

```
# Help
nginx -h

# Show version
nginx -v

# Test Nginx configuration
nginx -t

# Sends signal to nginx master process like stop, reload, etc.
nginx -s 

# Process managment
sudo systemctl start|stop|restart|status nginx
```
More commands you can find [here](https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline).

## Add website
You website files are in /var/www/example.com;
1. Create configuration file in /etc/nginx/sites-available, for example:
   ```
   server {
       listen 80;
       server_name example.com www.example.com;
       root /var/www/example.com;
   
       location / {
           try_files $uri $uri/ =404;
       }
   }
   ```
2. Create symbolik link to /etc/nginx/sites-enabled
   ```
   sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
   ```
3. Run test Nginx configuration
   ```
   sudo nginx -t
   ``` 
4. Restart or reload process
   ```
   sudo nginx -s reload
   ```

## Proxy
You have webapp in docker container running on port 3000:
1. Basic config
   ```
   server {
       listen 80;
       server_name example.com www.example.com;
   
       location / {
           proxy_pass http://localhost:3000/;
       }
   }
   ```
2. Run test Nginx configuration
   ```
   sudo nginx -t
   ``` 
3. Restart or reload process
   ```
   sudo nginx -s reload
   ```

## Rewrite
You can rewrite (with a rewrite directive) http to https or specific endpoint to another website:
```
rewrite ^/endpoint$ http://another-website.com;
```

## Snippets
You can create a snippets and include it in your configuration file:
1. Create snippet file in /etc/nginx/snippets
   ```
   location /admin {
      allow xxx.xxx.xxx.xxx;
      deny all;
   }
   ```
3. Add a snippet to configurations file, for example:
   ```
   include snippets/my-snippet.conf;
   ```

