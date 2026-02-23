# Cloudflare Worker with KV binding
resource "cloudflare_workers_script" "demo_worker" {
  account_id = var.cloudflare_account_id
  name       = var.worker_name
  content    = file("${path.module}/../worker/index.js")
  module     = true

  kv_namespace_binding {
    name         = "DEMO_KV"
    namespace_id = cloudflare_workers_kv_namespace.demo_kv.id
  }
}
