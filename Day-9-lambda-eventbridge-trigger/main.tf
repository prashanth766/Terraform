
resource "aws_iam_role" "lambda_role" {
    name = "lambda_execution_roleee"

    assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com"
                ]
            }
        }
    ]
})



  
}
resource "aws_iam_role_policy_attachment" "lambda_policy" {
    role = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  
}

  
resource "aws_lambda_function" "lambda" {
    function_name = "lambda_test_function"
    role = aws_iam_role.lambda_role.arn
    runtime = "python3.12"
    handler = "app.lambda_handler"
    timeout = 900
    memory_size = 128
    filename = "app.zip"
    source_code_hash = filebase64sha256("app.zip") # it tarck the changes in code
  
}
# creation of event bridge rule(shedule)
resource "aws_cloudwatch_event_rule" "every_2_minutes" {
    name = "every_2_mins"
    description = "trigger_every_2_minutes"
      schedule_expression = "rate(2 minutes)"
  #schedule_expression = "cron(0/2 * * * ? *)"

  
}
# Add the Lambda target
resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.every_2_minutes.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda.arn
}
#Allow EventBridge to invoke the Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_2_minutes.arn
}
