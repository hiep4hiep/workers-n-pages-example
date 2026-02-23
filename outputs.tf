output "kv_namespace_id" {
  description = "ID of the KV namespace"
  value       = cloudflare_workers_kv_namespace.demo_kv.id
}

output "worker_name" {
  description = "Name of the deployed Worker"
  value       = cloudflare_workers_script.demo_worker.name
}

output "worker_url" {
  description = "URL of the Worker (workers.dev subdomain)"
  value       = "https://${var.worker_name}.${var.cloudflare_account_id}.workers.dev"
}

#output "pages_project_name" {
#  description = "Name of the Pages project"
#  value       = cloudflare_pages_project.demo_pages.name
#}

#output "pages_url" {
#  description = "URL of the Pages deployment"
#  value       = "https://${cloudflare_pages_project.demo_pages.subdomain}"
#}

#output "pages_subdomain" {
#  description = "Pages subdomain"
#  value       = cloudflare_pages_project.demo_pages.subdomain
#}
