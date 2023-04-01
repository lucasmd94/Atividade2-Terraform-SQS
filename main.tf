resource "aws_sqs_queue" "queue" {
  name = var.queue_name
  delay_seconds = var.delay_seconds
  max_message_size = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count_dlq
  })

  tags = {
    "Name" = "queue-${var.queue_name}"
	}
}


resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}-dlq"

  tags = {
    "Name" = "dlq-queue-${var.queue_name}DLQ"
	}
}
