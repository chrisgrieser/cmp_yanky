-- DOCS `:h cmp-develop`
--------------------------------------------------------------------------------

local M = {}

function M.new() return setmetatable({}, { __index = M }) end

function M:complete(request, callback)
	local history = require("yanky.history").all()
	if request.option.onlyCurrentFiletype then
		history = vim.tbl_filter(function(item) return item.filetype == vim.bo.ft end, history)
	end
	history = vim.tbl_map(function(item)
		local labelMaxLen = 30
		local label = item.regcontents
		if #label > labelMaxLen then label = label:sub(1, labelMaxLen) .. "…" end
		return {
			label = label,
			documentation = { kind = "plaintext", value = item.regcontents },
			insertText = item.regcontents,
		}
	end, history)
	callback { items = history }
end

--------------------------------------------------------------------------------
return M
