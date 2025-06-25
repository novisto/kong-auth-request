return {
	name = "kong-auth-request",
	fields = {
		{
			config = {
				type = "record",
				fields = {
					{ auth_uri = { type = "string", required = true } },
					{ timeout = { type = "number", default = 10000 } },
					{ keepalive_timeout = { type = "number", default = 60000 } },
					{
						origin_request_headers_to_forward_to_auth = {
							type = "array",
							elements = { type = "string" },
							default = {},
						},
					},
					{
						auth_response_headers_to_forward = {
							type = "array",
							elements = { type = "string" },
							default = {},
						},
					},
				},
			},
		},
	},
}
