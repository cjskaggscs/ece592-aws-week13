resource "aws_apigatewayv2_api" "week13-apigw" {
    name = "week13-apigw"
    protocol_type = "HTTP"
    target = aws_lambda_function.lambda.arn
}

resource "aws_apigatewayv2_integration" "week13-integration" {
    api_id = aws_apigatewayv2_api.week13-apigw.id
    integration_type = "AWS_PROXY"
    integration_uri = aws_lambda_function.lambda.arn
    payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "week13-get-route" {
    api_id = aws_apigatewayv2_api.week13-apigw.id
    route_key = "GET /urls/{id}"
    target = "integrations/${aws_apigatewayv2_integration.week13-integration.id}"
}

resource "aws_apigatewayv2_route" "week13-post-route" {
    api_id = aws_apigatewayv2_api.week13-apigw.id
    route_key = "POST /urls"
    target = "integrations/${aws_apigatewayv2_integration.week13-integration.id}"
}
