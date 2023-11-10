-- DOCS `:h cmp-develop`
--------------------------------------------------------------------------------

local M = {}

function M.new() return setmetatable({}, { __index = M }) end

function M:complete(request, callback)
	local defaultOpts = {
		onlyCurrentFiletype = false,
	}
	local opts = vim.tbl_deep_extend("force", defaultOpts, request.option or {})

	local history = require("yanky.history").all()
	local currentFt = vim.api.nvim_buf_get_option(0, "filetype")

	if opts.currentFiletype then
		history = vim.tbl_filter(function(item) return item.filetype == currentFt end, history)
	end

	local minLength = request.option.minLength or 3
	history = vim.tbl_filter(
		function(item) return #vim.trim(item.regcontents) >= minLength end,
		history
	)

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
