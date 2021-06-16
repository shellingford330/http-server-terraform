resource "aws_lambda_function" "example_api" {
  filename      = "dummy_function.zip"
  function_name = "example-api"
  role          = aws_iam_role.example_lambda.arn
  handler       = "lambda"
  runtime       = "go1.x"

  memory_size = 128
  timeout     = 900

  environment {
    variables = {
      DYNAMO_TABLE_USERS : aws_dynamodb_table.example_users.name
    }
  }
}

resource "aws_lambda_permission" "example_apigateway_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example_api.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.example_api.execution_arn}/*/*/*"
}
