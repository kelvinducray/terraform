# Terraform
A collection of examples for learning how to deploy infrastructure with Terraform.

## Instructions
### Before starting
- Set up authentication with AWS cli by running ```aws configure```
- Recommended: Use the HashiCorp Terraform VSCode extension for auto-formatting and syntax highlighting 

### When starting a new project:
- Create your .tf file
- Execute ```terraform init```
- Check for formatting of configuration files by running ```terraform fmt```
- Ensure your .tf files are valid with ```terraform validate```
- Deploy infrastructure with ```terraform apply```

Lastly, you can check the current state with ```terraform show``` to see what resources have been deployed.

### Clean-up
Terraform makes cleaning up deployed resources incredibly easy, just run ```terraform destroy```
