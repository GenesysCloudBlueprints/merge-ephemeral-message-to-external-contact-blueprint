# Provide the values for the variables used in the Terraform configuration.
# This file is used to provide the values for the variables defined in the main.tf and other module files.
email    = "youremail@domain.com"
division = "Enter your division name"

# Resource Names
bot_flow_name                     = "Merge External Contact Bot"
common_module_name                = "Resolve Contact"
queue_name                        = "Merge External Contact Queue"
web_deployment_configuration_name = "Merge External Contact Web Deployment Configuration"
web_deployment_name               = "Merge External Contact Web Deployment"

# IMPORTANT: Do not commit changes in this file that involves saving sensitive information here. This is usually
# a bad idea. This file is not encrypted and is not meant to be used for sensitive information.
client_id     = "client_id"
client_secret = "client_secret"
