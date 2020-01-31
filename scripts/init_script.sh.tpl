#!/bin/bash

cd /home/ubuntu/app
sudo npm install
export DB_HOST=mongodb://${db_instance_ip}:27017/posts
node seeds/seed.js
node app.js
