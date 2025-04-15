# 🚀 Terraform AWS Infrastructure

This project sets up a **production-ready AWS infrastructure** using Terraform, including **VPC, EFS, OpenSearch, RDS (Aurora)**, and **Secrets Manager**, leveraging reusable modules for each component.

---

## 📁 Project Structure

```
project-root/
├── main.tf
└── modules/
    ├── vpc/
    ├── efs/
    ├── opensearch/
    ├── rds/
    └── secrets/
```

---

## 📦 Resources Created

### 🔹 VPC
- **CIDR:** `10.0.0.0/16`
- **Availability Zones:** `us-west-2a`, `us-west-2b`
- **Public Subnets:** `10.0.1.0/24`, `10.0.2.0/24`
- **Private Subnets:** `10.0.3.0/24`, `10.0.4.0/24`
- **Outputs:** `private_subnet_ids`, `security_group_id`

### 🔹 EFS
- Created in **private subnets**
- Uses the **security group** from the VPC module

### 🔹 OpenSearch
- Configuration is **hardcoded** within the module
- No variables are passed from `main.tf`

### 🔹 RDS (Aurora)
- **Cluster ID:** `dev-aurora-cluster`
- **Username:** `admin`
- **Password:** `password`
- **Subnet Group:** `dev-db-subnet-group`
- Deployed in **private subnets**

### 🔹 Secrets Manager
- Stores **database credentials**:
  - Username: `admin`
  - Password: `password`

---

## ⚙️ How to Use

### Initialize Terraform
```bash
terraform init
```

### Validate Configuration
```bash
terraform validate
```

### Plan the Deployment
```bash
terraform plan
```

### Apply the Configuration
```bash
terraform apply
```

---

## 🔐 Security Notes

- **Do NOT hardcode sensitive credentials in production.**
  - Use **AWS Secrets Manager** or environment variables for secrets.
- Ensure **IAM roles** and **security groups** follow the **principle of least privilege**.

---

## 🧰 Requirements

- Terraform `>= 1.0`
- AWS CLI configured with appropriate access
- AWS account with sufficient permissions

---

## 📦 Modules

This project assumes reusable modules exist in:

```
../../modules/<module-name>
```

You can modify or extend them as per your needs.

---

## 👤 Author

**Muhammad Abdullah**

