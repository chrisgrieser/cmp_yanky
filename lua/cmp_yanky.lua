-- based on https://github.com/dmitmel/cmp-cmdline-history/blob/master/lua/cmp_cmdline_history.lua
--------------------------------------------------------------------------------

local M = {}

function M.new() return setmetatable({}, { __index = M }) end

function M:get_keyword_pattern() return ".*" end

function M:complete(_, callback)
	local history = require("yanky.history").all()
	local historyOfFt = vim.tbl_filter(function(item) return item.filetype == vim.bo.ft end, history)
	local historyStrings = vim.tbl_map(function(item) return item.regcontents end, historyOfFt)
	callback { items = historyStrings }
end

return M
