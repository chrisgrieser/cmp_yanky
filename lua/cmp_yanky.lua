-- DOCS `:h cmp-develop`
--------------------------------------------------------------------------------

local M = {}

function M.new() return setmetatable({}, { __index = M }) end

function M:complete(request, callback)
	local history = require("yanky.history").all()
	local currentFt = vim.api.nvim_buf_get_option(0, "filetype")

	if request.option.onlyCurrentFiletype then
		history = vim.tbl_filter(function(item) return item.filetype == currentFt end, history)
	end

	local seenItems = {} 

	history = vim.tbl_map(function(item)
		local ft = item.filetype or ""
		-- avoid duplicated items showing up
		if seenItems[item.regcontents] then return end
		seenItems[item.regcontents] = true

		-- shorten completion text to display
		local labelMaxLen = 30
		local label = vim.trim(item.regcontents)
		if #label > labelMaxLen then label = label:sub(1, labelMaxLen) .. "…" end

		-- syntax highlighting of full content in the documentation window
		local docs = {
			kind = "markdown",
			value = table.concat({
				"```" .. ft,
				vim.trim(item.regcontents),
				"```",
			}, "\n"),
		}

		return {
			label = label, -- text displayed
			documentation = docs,
			insertText = item.regcontents, -- text inserted
			filterText = item.regcontents, -- text matched
		}
	end, history)
	callback { items = history }
end

--------------------------------------------------------------------------------
return M
