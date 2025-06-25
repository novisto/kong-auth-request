local http = require("resty.http")

local _M = {}

local function new_auth_request_params(origin_request_headers_to_forward_to_auth)
	local headers = {
		charset = "utf-8",
		["content-type"] = "application/json",
	}
	for _, name in ipairs(origin_request_headers_to_forward_to_auth) do
		local header_val = kong.request.get_header(name)
		if header_val then
			headers[name] = header_val
		end
	end
	return {
		method = "GET",
		headers = headers,
	}
end

function _M.execute(conf)
	local httpc = http.new()
	httpc:set_timeout(conf.timeout)

	local auth_request_params = new_auth_request_params(conf.origin_request_headers_to_forward_to_auth)

	-- For https URIs, enable SSL. The request_uri function handles the handshake.
	if string.sub(conf.auth_uri, 1, 5) == "https" then
		auth_request_params.ssl_verify = true
	end

	-- The request_uri method handles parsing the URI, connecting, and sending the request.
	local res, err = httpc:request_uri(conf.auth_uri, auth_request_params)

	if not res then
		kong.log.err("auth request to '", conf.auth_uri, "' failed: ", tostring(err))
		return kong.response.exit(500, { message = "Auth request failed" })
	end

	if res.status > 299 then
		return kong.response.exit(res.status, res.body)
	end

	for _, name in ipairs(conf.auth_response_headers_to_forward) do
		if res.headers[name] then
			kong.service.request.set_header(name, res.headers[name])
		end
	end
end

return _M
