vim.g.mapleader = ","
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations

-- Enable cursorline but disable cursorcolumn
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- automatically use the system clipboard for copy and paste
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Search settings
vim.opt.ignorecase = true -- Case insensitive search by default
vim.opt.smartcase = true -- Case sensitive if search contains uppercase

-- Disable all mouse functionality
vim.opt.mouse = ""

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Always show the status line
vim.o.laststatus = 2

-- Keep 3 lines visible above and below the cursor
vim.o.scrolloff = 3

require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},
		files = {
			-- Disable resume to always get fresh results
			resume = false,
			-- Or set a shorter cache timeout
			cache = { timeout = 60 }, -- seconds
		},
	},
	{
		"tomasr/molokai",
		lazy = false,
		priority = 1000, -- Load before applying the colorscheme
		config = function()
			vim.cmd("colorscheme molokai")
		end,
	},
	{ "fatih/vim-go" },
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				python = { "ruff" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()

			-- Custom keybindings
			vim.keymap.set("n", "<leader>cc", function()
				require("Comment.api").toggle.linewise.current()
			end, { desc = "Toggle comment" })
			vim.keymap.set("n", "<leader>cu", function()
				require("Comment.api").toggle.linewise.current()
			end, { desc = "Toggle uncomment" })

			-- Visual mode mappings
			vim.keymap.set(
				"v",
				"<leader>cc",
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				{ desc = "Toggle comment (visual)" }
			)
			vim.keymap.set(
				"v",
				"<leader>cu",
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				{ desc = "Toggle uncomment (visual)" }
			)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons
		config = function()
			require("lualine").setup({
				options = {
					theme = "solarized",
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { { "filename", file_status = true, path = 1 } },
					lualine_x = { "gutentags_statusline", "fileformat", "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" }, -- Customize highlight group
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				numhl = true,
				current_line_blame = true,
			})

			-- Customize the highlight group for deleted lines
			vim.api.nvim_set_hl(
				0,
				"GitSignsDelete",
				{ link = "GitSignsDelete", fg = "#FF0000", bg = "none", bold = true }
			)
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		config = function()
			require("copilot").setup({
				panel = { enabled = true, auto_refresh = true, keymap = { accept = "<Tab>" } },
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<Tab>", -- Accept suggestion with Tab
						next = "<M-]>", -- Next suggestion (Alt + ])
						prev = "<M-[>", -- Previous suggestion (Alt + [)
						dismiss = "<C-]>", -- Dismiss suggestion (Ctrl + ])
					},
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = {
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	-- 🌿 Terraform Syntax & Autoformat
	{
		"hashivim/vim-terraform",
		config = function()
			vim.g.terraform_fmt_on_save = 1 -- Auto-format on save
			vim.g.terraform_align = 1 -- Enable alignment
		end,
	},

	-- 🏗️ LSP for Terraform (terraform-ls)
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").terraformls.setup({})
		end,
	},

	-- 🏗️ LSP for Go
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Go (gopls)
			vim.g.go_def_mapping_enabled = 0 -- disable vim-go's goto def

			lspconfig.gopls.setup({
				on_attach = function(client, bufnr)
					local opts = { buffer = bufnr, noremap = true, silent = true }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

					--
					-- =====================
					-- Auto Format + Organize Imports on Save
					-- =====================
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								-- Format buffer
								vim.lsp.buf.format({ async = false })

								-- Organize imports via code action
								local params = vim.lsp.util.make_range_params(nil, "utf-16")
								params.context = { only = { "source.organizeImports" } }

								local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
								for _, res in pairs(results or {}) do
									for _, r in pairs(res.result or {}) do
										if r.edit then
											vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
										elseif r.command then
											vim.lsp.buf.execute_command(r.command)
										end
									end
								end
							end,
						})
					end
				end,
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})
		end,
	},

	-- 🔥 Treesitter for Better Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "hcl" }, -- Add HCL support
				highlight = { enable = true },
			})
		end,
	},

	-- ⚡ Autocompletion (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				}),
			})
		end,
	},

	-- ✨ Snippet Engine
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("avante").setup({
				provider = "claude",
				claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-3-5-haiku-20241022",
					temperature = 0,
					max_tokens = 4096,
				},
				-- Limit context to current buffer only
				behaviour = {
					auto_suggestions = false, -- Disable auto-suggestions
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					support_paste_from_clipboard = false,
				},
			})
		end,
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					check_outdated_packages_on_open = true,
					border = "rounded",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- Old-style handler (works on all versions)
			local lspconfig = require("lspconfig")

			require("mason-lspconfig").setup({
				ensure_installed = { "pyright" },
				handlers = {
					-- Default handler
					function(server_name)
						lspconfig[server_name].setup({})
					end,
					-- Pyright-specific config
					["pyright"] = function()
						lspconfig.pyright.setup({
							settings = {
								python = {
									analysis = {
										typeCheckingMode = "basic",
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.stylua,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
})

require("lint").linters_by_ft = {
	python = { "flake8" }, -- Example: adjust to your needs
	lua = { "luacheck" },
	-- Add more linters per filetype
}

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		require("lint").try_lint()
	end,
})

-- Disable linting on enter and insert leave
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
	callback = function()
		-- No-op to override default behavior if needed
	end,
})

-- Matching parenthesis highlighting
-- (background only to avoid confusion with cursor)
vim.api.nvim_set_hl(0, "MatchParen", { fg = "#ff8700", bg = "bg" })

-- Configure diagnostic symbols
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "⚠",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
	},
})

