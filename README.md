# **This is my trainee with Terraform and clouds**
---
<img alt="Terraform" src="https://www.datocms-assets.com/2885/1629941242-logo-terraform-main.svg" width="600px">   

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
- Go to [IAM tab](https://console.aws.amazon.com/iamv2/home?#/home) and create new user for TF  

Identity and Access Management (IAM) - Users - Access key - Programmatic access - Attach existing policies directly - AdministratorAccess

- Lets create our first tf file in AWS folder and call it AWS.tf

- So that no one can see our credits, we will do this (BTW aws-cli works with this envs too):
```bash
export AWS_ACCES_KEY_ID=AKIAVW4O6LWCEL35GXF3                          #  {your access_key}
export AWS_SECRET_ACCES_KEY=pR+                                       #  {your secret_key} *THIS ONE IS FAKE*
export AWS_DEFAULT_REGION=eu-central-1                                #  {your aws region}
```

```sh
terraform init                      # Prepare to create infrastructure
terraform plan                      # Dry Run
TF_LOG=DEBUG terraform apply        # Apply tf file / Verbose mode
terraform output                    # Show output section in a .tf file 
terraform show                      # Indicate what can be shown in output section
```
_aws_instance.Ubuntu: Creation complete after 36s [id=i-0b5276cc263987e99]_
- If we need to run a sequence of commands - script will be great. Use command file("*.sh")
- Lets find out the content of our script.sh via terraform
terraform console
file("script.sh")

- Lets add outputs.tf file. It will extend terraform outputs  
Now we can see our instance ip's.

- Create file named variables.tf to avoid hardcoding in our "main" file (AWS.tf)  
If we set them up as defalts and want to change, all we need is to run it this way
```sh
terraform (plan or apply) -var="region=us-west-1" -var=""
#!!!!!!!!!!!!!!!_________________OR_______________!!!!!!!!!!!!!!!!
export TF_VAR_region=us-west-1
terraform (plan or apply)
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OR create a file named terraform.tfvars or (even better) *.auto.tfwars. For example:
terraform (plan or apply) -var-file="stage.auto.tfvars"
```
And we will get _The image id '[ami-0d527b8c289b4af7f]' does not exist_ lol. Because AMI needs to be unhardcoded as well!!
Do not forget to monitor all your instances in all regions. It may cost you a fortune.
Go to [AWS VPC](https://console.aws.amazon.com/vpc/home) - Running Instances - Only this region

- Now we create DataSource folder with file DataSource.tf in it
 ```sh
 mkdir DataSource && cd DataSource
 vi DataSource.tf
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
---

## GCP
- Lets create a new folder
```sh
mkdir GCP && cd GCP
touch GCP.tf
```
- Creds can be created at [IAM tab](https://console.cloud.google.com/iam-admin/serviceaccounts?project=myproject-334822) and exported like from AWS one:
```sh
export GOOGLE_CLOUD_KEYFILE_JSON="gcp.json"
```
- List of available images in the current progect can be found by pressing (>) buttor (top right corner) in the GCP console. Type down this
```
gcloud compute images list
```
