#!/bin/bash

cd /home/ec2-user

git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git app

cd app/app

pip3 install -r requirements.txt

nohup gunicorn -b 0.0.0.0:5000 app:app &