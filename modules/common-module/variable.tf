variable "module_name" {
  type        = string
  description = "Name to assign to the Common Module."
}

variable "division" {
  type        = string
  description = "Name of the Division to assign to the Common Module."
}

variable "data_action_category" {
  type        = string
  description = "The Data Action Category that is to be used in the Common Module."
}

variable "fetch_external_contact_by_identifier_data_action" {
  type        = string
  description = "The Data Action name that is to be used in the Common Module."
}

variable "get_external_contact_id_for_customer_participant_data_action" {
  type        = string
  description = "The Data Action name that is to be used in the Common Module."
}

variable "merge_external_contacts_data_action" {
  type        = string
  description = "The Data Action name that is to be used in the Common Module."
}
