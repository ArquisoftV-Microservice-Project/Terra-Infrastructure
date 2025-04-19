# Terraform GKE Deployment with AWS S3 Backend

This project provisions a complete infrastructure on Google Cloud Platform (GCP), including a Google Kubernetes Engine (GKE) cluster, multiple namespaces, custom node pools, networking, Ingress, and an Artifact Registry. Everything is modularized using **Terraform Modules** and uses a **remote AWS S3 backend** for Terraform state management.

---

## 📁 Project Structure

```

.
├── LICENSE
├── main.tf
├── modules
│ ├── artifact_registry/
│ ├── cluster/
│ ├── ingress/
│ ├── namespaces/
│ ├── network/
│ └── node_pools/
├── outputs.tf
├── providers.tf
├── variables.tf
├── versions.tf
├── terraform.tfvars
├── apply_terraform.sh
├── destroy_terraform.sh
├── terraform-key.json
└── README.md

```

---

## 🚀 What Does It Deploy?

- Private network in GCP
- GKE Cluster
- Custom node pools
- Namespaces within the cluster
- Ingress
- Container Artifact Registry

---

## 🔒 Authentication Requirements

To run this project correctly, you must meet the following authentication conditions:

### 1. 📁 `terraform-key.json` File (GCP)

You must have a `terraform-key.json` file in the **root directory**. This is a **Service Account key** with the necessary permissions to deploy infrastructure on GCP.

You can create the service account and key with the following commands:

```bash
# Crear una cuenta de servicio para Terraform
gcloud iam service-accounts create terraform-acc \
  --display-name="Terraform Deployer"

# Asignar roles específicos para GKE y recursos relacionados
PROJECT_ID="arquisoftv-microservice"

# Roles para administrar recursos de GKE
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/container.admin"

# Roles para redes
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/compute.networkAdmin"

# Roles para Artifact Registry
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.admin"

# Roles para Service Account User (necesario para crear recursos que usan cuentas de servicio)
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"

# Roles para administración de recursos generales en GCP
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/resourcemanager.projectIamAdmin"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountAdmin"

gcloud projects add-iam-policy-binding $PROJECT_ID  \
  --member="serviceAccount:terraform-acc@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.admin"

# Crear y descargar la clave de la cuenta de servicio
gcloud iam service-accounts keys create terraform-key.json \
  --iam-account=terraform-acc@$PROJECT_ID.iam.gserviceaccount.com
```

> 🔑 **Important**: This file **must not be shared** and should be kept private and secure.

### 2. ☁️ Environment Variables for AWS Backend

The Terraform remote state is stored in an S3 bucket on AWS. You need to export the following environment variables with an IAM user that has **read/write access** to that bucket:

```bash
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_REGION="us-west-2"
```

---

## 🧪 Prerequisites

- Terraform ≥ 1.0
- Google Cloud CLI
- kubectl
- A GCP account with billing enabled
- AWS CLI (optional, for checking the backend state)

---

## 🛠️ Tool Installation

### GCP CLI

```bash
# Install GCP CLI
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli

# Initialize configuration
gcloud init
```

### kubectl

Follow the steps on the [kubectl installation guide](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) for Linux.

---

## 🔐 Activate Authentication

```bash
# Authenticate using the service account
gcloud auth activate-service-account --key-file=terraform-key.json
```

---

## ☸️ Connect to the GKE Cluster

Once the cluster is deployed (check Terraform output), connect to it using:

```bash
gcloud container clusters get-credentials arquisoftv-microservice-gke \
  --region us-east4 \
  --project arquisoftv-microservice
```

> Make sure the correct account is active:

```bash
gcloud auth list
```

---

## 📦 Artifact Registry

To authenticate with the Artifact Registry and push/pull images:

```bash
gcloud auth configure-docker us-east4-docker.pkg.dev
```

---

## 📌 Required Terraform Variables

```hcl
project_id       = "arquisoftv-microservice"
region           = "us-east4"
node_locations   = ["us-east4-c"]
repo_name        = "microservice-registry"
repo_description = "Microservice registry"
```

---

## 🚀 Deploy Infrastructure

```bash
# Apply infrastructure
./apply_terraform.sh
```

---

## 🧹 Clean Up Infrastructure

```bash
# Destroy resources in the proper order
./destroy_terraform.sh
```

---

## Infracost integration

To use infracost integration we must create a infracost account, then register all the repositories that we want to evaluate, in this case, we added Terra-Infrastructure and Terra-Backend.


## 📄 License

This project is licensed under the terms of the [LICENSE](./LICENSE) file.

---
