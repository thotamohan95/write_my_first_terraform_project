**Terraform Fundamentals**
Terraform is an Infrastructure as Code (IaC) tool used to define, provision, manage, and track infrastructure using configuration files.

**📚 Table of Contents**
What Is Terraform?

Terraform Architecture

What Terraform Helps You Do

Terraform Workflow

Terraform State

Installing Terraform

Getting Help

Important Terraform Commands

Complete Terraform Flow

Terraform Modules

Common Challenges and Limitations

Terraform and GitOps

Terraform vs Configuration Management

Quick Revision

Terraform Cheat Sheet

**What Is Terraform?**
Terraform is an Infrastructure as Code (IaC) tool that allows you to define, provision, and manage infrastructure using configuration files.

Instead of manually creating infrastructure through a cloud provider's console, you describe the desired infrastructure in code and let Terraform manage it.

Basic Terraform Architecture
┌──────────────┐
│   Terraform  │
└──────┬───────┘
       │
       ▼
┌──────────────────┐
│ Terraform Provider│
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│    Target API    │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│  Infrastructure  │
└──────────────────┘

A Terraform Provider acts as a bridge between Terraform and an external platform or API.

**Examples of Terraform Providers**
AWS

Google Cloud

Microsoft Azure

Datadog

Kubernetes

GitHub

Many other platforms and services

**What Terraform Helps You Do**
Terraform provides several important capabilities.

1. Manage Infrastructure
Manage infrastructure across different cloud providers, platforms, and services.

For example:

Terraform
   │
   ├── AWS
   ├── Azure
   ├── Google Cloud
   ├── Kubernetes
   └── Other Services

2. Track Infrastructure
Terraform uses a state file to keep track of resources that it manages.

Terraform Configuration
          +
    Terraform State
          ↓
  Managed Infrastructure

3. Automate Changes
Infrastructure changes can be executed consistently using Terraform commands instead of manually making changes through a cloud console.

4. Standardize Configurations
Infrastructure can be described using reusable and version-controlled configuration files.

5. Collaborate
Terraform configurations can be stored in Git and shared among team members.

Developer
    │
    ▼
Terraform Code
    │
    ▼
Git Repository
    │
    ├── Developer A
    ├── Developer B
    └── Developer C

**Terraform Workflow**
The basic Terraform workflow is:

Write → Plan → Apply

A more complete workflow is:

Write
  ↓
Initialize
  ↓
Plan
  ↓
Review Changes
  ↓
Apply
  ↓
Infrastructure

Step 1: Write
Define the desired infrastructure in Terraform configuration files.

Terraform configuration files normally use the .tf extension.

Example
resource "aws_instance" "example" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}

Here, you describe what infrastructure you want instead of manually creating the infrastructure through a cloud console.

Step 2: Plan
Run:

terraform plan

Terraform compares the desired configuration with its state and information from the provider to determine what changes are required.

The plan can show actions such as:

+ create
~ update
- destroy

Symbols
Symbol	Meaning
+	Create
~	Update
-	Destroy

terraform plan is used to preview proposed changes. It does not normally make those infrastructure changes.

Step 3: Apply
Run:

terraform apply

Terraform executes the required changes to bring the infrastructure in line with the configuration.

The overall process is:

Terraform Configuration
          │
          ▼
   terraform plan
          │
          ▼
    Review Changes
          │
          ▼
   terraform apply
          │
          ▼
     Infrastructure
          │
          ▼
    State Is Updated

Terraform State
Terraform uses state to keep track of the resources it manages.

A typical local state file is:

terraform.tfstate

For example, if Terraform creates an AWS EC2 instance, the state contains information Terraform uses to associate the Terraform configuration with the real infrastructure.

Why Does Terraform State Matter?
Suppose your Terraform configuration contains:

instance_type = "t2.micro"

Terraform uses its state and information obtained from the provider to determine what currently exists and what changes may be required.

**Conceptually:**

Desired Configuration
         │
         ▼
 Terraform State
         │
         ▼
Actual Infrastructure

Terraform uses this information to determine differences between the desired configuration and the infrastructure that currently exists.

Remote State
In team environments, Terraform state is commonly stored in a remote backend instead of relying only on a local terraform.tfstate file.

Remote state can provide:

Centralized state storage

