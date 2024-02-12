local b64 = require "ngx.base64"
local prepare_awsv4_request = require "kong.plugins.aws-request-signing.sigv4"

local AwsSigV4Handler = {
  PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
  VERSION = "0.1", -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.
}

function AwsSigV4Handler:access(conf)
  local match_result = "no"
  local plain_text = "foobar"
  kong.log.info(string.format("MY SECRET IS %s", conf.secret))
  kong.log.info(string.format("PLAIN %s", plain_text))
  kong.log.info(string.format("BASE64 %s", b64.encode_base64url(plain_text)))
  kong.log.inspect(kong.request)
  local opts = {
    region = "us-east-1",
    service = "s3",
    access_key = "1234567890",
    secret_key = "0987654321",
    method = kong.request.get_method(),
    host = kong.request.get_host(),
    port = kong.request.get_port(),
    headers = kong.request.get_headers(),
    path = kong.request.get_path(),
    body = kong.request.get_body(),
    query = kong.request.get_raw_query(),
   }
  kong.log.inspect(opts)
  local prepared = prepare_awsv4_request(opts)
  kong.log.inspect(prepared)
  -- output
  -- TODO: this should go downstream, not return, it is at the moment kong.response.set_header instead of kong.service.request.set_header for debugging purposes only
  kong.response.set_header("x-aws-signatures-match", match_result)
end

return AwsSigV4Handler
