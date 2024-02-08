local PLUGIN_NAME = "aws-sigv4"

local schema = {
  name = PLUGIN_NAME,
  fields = {
    { config = {
        type = "record",
        fields = {
          { some_config = { required = true, type = "string" } },
          { some_other_config = { required = true, type = "string" } },
        },
      },
    },
  },
}

return schema
