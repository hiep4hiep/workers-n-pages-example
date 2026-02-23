# KV Namespace for the Worker
resource "cloudflare_workers_kv_namespace" "demo_kv" {
  account_id = var.cloudflare_account_id
  title      = var.kv_namespace_name
}

# Optional: Add initial KV entries for demo purposes
resource "cloudflare_workers_kv" "demo_entry" {
  account_id   = var.cloudflare_account_id
  namespace_id = cloudflare_workers_kv_namespace.demo_kv.id
  key          = "test_key"
  value        = "test_value"
}
