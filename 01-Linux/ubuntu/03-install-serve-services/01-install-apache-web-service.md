To configure Apache as a frontend gateway (reverse proxy) on Ubuntu 26.04, you need to enable the proxy modules, configure a VirtualHost to route incoming traffic, and forward it to your backend services.

#### 1. Install and Enable Necessary Modules
First, ensure Apache is installed and activate the modules required for reverse proxying and SSL.
```sh
sudo apt update
sudo apt install apache2 -y
sudo a2enmod proxy proxy_http proxy_wstunnel ssl rewrite
sudo systemctl restart apache2
```
Allow HTTP traffic through the firewall: If you have UFW enabled, you need to allow port 80 with UFW for Apache to serve web pages:
```sh
sudo ufw allow 'Apache Full'
```
#### 2. Configure the Gateway VirtualHost
Create or edit a VirtualHost configuration file for your domain (e.g., ```/etc/apache2/sites-available/gateway.conf```).
```sh
# nano
sudo nano /etc/apache2/sites-available/gateway.conf

# vim
sudo vim /etc/apache2/sites-available/gateway.conf
```
Paste the following configuration, modifying the ```ServerName``` and ```ProxyPass``` directives to match your domain and backend application (e.g., a service running on ```localhost:3000```):
```ini
<VirtualHost *:80>
    ServerName example.com
    
    # Redirect HTTP to HTTPS
    Redirect permanent / https://example.com
</VirtualHost>

<VirtualHost *:443>
    ServerName example.com

    SSLEngine on
    # (Optional) Add your SSL Certificate paths here
    # SSLCertificateFile /etc/ssl/certs/example.com.crt
    # SSLCertificateKeyFile /etc/ssl/private/example.com.key

    # Enable Proxy Headers
    ProxyPreserveHost On
    ProxyRequests Off

    # Forward traffic to the backend application (e.g., Node.js, Python, etc.)
    ProxyPass / http://127.0.0
    ProxyPassReverse / http://127.0.0

    # WebSockets Support (if your app uses it)
    RewriteEngine On
    RewriteCond %{HTTP:Upgrade} =websocket [NC]
    RewriteRule /(.*) ws://127.0.0.1:3000/$1 [P,L]

    ErrorLog ${APACHE_LOG_DIR}/gateway_error.log
    CustomLog ${APACHE_LOG_DIR}/gateway_access.log combined
</VirtualHost>
```
#### 3. Enable the Site and Restart
Enable the configuration file and restart Apache to apply the new gateway rules.
```sh
sudo a2ensite gateway.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
```

<iframe width="560" height="315" src="https://www.youtube.com/embed/1rBaxk7U5GQ?si=ctcSWCQxkK6H3l9e" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

#### + reference +
<ol>
<li><a href="https://medium.com/@jieshiun/%E5%A6%82%E4%BD%95%E5%9C%A8-ubuntu-22-04-%E4%BD%BF%E7%94%A8-apache-%E4%BD%9C%E7%82%BA-reverse-proxy-3a113eae81f1" target="_blank">如何在 Ubuntu 22.04 使用 Apache 作為 Reverse Proxy</a></li>
<li><a href="https://www.milesweb.in/hosting-faqs/how-to-configure-apache-as-a-reverse-proxy-with-mod-proxy/" target="_blank">How to Configure Apache as a Reverse Proxy with mod_proxy?</a></li>
<li><a href="https://linuxconfig.org/how-to-install-and-configure-apache-on-ubuntu-26-04" target="_blank">How to Install and Configure Apache on Ubuntu 26.04</a></li>
<li><a href="https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-18-04" target="_blank">How To Secure Apache with Let's Encrypt on Ubuntu 18.04</a></li>
<li><a href="https://ithelp.ithome.com.tw/questions/10195775" target="_blank">用瀏覽器連線至Ubuntu內的apache網站 連不進？</a></li>
<li><a href="https://www.youtube.com/watch?v=1rBaxk7U5GQ" target="_blank">Install Apache Web Server on Ubuntu 26.04 | Host Your Website Step-by-Step (Beginner Guide)</a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
<li><a href="" target="_blank"></a></li>
</ol>
