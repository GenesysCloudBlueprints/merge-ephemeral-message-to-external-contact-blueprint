variable "flow_name" {
  type        = string
  description = "Name to assign to the In-Queue Call flow."
}

variable "division" {
  type        = string
  description = "Name of the Division to assign to the Call Flow."
}

variable "queue_name" {
  type        = string
  description = "The Queue name that is to be used in the In-Queue Call Flow."
}

variable "common_module_name" {
  type        = string
  description = "The Common Module name that is to be used in the In-Queue Call Flow."
}

variable "bot_flow_name" {
  type        = string
  description = "The Bot Flow name that is to be used in the In-Queue Call Flow."
}
