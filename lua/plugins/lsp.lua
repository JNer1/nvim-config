return {
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver" },
				handlers = {
					default_setup,
				},
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert({
					-- Enter key confirms completion item
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- Ctrl + space triggers completion menu
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
}
