vim.g.mapleader = ","
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Enable cursorline but disable cursorcolumn
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- automatically use the system clipboard for copy and paste
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- Search settings
vim.opt.ignorecase = true   -- Case insensitive search by default
vim.opt.smartcase = true    -- Case sensitive if search contains uppercase

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", lazypath
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
		"neovim/nvim-lspconfig",
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
		opts = {}
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
	{ "mfussenegger/nvim-lint" },
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()

			-- Custom keybindings
			vim.keymap.set("n", "<leader>cc", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
			vim.keymap.set("n", "<leader>cu", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle uncomment" })

			-- Visual mode mappings
			vim.keymap.set("v", "<leader>cc", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment (visual)" })
			vim.keymap.set("v", "<leader>cu", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle uncomment (visual)" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons
		config = function()
			require("lualine").setup {
				options = {
					theme = "solarized",
					section_separators = "",
					component_separators = ""
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { {"filename", file_status = true, path =1 }},
					lualine_x = { "gutentags_statusline", "fileformat", "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" }
				}
			}
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
			require("gitsigns").setup {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },  -- Customize highlight group
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				numhl = true,
				current_line_blame = true,
			}

			-- Customize the highlight group for deleted lines
			vim.api.nvim_set_hl(0, "GitSignsDelete", { link = 'GitSignsDelete', fg = "#FF0000", bg = "none", bold = true })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		config = function()
			require("copilot").setup({
				panel = { enabled = true, auto_refresh = true, keymap = { accept = "<Tab>" } },
				suggestion = { enabled = true, auto_trigger = true, debounce = 75, keymap = { 
					accept = "<Tab>", -- Accept suggestion with Tab
					next = "<M-]>",   -- Next suggestion (Alt + ])
					prev = "<M-[>",   -- Previous suggestion (Alt + [)
					dismiss = "<C-]>",-- Dismiss suggestion (Ctrl + ])
				}},
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
					{ name = "path" }
				})
			})
		end
	},
	-- 🌿 Terraform Syntax & Autoformat
	{
		"hashivim/vim-terraform",
		config = function()
			vim.g.terraform_fmt_on_save = 1  -- Auto-format on save
			vim.g.terraform_align = 1        -- Enable alignment
		end
	},

	-- 🏗️ LSP for Terraform (terraform-ls)
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").terraformls.setup({})
		end
	},

	-- 🔥 Treesitter for Better Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "hcl" },  -- Add HCL support
				highlight = { enable = true }
			})
		end
	},

	-- ⚡ Autocompletion (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip"
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
					{ name = "luasnip" }
				})
			})
		end
	},

	-- ✨ Snippet Engine
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
	}
})

require('lint').linters_by_ft = {
	python = {'flake8'}, -- Example: adjust to your needs
	lua = {'luacheck'},
	-- Add more linters per filetype
}

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		require("lint").try_lint()
	end,
})

-- Disable linting on enter and insert leave
vim.api.nvim_create_autocmd({"BufEnter", "InsertLeave"}, {
	callback = function()
		-- No-op to override default behavior if needed
	end,
})

-- Matching parenthesis highlighting
-- (background only to avoid confusion with cursor)
vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#ff8700', bg = 'bg' })

-- Configure diagnostic symbols
vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠", texthl = "DiagnosticSignWarn" })

-- Custom highlight groups
vim.cmd [[
highlight DiagnosticVirtualTextWarn ctermbg=DarkRed
highlight DiagnosticVirtualTextError ctermbg=DarkRed
highlight DiagnosticSignWarn ctermbg=DarkRed
highlight DiagnosticSignError ctermbg=DarkRed
]]

-- Enable filetype detection, plugins and indentation
vim.filetype.add({ enable = true })  -- for filetype detection
vim.g.do_filetype_lua = 1           -- prefer Lua filetype detection (Neovim 0.7+)

vim.keymap.set("n", "<leader>f", "<cmd>FzfLua files<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", "<cmd>FzfLua commands<CR>", { silent = true })

-- Easier window navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move to window below' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move to window right' })
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move to window left' })


vim.keymap.set('n', '<leader>hu', function()
  require('gitsigns').reset_hunk()  -- Undo the current hunk
end, { desc = '[H]unk [U]ndo' })

-- Replace all occurrences of word under cursor with Leader + s
vim.keymap.set('n', '<Leader>s', function()
  local word = vim.fn.expand('<cword>')
  local cmd = string.format('%%s/\\<%s\\>/\\=input("Replace \\"%s\\" with: ")/gc', vim.fn.escape(word, '/\\'), word)
  vim.cmd(cmd)
end, { desc = 'Interactive replace word under cursor' })

-- Show both absolute and relative line numbers
vim.wo.number = true

-- Highlight the current line, but don't highlight the column
vim.wo.cursorline = true
vim.wo.cursorcolumn = false


-- Highlight Pmenu (popup menu) with custom colors
vim.cmd('highlight Pmenu ctermfg=0 ctermbg=DarkGrey guibg=Magenta')

-- Highlight selected item in popup menu (PmenuSel) with custom colors
vim.cmd('highlight PmenuSel ctermfg=242 ctermbg=13 guibg=DarkGrey')

