return {
	-- Mason core setup
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	-- Core LSP setup
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					vim.diagnostic.config({
						virtual_text = true,
						signs = true,
						underline = true,
						update_in_insert = false,
						severity_sort = true,
					})
				end,
			})
		end,
	},

	-- Mason LSP bridge
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"yamlls",
				"ts_ls", -- modern replacement for tsserver
				"gopls",
				"rust_analyzer",
				"tailwindcss",
				"pyright",
				-- "eslint", -- REMOVED: Commented out to disable ESLint LSP
				"html",
				"astro",
				"emmet_ls",
			},
			auto_install = true,
			handlers = {
				-- Default handler for all servers
				function(server_name)
					vim.lsp.config[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,

				-- Lua
				["lua_ls"] = function()
					vim.lsp.config.lua_ls.setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
							},
						},
					})
				end,

				-- Emmet
				["emmet_ls"] = function()
					vim.lsp.config.emmet_ls.setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
						filetypes = {
							"html",
							"css",
							"javascript",
							"typescript",
							"javascriptreact",
							"typescriptreact",
							"astro",
						},
						cmd = { "emmet-ls", "--stdio" },
					})
				end,

				-- ESLint - EXPLICITLY DISABLED to avoid pnpm/Next.js config errors
				["eslint"] = function()
					-- Do nothing - explicitly prevent ESLint from loading
				end,
			},
		},
	},

	-- None-ls (formatting only)
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		config = function()
			local null_ls = require("null-ls")

			-- Append NVM global bin path for Prettier only
			local nvm_bin = os.getenv("HOME") .. "/.nvm/versions/node/v24.12.0/bin"
			if not string.find(vim.env.PATH, nvm_bin, 1, true) then
				vim.env.PATH = vim.env.PATH .. ":" .. nvm_bin
			end

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd, -- Prettier daemon (global)
					null_ls.builtins.formatting.stylua, -- Lua formatter
				},
			})

			-- Auto-format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end,
	},

	-- Treesitter (syntax + highlighting)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"javascript",
				"typescript",
				"tsx",
				"json",
				"html",
				"css",
				"lua",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	-- Lightweight completion setup
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			})
		end,
	},
}
