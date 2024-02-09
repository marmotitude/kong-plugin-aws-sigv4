# aws-sigv4 Kong Plugin

[Kong](https://docs.konghq.com/gateway-oss/) plugin for generating AWS signatures version 4.

Can be used by the gateway to verify a received signed request, if you know the requester's secret key.

AWS Signature v4 utilizes a hash-based symmetric-key approach, where both the client and the server share a common secret key (referred to as the AWS secret access key). This secret key is used to compute the signature during request signing on the client side and for signature verification on the server side.

## Overview

Given a request with the proper **HTTP Authorization header** or **query string parameter** in the style of [AWS Signature v4](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html), this plugin will use a **provided secret access key** to recreate the signature and pass two new headers downstream as result:

- `x-aws-signatures-match`
  - string, `yes` | `no`
- `x-aws-sigv4-error-code`
  - string, `''` | a short code
- `x-aws-sigv4-error-message`
  - string, `''` | a brief message in English
 
### How to provide the secret

Another plugin of higher priority must set the `kong.ctx.aws_sigv4_secret` value. Or you can pass it as a function argument if you use the code as library, see below.

### Using it as a library

The plugin logic can be used as part of other plugin without the need to use context and headers for communication. The main functions are under the `plugins/aws-sigv4/lib` directory and can be imported or copy/pasted into your code.

#### Note / TODO

It would be nice to make this lib folder a luarocks package sometime in the future. If you know how to help please open a Pull Request.

## License

MIT

## Development

For development and local testing, use [kong-pongo](https://github.com/Kong/kong-pongo).

### Running tests

Tests are located on the [/specs](./spec) folder. To run the whole suite use:

```
pongo run
```

### Pongo shell

To manually make requests to a Kong Gateway configured with this plugin, you can use the pongo shell,
to recreate the environment and enter a interactive shell type:

```
pongo restart
pongo shell
```

Inside the shell, a bootstrap script that starts kong and configure services, routes and plugins
will run, the contents of this script is at [.pongo/pongo-setup.sh](.pongo/pongo-setup.sh).

After this initial setup, kong will be running on `localhost:8000` and you can type curl commands
to send requests to it (the kong API runs on port 8001 if needed for aditional setups).

## Acknowledgements

- https://github.com/Kong/kong-plugin/tree/master
- https://github.com/Kong/kong-pongo
- https://github.com/marmotitude/kong-plugin-boilerplate
