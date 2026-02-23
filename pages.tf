resource "cloudflare_pages_project" "demo_pages" {
  account_id        = var.cloudflare_account_id
  name              = var.pages_project_name
  production_branch = "master"

  source {
    type = "github"
    config {
      owner                         = var.github_repo_owner
      repo_name                     = var.github_repo_name
      production_branch             = "master"
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
