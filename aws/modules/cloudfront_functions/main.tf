resource "aws_cloudfront_key_value_store" "function_kvs" {
  name    = "build_website_kvs"
  comment = "This custom build website key value store"
}


resource "aws_cloudfrontkeyvaluestore_key" "build_id" {
  depends_on          = [aws_cloudfront_key_value_store.function_kvs]
  key_value_store_arn = aws_cloudfront_key_value_store.function_kvs.arn
  key                 = "prod_build_id"
  value               = "v1"

}

locals {
  depends_on = [aws_cloudfront_key_value_store.function_kvs]
  parts      = split("/", aws_cloudfront_key_value_store.function_kvs.arn)

  key_value_store_id = local.parts[length(local.parts) - 1]
}


resource "aws_cloudfront_function" "my_website_cookie_checker" {
  depends_on = [aws_cloudfront_key_value_store.function_kvs]
  name       = "cookie_checker_tf"
  runtime    = "cloudfront-js-2.0"
  comment    = "my function"
  publish    = true
  key_value_store_associations = [
    aws_cloudfront_key_value_store.function_kvs.arn
  ]

  #   code       = file("${path.module}/cookie_function.js")
  code = <<-EOF
  import cf from "cloudfront";

async function handler(event) {
  let build_id =
    event.request.cookies.build_id && event.request.cookies.build_id.value;

  const build_id_kvs_key = "prod_build_id";

  if (!build_id) {
    try {
      const kvsId = "${local.key_value_store_id}" ;
      // This fails if the key value store is not associated with the function
      const kvsHandle = cf.kvs(kvsId);
      build_id = await kvsHandle.get(build_id_kvs_key);
    } catch (err) {
    console.log({err})
    }
  }

  var request = event.request;
  var uri = request.uri;

  if (!uri.match(/\.(js|css|svg)$/)) {
    request.uri = "/" + build_id + "/index.html";
  }

  console.log(request);
  return request;
}

EOF
}
