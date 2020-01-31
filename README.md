# Terraform

## What is terraform?
Terraform is an orchestration tool that will deploy AMIs into the cloud.

It can use many providers and use different types of images and/or provisioners.

In our stack, we have:
  - Chef sets up/provisions machine (configuration management)
  - Packer creates immutable images of our machines
  - Terraform is the orchestration tool that will setup infrastructure in the cloud.

# To run

Use `terraform init` and `terraform apply`. The app is now running on the public ip.
