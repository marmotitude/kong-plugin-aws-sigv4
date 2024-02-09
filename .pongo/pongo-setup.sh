#!/bin/bash
if [ "$PONGO_COMMAND" = "shell" ]; then

  # Make Kong use the declarative config from file kong-conf.yaml of the host
  export KONG_DATABASE=off
  # pongo shell mounts the plugin root directory as /kong-plugins
  export KONG_DECLARATIVE_CONFIG=/kong-plugin/kong-conf.yaml

  extra_commands='
  alias ra="curl -i --head --url \"http://localhost:8000/foo\""
  echo "  ra    -  example request A"
  '
  echo "$extra_commands" >> /root/.profile

  kong start
fi
