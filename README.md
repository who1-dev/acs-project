

# ACS 730 - Final Project (Terraform)

In this document, it will contain the necessary steps to run the terraform code and cleanup the resources after. Moreover, there will be 3 major steps to follow accordingly.


# Major steps

- Setting up the config file
- Provisioning of resources
- Resource Cleanup Instructions

## Setting up the config file

Change the value of the bucket parameter and use your own s3 bucket for these files

**config.tf** 
```bash
  backend "s3" {
    bucket = <your-s3-bucket-here>
    key    = ""                       #leave the default values provided in each config file.
    region = "us-east-1"
  }
```

**variables.tf** 
```bash
variable "remote_data_sources" {
  ...
  default = {
    network = {
      bucket = <your-s3-bucket-here>
      key    = "dev/networking/terraform.tfstate"
      region = "us-east-1"
    }
  }
}
```
**file paths:**
```bash
  <env>/network/config.tf
  <env>/network/variables.tf
  <env>/compute/config.tf
  <env>/compute/variables.tf
```


## Provisioning of resources
**Assumption**: You are in the **root folder** `~/acs_project` **in Step 1**

**Expectation** below commands will be executed for the `environment` selected

**Step 1: Provisioning the network resources**
#### 
```sh
# Go inside the network folder: replace <environment> 
cd <environment>/network

# Initialize Terraform
terraform init

# Validate the Terraform configuration
terraform validate

# Apply for to check the resoursces to be provisioned
terraform plan

# Apply the Terraform configuration
terraform apply -auto-approve

```
***Wait for the provisioning to complete first before proceeding on the next step***


**Step 2: Provisioning the compute resources**
#### 
```sh
# Go inside the webserver folder
cd ../webserver

# Initialize Terraform
terraform init

# Validate the Terraform configuration
terraform validate

# Apply for to check the resoursces to be provisioned
terraform plan

# Apply the Terraform configuration
terraform apply -auto-approve
```
***Wait for the provisioning to complete first before proceeding on the next step***

***Expected Result:*** provisioned the Network and Compute resources without issues


## Resource Cleanup Instructions

## Step-by-Step Cleanup Process
**Assumption**: You are in the **root folder** `~/acs_project` **in Step 1**

**Expectation** below commands will be executed for the selected `environment`

### Step 1: Destroy the Compute Resources
Run the following command to destroy the Compute resources:
```sh
# Go inside the Compute folder: replace <environment> 
cd <environment>/compute

# Destroy the resources
terraform destroy -auto-approve
```
***Wait for the cleanup to complete first before proceeding on the next step***

### Step 2: Destroy the Network Resources
Run the following command to destroy the network resources:
```sh
# Go inside the network folder: replace <environment> 
cd ../network

# Destroy the resources
terraform destroy -auto-approve
```
***Wait for the cleanup to complete first before proceeding on the next step***

***Expected Result:*** destroyed  the Webserver and Network resources without issues
