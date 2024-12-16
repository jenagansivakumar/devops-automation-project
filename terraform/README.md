# Terraform AWS Project

## Overview
This project uses Terraform to provision and manage AWS infrastructure. The repository provides all the necessary Terraform configurations and modules to set up the required AWS resources.

## Features
- Automates the provisioning of resources such as:
  - Virtual Private Cloud (VPC)
  - Subnets (public and private)
  - Internet Gateway
  - Security groups
  - Target groups
  - Route Table
  - EC2 instances
  - S3 buckets
  - Load balancers
  - EC2 instances 

## Prerequisites

Ensure you have the following installed before getting started:

- [Terraform](https://www.terraform.io/downloads.html) (>= 1.0)
- AWS CLI configured with appropriate credentials.
- An AWS account with IAM permissions to create resources.

## Setup Instructions

1. **Clone the Repository:**
   ```
   git clone <repository-url>
   cd terraform
   ```

2. **Configure Backend (Optional):**
   Modify `backend.tf` to configure remote state storage:
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "<your-s3-bucket-name>"
       key            = "terraform/state/<your-project>.tfstate"
       region         = "<your-region>"
       dynamodb_table = "<your-dynamodb-table-name>"
     }
   }
   ```

3. **Initialize Terraform:**
   Run the following command to initialize the project:
   ```
   terraform init
   ```
4. **Validation Terraform:**
Run the following command to validate the project:
   ```
   terraform validate
   ```

5. **Review and Apply Changes:**
   - Plan the changes:
     ```
     terraform plan
     ```
   - Apply the changes:
     ```
     terraform apply 
     ```

6. **Verify Resources:**
   Confirm that the resources are created successfully in your AWS account.


## References
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/index.html)
- [AWS Services](https://aws.amazon.com/products/)

