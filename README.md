## Summary

* In this architecture, it's broken down into 4 layers. For best practice and for easier management. Each layer has a tfvars file which the user can easily update to customize the resources created.
* These 4 layers are:
    * **000base** - this layer creates all the networking resources (3 Private and 3 Public subnets).
    * **100beanstalk** - this layer creates the Elastic Beanstalk and its resources (EC2, Autoscaling group, ALB, and all it's required Security Groups)
    * **200data** - this layer creates the RDS security group and the RDS instance we'll be using as DB for our application. As well as the 2 S3 buckets.
    * **300cloudfront** - lastly, this layers creates our CloudFront distribution.

## Built with:

* Terraform (v0.14.0)
* AWS_ACCESS_KEYS and AWS_SECRET_ACCESS_KEYS are set as environment variables (link: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

### Step by Step deployment
* **Step 1: Clone the Repo**. This command will clone the repo and will change directory the recently cloned repo
```shell script
$ git clone https://github.com/antonio-rufo/tf-ryanpwtech-dev.git
```


* **Step 2: Create a S3 bucket for remote state storage.** Update the `terraform.tfvars` file with your account ID and region
```shell script
$ cd tf-ryanpwtec-dev
$ cd development/statebucket
$ vi terraform.tfvars
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```
Take note of the output for `state_bucket_id`. You'll need to update the `main.tf` on each layer with it. It is not yet possible to have the state bucket values interpolated.  


* **Step 3: Create your networking resources.** Update the `terraform.tfvars` file with your account ID and region. Then update `main.tf` with the `state_bucket_id` created in step 2. Update the State Bucket config.
```shell script
$ cd ../layers/000base
$ vi terraform.tfvars
$ vi main.tf
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

* **Step 4: Create your Elastic Beanstalk and its resources .** Update the `terraform.tfvars` file with your account ID and region. Then update `main.tf` with the `state_bucket_id` created in step 2. Update the State Bucket config as well as the Data sources for the remote state buckets.
```shell script
$ cd ../100beanstalk
$ vi terraform.tfvars
$ vi main.tf
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

* **Step 5: Create your RDS and S3 components.** Update the `terraform.tfvars` file with your account ID and region. Then update `main.tf` with the `state_bucket_id` created in step 2. Update the State Bucket config as well as the Data sources for the remote state.
```shell script
$ cd ../200data
$ vi terraform.tfvars
$ vi main.tf
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

* **Step 6: Create your CloudFront distribution.** Update the `terraform.tfvars` file with your account ID and region. Then update `main.tf` with the `state_bucket_id` created in step 2. Update the State Bucket config as well as the Data sources for the remote state buckets.
```shell script
$ cd ../300cloudfront
$ vi terraform.tfvars
$ vi main.tf
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```