Team collaboration

State locking, when supported

Controlled access to state

Better management of shared infrastructure

Terraform state can contain sensitive information depending on the resources and configuration, so it should be protected appropriately.

Installing Terraform
Terraform can be installed using package managers or by downloading the appropriate binary for your operating system.

macOS
Using Homebrew:

brew tap hashicorp/tap

Install Terraform:

brew install hashicorp/tap/terraform

Upgrade Terraform:

brew upgrade hashicorp/tap/terraform

Linux
The installation process depends on the Linux distribution.

For Debian/Ubuntu-based systems, you may need packages such as:

sudo apt-get update
sudo apt-get install -y gnupg software-properties-common

The exact Terraform installation process may vary depending on the Linux distribution and Terraform version.

Getting Help
Terraform provides built-in command-line help.

Run:

terraform --help

This displays the available Terraform commands.

You can also get help for a specific command.

For example:

terraform plan -help

This is useful when you need to check command options or syntax.

Important Terraform Commands
terraform init
terraform init

Purpose
Initializes a Terraform working directory.

It performs tasks such as:

Initializing the Terraform working directory

Downloading required providers

Initializing the configured backend

Preparing the project for other Terraform commands

Remember
init = Initialize

terraform plan
terraform plan

Purpose
Previews the changes Terraform intends to make.

It helps you determine what Terraform will:

Create

Modify

Destroy

Remember
plan = Preview

terraform apply
terraform apply

Purpose
Applies the Terraform configuration and makes the required infrastructure changes.

Depending on the configuration, Terraform may:

Create resources

Update resources

Replace resources

Destroy resources

Remember
apply = Make the changes

terraform destroy
terraform destroy

Purpose
Destroys infrastructure managed by the Terraform configuration.

Remember
destroy = Remove managed infrastructure

⚠️ Warning: terraform destroy can delete real infrastructure resources. Use it carefully.

Complete Terraform Flow
Putting everything together:

                    Terraform Project
                           │
             ┌─────────────┴─────────────┐
             │                           │
   Terraform Configuration         Terraform State
          (.tf files)             (terraform.tfstate)
             │                           │
             └─────────────┬─────────────┘
                           │
                           ▼
                    terraform init
                           │
                           ▼
                    terraform plan
                           │
                           ▼
                     Review Changes
                           │
                           ▼
                    terraform apply
                           │
                           ▼
                       Terraform
                           │
                           ▼
                  Terraform Provider
                           │
                           ▼
                       Target API
                           │
                           ▼
                  Cloud / Service

When the infrastructure is no longer required:

terraform destroy

Easy Way to Remember Terraform Commands
Command	Meaning	Main Purpose
terraform init	Initialize	Prepare the Terraform project
terraform plan	Preview	See proposed changes
terraform apply	Execute	Create/update infrastructure
terraform destroy	Remove	Destroy managed infrastructure
terraform --help	Help	Show available commands

Simplest Terraform Lifecycle
The Terraform lifecycle can be remembered as:

Write → Initialize → Plan → Apply

Step-by-Step
Write .tf files
      │
      ▼
terraform init
      │
      ▼
terraform plan
      │
      ▼
Review Changes
      │
      ▼
terraform apply
      │
      ▼
Infrastructure Created/Updated

When the infrastructure is no longer required:

terraform destroy

Terraform Modules
Terraform supports modules, which allow infrastructure configurations to be organized and reused.

There are two common approaches:

Use Existing Modules
You can use modules created by other teams, organizations, or the Terraform community.

Write Your Own Modules
You can create custom modules to standardize and reuse infrastructure configurations within your organization.

Example:

Terraform Project
      │
      ├── Network Module
      │
      ├── Database Module
      │
      ├── Compute Module
      │
      └── Security Module

Modules can help:

Reduce code duplication

Improve reusability

Standardize infrastructure

Organize large Terraform projects

Simplify maintenance

Common Challenges and Limitations
Terraform is powerful, but there are several areas that require careful management.

1. State Management
Terraform relies heavily on state to understand the relationship between configuration and managed infrastructure.

State should therefore be handled carefully, especially in team environments.

Recommended practices
Use remote state for team environments

Protect access to state

Enable state locking when supported

Avoid manually modifying state files

Back up state where appropriate

