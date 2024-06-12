# setup

- setup terraform

```bash
terraform init
```

- plan the changes that need to be apply

```bash
terraform plan -var-file=dev.tfvars   
```

- deploy the changes to infra

```bash
terraform apply -var-file=dev.tfvars   
```

- destroy the infra

```bash
terraform destroy -var-file=dev.tfvars                                                                                     ─╯

```
