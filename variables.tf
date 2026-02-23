variable "cloudflare_api_token" {
  description = "Cloudflare API token with Workers, KV, and Pages permissions"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "worker_name" {
  description = "Name of the Cloudflare Worker"
  type        = string
  default     = "demo-worker"
}

variable "kv_namespace_name" {
  description = "Name of the KV namespace"
  type        = string
  default     = "demo-kv-namespace"
}

variable "pages_project_name" {
  description = "Name of the Cloudflare Pages project"
  type        = string
  default     = "demo-pages"
}

variable "github_repo_owner" {
  description = "GitHub repository owner (username or organization)"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name for Pages deployment"
  type        = string
}

variable "production_branch" {
  description = "Production branch for Pages deployment"
  type        = string
  default     = "main"
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for hiepprolab.info"
  type        = string
}

variable "custom_domain_1" {
  description = "Custom domain for Pages project"
  type        = string
}
