require("nvim-tree").setup({
	view = {
		mappings = {
			list = {
				-- Disable filter so that I can toggle the tree with fe key combination
				{ key = "f", action = ""}
			}
		}
	}

})
