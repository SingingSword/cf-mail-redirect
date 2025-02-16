# Cloudflare Domain Redirect Configuration with Terraform

This project provides a Terraform configuration for setting up domain redirects using Cloudflare.
It allows you to easily manage and deploy redirects for a specific domain through Infrastructure as Code (IaC).

The configuration utilizes Cloudflare's services to handle domain redirects, providing a scalable and efficient solution for managing web traffic.
By leveraging Terraform, this project enables version-controlled, reproducible infrastructure deployments, making it easier to maintain and update your domain redirect settings.

## Repository Structure

The repository is organized as follows:

```
.
└── tf/
    ├── provider.tf
    ├── redirect.tf
    ├── terraform.tfvars.json
    └── variables.tf
```

- `tf/`: Directory containing all Terraform configuration files
  - `provider.tf`: Defines the Terraform providers used in the project
  - `redirect.tf`: Contains the main configuration for setting up the domain redirect
  - `terraform.tfvars.json`: Stores the variable values used in the Terraform configuration
  - `variables.tf`: Declares the variables used across the Terraform files

## Usage Instructions

### Prerequisites

- Terraform v1.0.0 or later
- A Cloudflare account with the necessary permissions
- The domain you want to configure must be managed by Cloudflare

### Installation

1. Clone this repository to your local machine:

```bash
git clone <repository-url>
cd <repository-name>
```

2. Navigate to the `tf` directory:

```bash
cd tf
```

3. Initialize the Terraform working directory:

```bash
terraform init
```

### Configuration

1. Open the `terraform.tfvars.json` file and update the values according to your Cloudflare setup:

```json
{
    "cloudflare_zone_id": "your_zone_id",
    "cloudflare_account_id": "your_account_id",
    "domain": "your_domain.com"
}
```

Replace `your_zone_id`, `your_account_id`, and `your_domain.com` with your actual Cloudflare zone ID, account ID, and domain name respectively.

2. If you need to modify any other variables, you can do so in the `variables.tf` file.

### Deployment

1. Review the planned changes:

```bash
terraform plan
```

2. If the plan looks correct, apply the changes:

```bash
terraform apply
```

3. Confirm the apply operation by typing `yes` when prompted.

### Verification

After applying the Terraform configuration:

1. Log in to your Cloudflare dashboard
2. Navigate to the DNS settings for your domain
3. Verify that the redirect rules have been created as expected

### Troubleshooting

If you encounter any issues:

1. Ensure your Cloudflare API credentials are correct and have the necessary permissions
2. Check the Cloudflare API documentation to verify the correct format for zone and account IDs
3. If you receive a "resource already exists" error, you may need to import existing resources into your Terraform state

For more detailed error messages, you can run Terraform with debug logging:

```bash
TF_LOG=DEBUG terraform apply
```

This will provide more context about any errors encountered during the apply process.

## Data Flow

The data flow for this Cloudflare domain redirect configuration is as follows:

1. Terraform reads the configuration from the `.tf` files in the `tf/` directory
2. Variables are populated from `terraform.tfvars.json`
3. Terraform communicates with the Cloudflare API using the provided credentials
4. Redirect rules are created or updated in Cloudflare based on the configuration
5. DNS changes propagate across Cloudflare's network

```
[Terraform Config] -> [Cloudflare API] -> [Cloudflare DNS] -> [End Users]
```

Note: DNS propagation may take some time to complete globally.

## Infrastructure

The infrastructure for this project is defined using Terraform.
Key resources include:

- Cloudflare Zone: Identified by `cloudflare_zone_id` in `terraform.tfvars.json`
- Cloudflare Account: Identified by `cloudflare_account_id` in `terraform.tfvars.json`
- Domain: Specified by `domain` in `terraform.tfvars.json`

These resources are used to configure the domain redirect rules within Cloudflare's infrastructure.