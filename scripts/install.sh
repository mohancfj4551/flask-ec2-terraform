#!/bin/bash

# Update system
dnf update -y

# Install packages
dnf install -y python3 git nginx

# Install Python dependencies
pip3 install flask gunicorn

# Enable nginx
systemctl enable nginx

# Go to home
cd /home/ec2-user

# Clone repo if not exists
if [ ! -d "flask-ec2-terraform" ]; then
  git clone https://github.com/mohancfj4551/flask-ec2-terraform.git
fi

cd flask-ec2-terraform/app

# Kill old app
pkill -f gunicorn || true

# Start app with gunicorn (port 5000)
nohup gunicorn -w 2 -b 0.0.0.0:5000 app:app > app.log 2>&1 &

# Configure nginx to forward traffic
cat > /etc/nginx/conf.d/flask.conf <<EOF
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# Restart nginx
systemctl restart nginx