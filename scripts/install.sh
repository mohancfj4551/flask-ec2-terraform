#!/bin/bash

dnf update -y
dnf install -y python3 git nginx

pip3 install flask gunicorn

systemctl enable nginx
systemctl start nginx