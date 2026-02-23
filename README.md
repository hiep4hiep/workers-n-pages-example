# Cloudflare Terraform Deployment

Deploy Cloudflare Worker, Workers KV, and Pages using Terraform provider v4.

## Resources Created

| Resource | Type | Description |
|----------|------|-------------|
| `cloudflare_workers_kv_namespace` | KV Namespace | Key-value storage for Worker |
| `cloudflare_workers_kv` | KV Entry | Initial test data |
| `cloudflare_workers_script` | Worker | ES modules Worker with KV binding |
| `cloudflare_pages_project` | Pages | Static site with GitHub integration |
| `cloudflare_pages_domain` | Pages Domain | Custom domain for Pages |
| `cloudflare_record` | DNS CNAME | Points custom domain to Pages |

## Prerequisites

- **Terraform** >= 1.0
- **Terraform Cloudflare Provider** >= 4.0
- **Cloudflare Account** with a domain (zone) configured
- **GitHub Account** with a repository for Pages content

---

## Step 1: Connect Cloudflare to GitHub

Before Terraform can create a Pages project with GitHub integration, you must authorize Cloudflare to access your GitHub account.

---

## Step 2: Create Cloudflare API Token

Create an API token with the required permissions:

1. Go to [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens)
2. Click **Create Token**
3. Select **Create Custom Token**
4. Configure permissions:

| Permission Type | Permission | Access |
|-----------------|------------|--------|
| **Account** | Workers Scripts | Edit |
| **Account** | Workers KV Storage | Edit |
| **Account** | Cloudflare Pages | Edit |
| **Account** | Account Settings | Read |
| **Zone** | DNS | Edit |

5. Set **Account Resources** → Include → Your account
6. Set **Zone Resources** → Include → Specific zone → Your domain
7. Click **Continue to summary** → **Create Token**
8. Copy the token (you won't see it again)

---

## Step 3: Configure Variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
cloudflare_api_token  = "your-api-token"
cloudflare_account_id = "your-account-id"
cloudflare_zone_id    = "your-zone-id"

worker_name       = "demo-worker"
kv_namespace_name = "demo-kv-namespace"

pages_project_name = "demo-pages"
github_repo_owner  = "your-github-username"
github_repo_name   = "your-repo-name"
production_branch  = "master"

custom_domain_1 = "testpage.yourdomain.com"
```

---

## Step 4: Prepare GitHub Repository

Your GitHub repository should contain static content in a `public/` directory:

```
your-repo/
└── public/
    ├── index.html
    └── styles.css
```

Push your content:

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/<owner>/<repo>.git
git push -u origin master
```

---

## Step 6: Deploy with Terraform

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply changes
terraform apply
```

---

## Step 7: Verify Deployment

After `terraform apply` completes:

1. **Worker**: Access at `https://<worker-name>.<account-subdomain>.workers.dev`
2. **Pages**: Access at `https://<project-name>.pages.dev` or your custom domain
3. **KV**: Test via Worker endpoints (`/kv/get?key=test_key`)

---

## Automatic Deployments

With GitHub integration enabled, Cloudflare automatically deploys when you push:

| Branch | Deployment Type |
|--------|-----------------|
| `master` (or configured production branch) | Production |
| `dev`, `preview/*` | Preview |

```bash
# Trigger a new deployment
git add .
git commit -m "Update content"
git push origin master
```

---

## Cleanup

To destroy all resources:

```bash
terraform destroy
```
---

## File Structure

```
terraform/
├── versions.tf          # Provider configuration (v4.x)
├── variables.tf         # Input variables
├── kv.tf                # KV namespace and entries
├── worker.tf            # Worker script with KV binding
├── pages.tf             # Pages project, domain, and DNS
├── outputs.tf           # Output values
├── terraform.tfvars     # Your configuration (git-ignored)
└── terraform.tfvars.example
```
