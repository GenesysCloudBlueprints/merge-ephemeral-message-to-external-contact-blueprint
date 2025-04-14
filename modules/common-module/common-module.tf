resource "genesyscloud_flow" "common_module" {
  filepath          = "${path.module}/ResolveContact.yaml"
  file_content_hash = filesha256("${path.module}/ResolveContact.yaml")
  substitutions = {
    module_name                                                  = var.module_name
    division                                                     = var.division
    data_action_category                                         = var.data_action_category
    fetch_external_contact_by_identifier_data_action             = var.fetch_external_contact_by_identifier_data_action
    get_external_contact_id_for_customer_participant_data_action = var.get_external_contact_id_for_customer_participant_data_action
    merge_external_contacts_data_action                          = var.merge_external_contacts_data_action
  }
}
