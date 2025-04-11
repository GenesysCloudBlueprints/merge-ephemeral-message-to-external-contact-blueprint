resource "genesyscloud_flow" "bot_flow" {
  filepath          = "${path.module}/MergeExternalContactBot.yaml"
  file_content_hash = filesha256("${path.module}/MergeExternalContactBot.yaml")
  substitutions = {
    bot_name         = var.bot_name
    division         = var.division
    default_language = "en-us"
  }
}
