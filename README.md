# This is my trainee with Terraform ann GCP

> Note:  https://learn.hashicorp.com/collections/terraform/gcp-get-started

Installing Terraform. "curl" should be allready installed on your system.
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

terraform -install-autocomplete
```
Now restart your shell to enable tab completion

