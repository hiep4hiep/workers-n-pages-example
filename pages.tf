resource "cloudflare_pages_project" "demo_pages" {
  account_id        = var.cloudflare_account_id
  name              = var.pages_project_name
  production_branch = var.production_branch

  source {
    type = "github"
    config {
      owner                         = var.github_repo_owner
      repo_name                     = var.github_repo_name
      production_branch             = var.production_branch
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "custom"
      preview_branch_includes       = ["dev", "preview/*"]
    }
  }
   build_config {
     build_command   = ""
     destination_dir = "public"
   }

   deployment_configs {
     preview {
       environment_variables = {
         ENVIRONMENT = "preview"
       }
     }
     production {
       environment_variables = {
         ENVIRONMENT = "production"
       }
     }
   }
}

# Custom domain for Pages project
resource "cloudflare_pages_domain" "custom_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.demo_pages.name
  domain       = var.custom_domain_1
}

# DNS CNAME record pointing to Pages project
resource "cloudflare_record" "pages_cname" {
  zone_id = var.cloudflare_zone_id
  name    = split(".", var.custom_domain_1)[0]
  content = cloudflare_pages_project.demo_pages.subdomain
  type    = "CNAME"
  proxied = true
}
