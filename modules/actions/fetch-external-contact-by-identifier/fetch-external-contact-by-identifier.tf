resource "genesyscloud_integration_action" "fetch_external_contact_by_identifier" {
  name           = var.action_name
  category       = var.action_category
  integration_id = var.integration_id
  contract_input = jsonencode({
    "type"     = "object",
    "required" = ["type", "value"],
    "properties" = {
      "type" = {
        "description" = "The type of this identifier",
        "type"        = "string",
        "enum" = [
          "Phone",
          "Email",
          "Cookie",
          "SocialWhatsapp",
          "SocialTwitter",
          "SocialFacebook",
          "SocialLine"
        ]
      },
      "value" = {
        "description" = " The string value of the identifier. Will vary in syntax by type.",
        "type"        = "string"
      }
    },
    "additionalProperties" = true
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "id" = {
        "type" = "string"
      },
      "firstName" = {
        "type" = "string"
      },
      "lastName" = {
        "type" = "string"
      }
    },
    "additionalProperties" = true
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/externalcontacts/identifierlookup"
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
