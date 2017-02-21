## AUTO VHOST CONFIG
A tool written in Bash to automatically create a **Named Virtual Host** for Apache(HTTPD) server running on Fedora 24+ systems.

### Add following line in /etc/httpd/conf/httpd.conf file
`Include /etc/httpd/vhost/*.conf`

### Invocation
`# ./AutoVHost.sh test.example.com`
