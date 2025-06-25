package = "nv-kong-auth-request"

version = "0.1.0-0"

supported_platforms = { "linux", "macosx" }

source = {
	url = "git://github.com/novisto/kong-auth-request",
	tag = "0.1.0",
}

description = {
	summary = "A Kong plugin that make GET auth request before proxying the original. Maintained by Novisto.",
	license = "MIT",
}

dependencies = {}

build = {
	type = "builtin",
	modules = {
		["kong.plugins.kong-auth-request.access"] = "src/access.lua",
		["kong.plugins.kong-auth-request.handler"] = "src/handler.lua",
		["kong.plugins.kong-auth-request.schema"] = "src/schema.lua",
	},
}
