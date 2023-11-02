-- based on https://github.com/dmitmel/cmp-cmdline-history/blob/master/lua/cmp_cmdline_history.lua
--------------------------------------------------------------------------------

local M = {}

function M.new() return setmetatable({}, { __index = M }) end

function M:get_keyword_pattern() return ".*" end

function M:complete(request, callback)
	local history = require("yanky.history").all()
	if request.option.onlyCurrentFiletype then
		history = vim.tbl_filter(function(item) return item.filetype == vim.bo.ft end, history)
	end
	history = vim.tbl_map(
		function(item)
			local maxLength = 30
			local label = #item.regcontents > maxLength and item.regcontents:sub(1, maxLength) .. "…" or item.regcontents
			return {
				label = label,
				documentation = { kind = "plaintext", value = item.regcontents },
				insertText = item.regcontents,
			}
		end,
		history
	)
	callback { items = history }
end

return M
