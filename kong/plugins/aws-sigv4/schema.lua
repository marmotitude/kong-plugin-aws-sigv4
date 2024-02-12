local PLUGIN_NAME = "aws-sigv4"

local schema = {
  name = PLUGIN_NAME,
  fields = {
    { config = {
        type = "record",
        fields = {
          { secret = { required = true, type = "string" } },
        },
      },
    },
  },
}

return schema
