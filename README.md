# Terraform

## What is terraform?
Terraform is an orchestration tool that will deploy AMIs into the cloud.

It can use many providers and use different types of images and/or provisioners.

In our stack, we have:
  - Chef sets up/provisions machine (configuration management)
  - Packer creates immutable images of our machines
  - Terraform is the orchestration tool that will setup infrastructure in the cloud.

# To run

Use `terraform init` and `terraform apply`. SSH into the app and set an environment variable with `export DB_HOST=mongodb://<db_ip>:27017/posts`. `cd` into `home/ubuntu/app`. Run `sudo npm install ejs express mongoose`. Run `node app.js`
