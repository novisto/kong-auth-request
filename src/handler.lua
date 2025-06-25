local access = require("kong.plugins.kong-auth-request.access")

local AuthRequestHandler = {}

AuthRequestHandler.PRIORITY = 900
AuthRequestHandler.VERSION = "0.1.0"

function AuthRequestHandler:access(conf)
	access.execute(conf)
end

return AuthRequestHandler
