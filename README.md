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

# 
Architecture & Component Functions

This project deploys a static Next.js portfolio site on AWS using S3, CloudFront, and Terraform with a remote S3/DynamoDB backend for state.

1. Static Next.js portfolio site
Next.js is used in static site generation (SSG) mode. At build time it pre-renders the app into plain HTML, CSS, and JavaScript (via npm run build), which are then uploaded as static assets to S3.

2. S3 – Static site storage
Amazon S3 provides durable object storage for the built site files (HTML, JS, CSS, images). The bucket is configured as a private origin for CloudFront, not as a public website endpoint.

3. CloudFront – Global content delivery
Amazon CloudFront is configured with the S3 bucket as its origin. It serves the site globally over HTTPS, caches static content at edge locations, and handles the public URL (CloudFront domain or custom domain).

4. OAI – Secure access from CloudFront to S3
A CloudFront Origin Access Identity (OAI) is used so that only CloudFront can read objects from the S3 bucket. The S3 bucket policy explicitly grants s3:GetObject permissions to the OAI’s principal, while keeping the bucket itself non-public.

5. S3 + DynamoDB – Terraform remote state backend
A separate S3 bucket and DynamoDB table are used as the Terraform backend:
	•	S3 stores the Terraform state file.
	•	DynamoDB provides state locking so two terraform apply operations cannot run against the same state at the same time. This backend is only for Terraform and is not part of the user request path.

6. Terraform – Infrastructure as Code
Terraform defines and manages all of the infrastructure (S3 bucket, OAI, CloudFront distribution, and remote state backend). It provides version control for the infrastructure, drift detection (plan/apply), and reproducible deployments from code instead of manual console changes.

If you want, next we can do a similar pass on your actual main.tf/variables.tf comments so the code and README “speak the same language.”
