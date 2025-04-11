/*
  Creates the queue
*/
resource "genesyscloud_routing_queue" "queue" {
  name = var.queue_name
  members {
    user_id = var.user_id
  }
}
