# My First Terraform Project

A small Terraform project for learning the Terraform workflow with AWS. The current example provisions one EC2 instance and keeps Terraform state locally.

## What Is Terraform?

Terraform is an infrastructure-as-code tool. Infrastructure is described in configuration files, and Terraform uses those files to plan and apply changes through cloud provider APIs.

The typical Terraform lifecycle is:

1. Write configuration.
2. Initialize the working directory.
3. Format and validate the configuration.
4. Review the execution plan.
5. Apply the plan.
6. Inspect or destroy the managed infrastructure when it is no longer needed.

<img width="972" height="305" alt="image" src="https://github.com/user-attachments/assets/c10034d5-4efc-4052-bffd-37a1d47a7de8" />

## Project Structure

```text
.
├── README.md
└── aws
    ├── local_state
    │   └── main.ts
    └── remote_state
```

> Note: `main.ts` contains Terraform configuration despite the `.ts` extension. Terraform normally loads files with the `.tf` extension. Rename it to `main.tf` before running Terraform commands in that directory.

The `remote_state` directory is reserved for a future backend configuration. It is currently empty.

## Prerequisites

- Terraform CLI 1.2 or later
- An AWS account
- AWS credentials configured for the CLI or environment
- Permission to create and delete EC2 instances
- An AWS region and AMI available to your account

Verify the installation:

```bash
terraform version
aws sts get-caller-identity
```

## Current Configuration

The example is configured to:

- Use the HashiCorp AWS provider, version `~> 4.16`
- Use AWS region `us-west-2`
- Create one `t2.micro` EC2 instance
- Apply the tag `Name = Terraform_Demo`
- Store state locally in the working directory

The AMI ID in the example is region-specific. Confirm that it exists and is compatible with your AWS account and region before applying the configuration.

## Run the Example

From the local-state directory:

```bash
cd aws/local_state
```

Rename the configuration file if needed:

```bash
mv main.ts main.tf
```

On Windows PowerShell, use:

```powershell
Rename-Item main.ts main.tf
```

Initialize Terraform and check the configuration:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
```

Create the instance after reviewing the plan:

```bash
terraform apply
```

Type `yes` when Terraform asks for confirmation.

To remove the resources created by this example:

```bash
terraform destroy
```

## State File Good Practices

Terraform state records the relationship between the configuration and real infrastructure. Treat it as sensitive because it may contain resource details or secrets.

- Do not commit `terraform.tfstate` or `.terraform/` to source control.
- Use a remote backend for shared or production work.
- Enable locking when the backend supports it.
- Restrict access to state storage.
- Keep state backups and review plan output before applying changes.

A typical `.gitignore` should include:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
```

## Local State and Remote State

The `aws/local_state` example uses local state, which is convenient for learning and individual experiments. A team should move state to a remote backend, such as an encrypted S3 bucket with state locking configured according to the AWS and Terraform versions in use.

Before adding a remote backend:

1. Create the backend storage with appropriate encryption and access controls.
2. Add a `backend` block to the Terraform configuration.
3. Run `terraform init` and confirm the state migration.
4. Verify that the team can access the backend safely.

Do not store AWS access keys directly in Terraform files. Use an AWS CLI profile, environment variables, or an approved credential mechanism instead.

## Modules and Reuse

As the project grows, move reusable infrastructure into Terraform modules. A module can package resources, variables, outputs, and documentation behind a small interface. Keep environment-specific values outside reusable modules and pass them through variables.

## Common Problems

- **Provider initialization fails:** check network access, Terraform version, and provider constraints.
- **AWS authentication fails:** run `aws sts get-caller-identity` and verify the active profile or environment variables.
- **The AMI is invalid:** AMI IDs are region-specific; select an AMI available in `us-west-2`.
- **Resources already exist:** review the plan and state before importing or recreating resources.
- **State is locked or inconsistent:** avoid concurrent changes and use the backend's documented recovery process.

## Useful Commands

```bash
terraform init       # Initialize providers and backend
terraform fmt        # Format configuration
terraform validate   # Check configuration syntax
terraform plan       # Preview changes
terraform apply      # Create or update resources
terraform show       # Display state or a saved plan
terraform state list # List resources tracked in state
terraform destroy    # Remove managed resources
```

## Learning Topics

This project is intended to introduce:

- Terraform configuration and providers
- Terraform initialization and the plan/apply lifecycle
- AWS resource provisioning
- Local versus remote state
- State security and collaboration
- Modules and reusable infrastructure
- Troubleshooting common Terraform and AWS errors

Always review the plan before applying changes and destroy learning resources when they are no longer needed to avoid unexpected AWS charges.
