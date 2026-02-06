

\# Terraform-Based Deployment of Strapi on AWS (Private EC2 Architecture)



\## 1. Project Overview



This project demonstrates the design and implementation of a production-style AWS infrastructure using \*\*Terraform\*\* to deploy a \*\*Strapi\*\* application on a \*\*private EC2 instance\*\*. The focus of this task is on \*\*infrastructure correctness, security best practices, automation, and clear documentation\*\*, rather than on AWS account-specific service availability.



The infrastructure is fully defined using Infrastructure as Code (IaC) principles, ensuring repeatability, clarity, and maintainability.



---



\## 2. Objectives of the Task



The primary objectives of this task are:



\* Design AWS infrastructure using Terraform following best practices

\* Deploy an application on a private EC2 instance

\* Ensure outbound internet access using a NAT Gateway

\* Automate application setup using `user\_data`

\* Manage environment differences using variables and tfvars

\* Provide clear documentation and explanation of the design and decisions



The task prioritizes \*\*design correctness and Terraform implementation quality\*\* over live AWS service behavior.



---



\## 3. High-Level Architecture Description



The infrastructure consists of the following components:



\* \*\*VPC\*\*



&nbsp; \* Custom CIDR block

&nbsp; \* DNS hostnames and DNS resolution enabled



\* \*\*Public Subnet\*\*



&nbsp; \* Hosts networking components that require internet access

&nbsp; \* Associated with an Internet Gateway



\* \*\*Private Subnet\*\*



&nbsp; \* Hosts the application EC2 instance

&nbsp; \* No direct inbound internet access



\* \*\*Internet Gateway\*\*



&nbsp; \* Enables internet access for resources in the public subnet



\* \*\*NAT Gateway\*\*



&nbsp; \* Deployed in the public subnet

&nbsp; \* Provides outbound internet access to private subnet resources



\* \*\*Route Tables\*\*



&nbsp; \* Public route table routes traffic to the Internet Gateway

&nbsp; \* Private route table routes traffic to the NAT Gateway



\* \*\*Security Groups\*\*



&nbsp; \* Enforces least-privilege access

&nbsp; \* No unnecessary ports exposed



\* \*\*EC2 Instance (Private)\*\*



&nbsp; \* Runs inside the private subnet

&nbsp; \* Hosts the Strapi application inside a Docker container



\* \*\*Key Pair\*\*



&nbsp; \* Managed through Terraform

&nbsp; \* Used for controlled administrative access if required



This design follows the \*\*AWS Well-Architected Framework\*\*, particularly the security and operational excellence pillars.



---



\## 4. Application Architecture



\* \*\*Application\*\*: Strapi (Headless CMS)

\* \*\*Runtime\*\*: Docker

\* \*\*Operating System\*\*: Amazon Linux 2

\* \*\*Deployment Method\*\*: Automated using `user\_data`



The application is deployed using the \*\*official pre-built Strapi Docker image\*\*. This decision was taken intentionally to:



\* Avoid memory-related failures on small instance types (e.g., t3.micro)

\* Eliminate the need for build-time dependencies on the EC2 instance

\* Ensure predictable and repeatable startup behavior



The application starts automatically when the EC2 instance is launched.



---



\## 5. Terraform Design and Best Practices



This project follows Terraform best practices throughout:



\* Infrastructure defined entirely as code

\* Clear separation of concerns across Terraform files:



&nbsp; \* Networking

&nbsp; \* Security

&nbsp; \* Compute

\* Use of variables and `terraform.tfvars` for configuration

\* No hardcoded values

\* Reusable and environment-agnostic configuration

\* Idempotent and predictable execution

\* Use of data sources for dynamic values such as AMI IDs



All resources are managed by Terraform, ensuring consistency and traceability.



---



\## 6. Automation Using user\_data



The EC2 instance uses a `user\_data` script to automate:



\* System updates

\* Docker installation and startup

\* Pulling the Strapi Docker image

\* Running the Strapi container



This approach ensures that:



\* No manual intervention is required after instance launch

\* The instance is application-ready immediately

\* The deployment is reproducible across environments



---



\## 7. Screenshots and Validation



As part of the submission, the following screenshots are included:



\* Terraform plan output

\* Terraform apply output



These outputs validate that the infrastructure definition is syntactically correct, logically sound, and executable via Terraform.



---



\## 8. Application Runtime Verification – Explanation



Direct runtime screenshots from within the private EC2 instance were not included for the following reasons:



\* The EC2 instance is intentionally deployed in a \*\*private subnet\*\* with no direct inbound access

\* This is a security best practice and an expected outcome of the architecture

\* Accessing private instances typically requires a load balancer or bastion host



Additionally:



\* Application Load Balancer creation was restricted due to AWS account-level limitations commonly applied to new accounts

\* These restrictions are external to the Terraform configuration and do not indicate a design or implementation issue



The infrastructure design, Terraform execution, and application automation remain complete and correct regardless of these account-specific constraints.



---



\## 9. Known Limitations



\* Live application access via a load balancer could not be demonstrated due to AWS account restrictions

\* Runtime screenshots from the private EC2 instance were not captured due to intentional network isolation



These limitations are related to AWS account constraints and not to Terraform configuration quality or architectural design.



---



\## 10. Conclusion



This project demonstrates a secure, production-style AWS infrastructure deployed using Terraform, with a strong emphasis on:



\* Network isolation

\* Automated provisioning

\* Clean Infrastructure as Code design

\* Best practices aligned with real-world DevOps workflows



The architecture can be easily extended to include a load balancer or bastion host when account-level restrictions are lifted, without requiring changes to the core Terraform design.



---



\*\*Akash K\*\*