2. Manual Changes Outside Terraform
Infrastructure can sometimes be changed directly through a cloud provider's console or API instead of Terraform.

This can result in configuration drift.

For example:

Terraform Configuration
        │
        ▼
instance_type = "t2.micro"


Cloud Infrastructure
        │
        ▼
instance_type = "t2.large"

During a subsequent Terraform operation, Terraform may detect differences between the desired configuration and the actual infrastructure.

The exact behavior depends on the resource and provider.

3. Complexity at Scale
Terraform configurations can become large and complex as infrastructure grows.

Without good organization, projects can become difficult to:

Understand

Maintain

Test

Review

Reuse

Using modules, naming conventions, version control, and clear project structures can help manage this complexity.

Terraform and GitOps
Terraform can be integrated into automated and Git-based infrastructure workflows.

However, Terraform and Kubernetes-focused GitOps tools such as Flux and Argo CD use different operational models.

A simplified Terraform workflow:

Git
 │
 ▼
Terraform
 │
 ▼
Cloud / Infrastructure

A typical Kubernetes GitOps workflow:

Git
 │
 ▼
GitOps Controller
 │
 ▼
Kubernetes Cluster

Terraform is commonly used for provisioning and managing infrastructure, while GitOps controllers such as Flux and Argo CD commonly focus on continuously reconciling Kubernetes resources with a desired state stored in Git.

Depending on the architecture, Terraform and GitOps tools can be used together rather than treated as direct replacements for each other.

Terraform vs Configuration Management
Terraform's primary purpose is infrastructure provisioning and management.

Configuration-management tools generally focus more on configuring operating systems and applications after infrastructure has been provisioned.

A simplified workflow can look like:

Terraform
    │
    ▼
Create Infrastructure
    │
    ▼
VM / Network / Database / Cloud Resources
    │
    ▼
Configuration Management
    │
    ▼
Configure OS / Applications

Terraform can perform some configuration-related tasks, but infrastructure provisioning and traditional configuration management are different areas.

Quick Revision
What is Terraform?
Terraform is an Infrastructure as Code tool used to define, provision, and manage infrastructure through configuration files.

What is a Provider?
A provider allows Terraform to communicate with an external platform or API.

Terraform → Provider → API → Infrastructure

What is Terraform State?
State contains information Terraform uses to track the infrastructure it manages.

Configuration + State + Provider Information
                    │
                    ▼
              Desired Changes

What does terraform init do?
Initializes the Terraform project and prepares dependencies such as providers and the backend.

What does terraform plan do?
Shows the proposed infrastructure changes.

What does terraform apply do?
Applies the required infrastructure changes.

What does terraform destroy do?
Destroys infrastructure managed by Terraform.

What is a Module?
A module is a reusable collection of Terraform configuration.

Terraform Cheat Sheet
                         Terraform
                             │
                             ▼
                         Write Code
                             │
                             ▼
                    Create .tf files
                             │
                             ▼
                     terraform init
                             │
                             ▼
                     terraform plan
                             │
                             ▼
                     Review Changes
                             │
                             ▼
                     terraform apply
                             │
                             ▼
                  Infrastructure Created
                             │
                             ▼
                    Provider → API
                             │
                             ▼
                    Cloud / Services

When infrastructure is no longer required:

terraform destroy

One-Line Memory Trick
INIT → PLAN → APPLY → DESTROY
 ↓       ↓       ↓        ↓
Prepare  Preview Execute  Remove

Summary
Terraform allows you to manage infrastructure as code instead of relying entirely on manual changes.

**The core concepts to remember are:**

Terraform
   │
   ├── Configuration (.tf)
   │
   ├── Provider
   │
   ├── State
   │
   ├── Modules
   │
   └── Workflow
         │
         ├── terraform init
         ├── terraform plan
         ├── terraform apply
         └── terraform destroy

The Terraform Workflow
WRITE
  ↓
INIT
  ↓
PLAN
  ↓
REVIEW
  ↓
APPLY
  ↓
MANAGE INFRASTRUCTURE

Useful Terraform Commands
# Initialize Terraform
terraform init

# Format Terraform files
terraform fmt

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# List resources in state
terraform state list

# Destroy managed infrastructure
terraform destroy

# Show Terraform help
terraform --help
