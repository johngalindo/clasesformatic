#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
cat <<EOF >/var/www/html/index.html
<html>
<head>
<title> hola $1 </title>
 <h1>hola desde $1</h1>
</html>
EOF

