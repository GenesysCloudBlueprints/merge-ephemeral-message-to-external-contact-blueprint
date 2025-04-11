# Create a Data Action integration
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Merge Ephemeral Message to External Contact"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

# Create a Fetch External Contact By Identifier Data Action
module "fetch_external_contact_by_identifier_data_action" {
  source          = "./modules/actions/fetch-external-contact-by-identifier"
  action_name     = "Fetch External Contact By Identifier"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}

# Create a Get External Contact Id For Customer Participant Data Action
module "get_external_contact_id_for_customer_participant_data_action" {
  source          = "./modules/actions/get-external-contact-id-for-customer-participant"
  action_name     = "Get External Contact Id For Customer Participant"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}

# Create a Merge External Contacts Data Action
module "merge_external_contacts_data_action" {
  source          = "./modules/actions/merge-external-contacts"
  action_name     = "Merge External Contacts"
  action_category = module.data_action.integration_name
  integration_id  = module.data_action.integration_id
}

# Looks up the id of the user so we can associate it with the queue
data "genesyscloud_user" "user" {
  email = var.email
}
# Create Queue
module "queue" {
  source     = "./modules/queue"
  queue_name = var.queue_name
  user_id    = data.genesyscloud_user.user.id
}

# Create Bot Flow
module "bot_flow" {
  source   = "./modules/bot-flow"
  bot_name = var.bot_flow_name
  division = var.division
}

# Create Common Module
module "common_module" {
  source                                                       = "./modules/common-module"
  module_name                                                  = var.common_module_name
  data_action_category                                         = module.data_action.integration_name
  division                                                     = var.division
  fetch_external_contact_by_identifier_data_action             = module.fetch_external_contact_by_identifier_data_action.action_name
  get_external_contact_id_for_customer_participant_data_action = module.get_external_contact_id_for_customer_participant_data_action.action_name
  merge_external_contacts_data_action                          = module.merge_external_contacts_data_action.action_name
  depends_on                                                   = [module.data_action, module.fetch_external_contact_by_identifier_data_action, module.get_external_contact_id_for_customer_participant_data_action, module.merge_external_contacts_data_action]
}

# Create Inbound Message Flow
module "inbound_message_flow" {
  source             = "./modules/inbound-message-flow"
  flow_name          = "Merge Ephemeral Message To External Contact Flow"
  division           = var.division
  common_module_name = var.common_module_name
  bot_flow_name      = var.bot_flow_name
  queue_name         = module.queue.queue_name
  depends_on         = [module.common_module, module.queue, module.bot_flow]
}

# Create Messenger Configuration
module "web_config" {
  source                            = "./modules/webdeployment-configuration"
  web_deployment_configuration_name = var.web_deployment_configuration_name
}

# Create Messenger Deployment
module "web_deploy" {
  source              = "./modules/webdeployment-deployment"
  web_deployment_name = var.web_deployment_name
  flow_id             = module.inbound_message_flow.flow_id
  config_id           = module.web_config.config_id
  config_ver          = module.web_config.config_ver
  depends_on          = [module.inbound_message_flow]
}