-- Custom highlight groups
vim.cmd([[
highlight DiagnosticVirtualTextWarn ctermbg=DarkRed
highlight DiagnosticVirtualTextError ctermbg=DarkRed
highlight DiagnosticSignWarn ctermbg=DarkRed
highlight DiagnosticSignError ctermbg=DarkRed
]])

-- Disable scroll wheel (other means than mouse))
vim.cmd([[noremap <ScrollWheelUp> <nop>]])
vim.cmd([[noremap <ScrollWheelDown> <nop>]])
vim.cmd([[noremap <ScrollWheelLeft> <nop>]])
vim.cmd([[noremap <ScrollWheelRight> <nop>]])

-- Enable filetype detection, plugins and indentation
vim.filetype.add({ enable = true }) -- for filetype detection
vim.g.do_filetype_lua = 1 -- prefer Lua filetype detection (Neovim 0.7+)

vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", "<cmd>FzfLua commands<CR>", { silent = true })

-- Easier window navigation
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

vim.keymap.set("n", "<leader>hu", function()
	require("gitsigns").reset_hunk() -- Undo the current hunk
end, { desc = "[H]unk [U]ndo" })

-- Replace all occurrences of word under cursor with Leader + s
-- -- Replace word under cursor with Leader + s, showing command for editing
vim.keymap.set("n", "<Leader>s", function()
	local word = vim.fn.expand("<cword>")
	local cmd = string.format("%%s/\\<%s\\>/", vim.fn.escape(word, "/\\"))
	vim.fn.feedkeys(":" .. cmd, "n") -- Pre-fill command-line with the substitution pattern
end, { desc = "Interactive replace word under cursor (editable command)" })

-- vim.keymap.set('n', '<Leader>s', function()
--   local word = vim.fn.expand('<cword>')
--   local replacement = vim.fn.input('Replace "' .. word .. '" with: ')
--   if replacement ~= '' then
--     local cmd = string.format('%%s/\\<%s\\>/%s/gc', vim.fn.escape(word, '/\\'), vim.fn.escape(replacement, '/\\'))
--     vim.cmd(cmd)
--   end
-- end, { desc = 'Interactive replace word under cursor' })

-- <leader>d will pop up the message in a floating window
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- Show both absolute and relative line numbers
vim.wo.number = true

-- Highlight the current line, but don't highlight the column
vim.wo.cursorline = true
vim.wo.cursorcolumn = false

-- Highlight Pmenu (popup menu) with custom colors
vim.cmd("highlight Pmenu ctermfg=0 ctermbg=DarkGrey guibg=Magenta")

-- Highlight selected item in popup menu (PmenuSel) with custom colors
vim.cmd("highlight PmenuSel ctermfg=242 ctermbg=13 guibg=DarkGrey")
