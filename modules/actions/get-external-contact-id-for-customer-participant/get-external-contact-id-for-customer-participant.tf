resource "genesyscloud_integration_action" "get_external_contact_id_for_customer_participant" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "conversationId" = {
        "type" = "string"
      }
    },
    "additionalProperties" = true
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "externalContactId_external" = {
        "type" = "string"
      },
      "externalContactId_customer" = {
        "type" = "string"
      }
    },
    "additionalProperties" = true
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/conversations/$${input.conversationId}"
    request_type         = "GET"
    headers              = {}
    request_template     = "$${input.rawRequest}"
  }
  config_response {
    translation_map = {
      customerIdArray = "$.participants[?(@.purpose ==\"customer\")].externalContactId"
      externalIdArray = "$.participants[?(@.purpose ==\"external\")].externalContactId"
    }
    translation_map_defaults = {
      customerIdArray = "[\"\"]"
      externalIdArray = "[\"\"]"
    }
    success_template = "{\"externalContactId_external\": $${successTemplateUtils.firstFromArray(\"$${customerIdArray}\", \"$esc.quote$esc.quote\")}, \"externalContactId_customer\": $${successTemplateUtils.firstFromArray(\"$${externalIdArray}\", \"$esc.quote$esc.quote\")}}"
  }
}
