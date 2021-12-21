# **This is my trainee with Terraform ann GCP**

> Note:  https://learn.hashicorp.com/collections/terraform/gcp-get-started
---
- Installing Terraform. "curl" should be allready installed on your system.
```sh
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

terraform -install-autocomplete
```
- Now restart your shell to enable tab completion
---
## AWS
- Go to https://console.aws.amazon.com/iamv2/home?#/home and create new user for TF  

Identity and Access Management (IAM) - Users - Access key - Programmatic access - Attach existing policies directly - AdministratorAccess

- Lets create our first tf file in AWS folder and call it AWS.tf

- So that no one sees our credits, we will do this (BTW aws-cli works with this envs too):
```bash
export AWS_ACCES_KEY_ID=AKIAVW4O6LWCEL35GXF3                          #  {your access_key}
export AWS_SECRET_ACCES_KEY=pR+                                       #  {your secret_key} *THIS ONE IS FAKE*
export AWS_DEFAULT_REGION=eu-central-1                                #  {your aws region}
```

```sh
terraform init                      # Prepare to create infrastructure
terraform plan                      # Dry Run
terraform apply                     # Apply tf file
terraform output                    # Show output section in a .tf file 
terraform show                      # Indicate what can be shown in output section
```
_aws_instance.Ubuntu: Creation complete after 36s [id=i-0b5276cc263987e99]_

- Lets find out the content of our script.sh
terraform console
file("script.sh")

- Lets add outputs.tf file. It will extend terraform outputs 
- Now we create DataSource folder with file DataSource.tf in it
 ```sh
 mkdir -p DataSource/DataSource.tf
 ```
- From data sources we can pull the data we need without even an acces to the aws console!! Just play   
```sh
terraform init
terraform apply
```
 - Outpul values can be used as variables this way ${values}



```sh
terraform destroy # Shut down all the instances mentioned in .tf file
```

> Note:  "terraform fmt" command is used to rewrite Terraform configuration files to a canonical format and style. :)