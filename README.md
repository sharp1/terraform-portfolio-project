# terraform-portfolio-project
This project deploys a static Next.js portfolio site to AWS using Terraform:
- **Next.js** generates a static export (`npm run build` → `out/` folder).
- **S3 (private bucket)** stores the built site assets. The bucket has:
  - S3 Block Public Access enabled
  - A bucket policy that only allows reads from a CloudFront Origin Access Identity (OAI)
- **CloudFront** serves the site globally:
  - Uses the S3 bucket as an origin via OAI
  - Enforces HTTPS and caches static content at edge locations

Terraform is used to provision:

- The S3 website bucket
- S3 ownership controls and public access block
- The CloudFront Origin Access Identity (OAI)
- The CloudFront distribution

Terraform state is stored remotely in an S3 backend with a DynamoDB table for state locking, enabling safe collaboration and repeatable deployments
