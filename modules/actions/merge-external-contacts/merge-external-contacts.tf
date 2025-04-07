resource "genesyscloud_integration_action" "merge_external_contacts" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type"     = "object",
    "required" = ["sourceContactId", "targetContactId"],
    "properties" = {
      "sourceContactId" = {
        "description" = "The ID of the source contact for the merge operation. Must be either an \"ephemeral\" or \"identified\" contact (not \"curated\").",
        "type"        = "string"
      },
      "targetContactId" : {
        "description" : "The ID of the target contact for the merge operation. Only contacts of type \"curated\" may be the target of a merge (not ephemeral or identified).",
        "type" = "string"
      }
    },
    "additionalProperties" : true
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "id" = {
        "type" = "string"
      }
    },
    "additionalProperties" = true
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/externalcontacts/merge/contacts"
    request_type         = "POST"
    headers              = {}
    request_template     = "$${input.rawRequest}"
  }
  config_response {
    translation_map          = {}
    translation_map_defaults = {}
    success_template         = "$${rawResult}"
  }
}
