-- Options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.wo.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect"
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.list = true
vim.opt.laststatus = 3
vim.opt.pumheight = 10
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

-- Keymaps
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-S>", ":%s/")
vim.keymap.set("n", "sp", ":sp<CR>")
vim.keymap.set("n", "vs", ":vs<CR>")
vim.keymap.set("n", "<leader>o", ":only<CR>", { silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Lazy
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

-- Plugins
require("lazy").setup({

	-- Mini.nvim library
	{
		"echasnovski/mini.nvim",
		version = false,
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},

	-- Automatic indentation
	"tpope/vim-sleuth",

	-- Autoclose HTML-style tags
	"windwp/nvim-ts-autotag",
	"onsails/lspkind.nvim",

	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
			"folke/neodev.nvim",
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"rafamadriz/friendly-snippets",
		},
	},

	-- Fuzzy find
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		opts = {
			pickers = {
				git_commits = { previewer = false, theme = "ivy" },
				grep_string = { previewer = false, theme = "ivy" },
				diagnostics = { previewer = false, theme = "ivy" },
				find_files = { previewer = false, theme = "ivy" },
				buffers = { previewer = false, theme = "ivy" },
				current_buffer_fuzzy_find = { theme = "ivy" },
				resume = { previewer = false, theme = "ivy" },
				live_grep = { theme = "ivy" },
			},
			defaults = {
				layout_config = {
					prompt_position = "bottom",
				},
			},
		},
		keys = {
			{ "<leader>z", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "File fuzzy find" },
			{ "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
			{ "<leader>w", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
			{ "<leader>g", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
			{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>c", "<cmd>Telescope resume<cr>", desc = "Resume search" },
			{ "<leader>s", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = "all",
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true, enable_close_on_slash = false },
			})
		end,
	},

	-- Colourschemes
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		lazy = false,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre",
		config = function() end,
	},

	-- Code formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				graphql = { "prettierd" },
				json = { "prettierd" },
				css = { "prettierd" },
				lua = { "stylua" },
			},
			format_on_save = {},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- Autopair characters
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},

	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},

	-- Keymap hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
})

-- Set up colorscheme
require("nightfox").setup({
	options = {
		transparent = false,
	},
})
vim.cmd("colorscheme nightfox")

-- Set up indent-blankline
require("ibl").setup({
	indent = { char = "│", tab_char = "│" },
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Set up Mini.nvim plugins
require("mini.cursorword").setup()
require("mini.jump2d").setup()

-- Open Telescope on start
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})

-- Trouble keymaps
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end, { desc = "Toggle Trouble" })
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end, { desc = "Quickfix" })
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, { desc = "Loclist" })
vim.keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end, { desc = "LSP References" })

-- Set up Bufferline
require("bufferline").setup({
	options = {
		themable = true,
	},
})

-- Bufferline keymaps
vim.keymap.set("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
vim.keymap.set("n", "<C-q>", "<cmd> bd <CR>")

-- Set up Mason
require("mason").setup()
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
})

-- LSP keymaps
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>.", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- Set up nvim-cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
