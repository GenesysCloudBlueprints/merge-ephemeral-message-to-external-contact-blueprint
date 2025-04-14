variable "client_id" {
  type        = string
  description = "The OAuth (Client Credentails) Client ID to be used by Data Actions"
}

variable "client_secret" {
  type        = string
  description = "The OAuth (Client Credentails) Client Secret to be used by Data Actions"
}

variable "email" {
  type        = string
  description = "Your user email. This is used to include the given user in the queue"
}

variable "division" {
  type        = string
  description = "The Division to be used to deploy the resources"
}

variable "common_module_name" {
  type        = string
  description = "The Common Module name that is to be used in the In-Queue Call Flow."
}

variable "bot_flow_name" {
  type        = string
  description = "The Bot Flow name that is to be used in the In-Queue Call Flow."
}

variable "queue_name" {
  type        = string
  description = "The Queue name that is to be used in the In-Queue Call Flow."
}

variable "web_deployment_configuration_name" {
  type        = string
  description = "The name of the web deployment configuration"
}

variable "web_deployment_name" {
  type        = string
  description = "The name of the web deployment"
}
