resource "genesyscloud_flow" "inbound_message_flow" {
  filepath          = "${path.module}/MergeExternalContactMessageFlow.yaml"
  file_content_hash = filesha256("${path.module}/MergeExternalContactMessageFlow.yaml")
  substitutions = {
    flow_name          = var.flow_name
    division           = var.division
    default_language   = "en-us"
    queue_name         = var.queue_name
    common_module_name = var.common_module_name
    bot_flow_name      = var.bot_flow_name
  }
}
