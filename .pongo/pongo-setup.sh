#!/bin/bash

# Dependency kong-aws-request-signing is not on LuaRocks
# We are using a fork at marmotitude instead of the upstream LEGO project
# because their .rockspec manifest is pointing to a tag that is not there
# see https://github.com/LEGO/kong-aws-request-signing/issues/23
luarocks install https://raw.githubusercontent.com/marmotitude/kong-aws-request-signing/main/kong-aws-request-signing-1.0.3-3.rockspec

if [ "$PONGO_COMMAND" = "shell" ]; then

  # Make Kong use the declarative config from file kong-conf.yaml of the host
  export KONG_DATABASE=off
  # pongo shell mounts the plugin root directory as /kong-plugins
  export KONG_DECLARATIVE_CONFIG=/kong-plugin/kong-conf.yaml

  extra_commands='
  alias ra="curl -i --head --url \"http://localhost:8000/foo\""
  echo "  ra    -  example request A"
  alias rb="curl -i --head --url \"http://localhost:8000/foo?with=a&query=string#and_an_anchor\""
  echo "  rb    -  example request B"
  '
  echo "$extra_commands" >> /root/.profile

  kong start
fi

