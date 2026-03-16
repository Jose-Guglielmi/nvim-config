require("lazy").setup({
  { "folke/tokyonight.nvim" },
  { "akinsho/toggleterm.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "rust-lang/rust.vim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "numToStr/Comment.nvim" }
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "rust_analyzer" }
})

local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" }
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Enter>"] = cmp.mapping.confirm({ select = true })
  })
})

vim.lsp.config('rust_analyzer', {
  capabilities = cmp_lsp.default_capabilities(),
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true }
    }
  }
})

vim.lsp.enable('rust_analyzer')

vim.cmd.colorscheme("tokyonight")

vim.opt.guifont = "Inder:h14"

vim.opt.number = true
vim.opt.relativenumber = true

local Terminal = require('toggleterm.terminal').Terminal

local float_term1 = Terminal:new({
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  on_open = function(term)
    vim.cmd("startinsert")
  end,
})

local float_term2 = Terminal:new({
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    relative = 'editor',
    position = 'NE',
    size = function()
      local width = vim.o.columns
      local height = vim.o.lines
      return { width = math.floor(width * 0.35), height = math.floor(height * 0.35) }
    end
  },
  on_open = function(term)
    vim.cmd("startinsert")
  end,
})

local float_term3 = Terminal:new({
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    relative = 'editor',
    position = 'SE',
    size = function()
      local width = vim.o.columns
      local height = vim.o.lines
      return { width = math.floor(width * 0.35), height = math.floor(height * 0.35) }
    end
  },
  on_open = function(term)
    vim.cmd("startinsert")
  end,
})

local term1_open = false
local term2_open = false
local term3_open = false

function _G.toggle_float_term1()
  if term1_open then
    float_term1:toggle()
    term1_open = false
  else
    if term2_open then float_term2:toggle(); term2_open = false end
    if term3_open then float_term3:toggle(); term3_open = false end
    float_term1:toggle()
    term1_open = true
    vim.defer_fn(function() vim.cmd("startinsert") end, 10)
  end
end

function _G.toggle_float_term2()
  if term2_open then
    float_term2:toggle()
    term2_open = false
  else
    if term1_open then float_term1:toggle(); term1_open = false end
    if term3_open then float_term3:toggle(); term3_open = false end
    float_term2:toggle()
    term2_open = true
    vim.defer_fn(function() vim.cmd("startinsert") end, 10)
  end
end

function _G.toggle_float_term3()
  if term3_open then
    float_term3:toggle()
    term3_open = false
  else
    if term1_open then float_term1:toggle(); term1_open = false end
    if term2_open then float_term2:toggle(); term2_open = false end
    float_term3:toggle()
    term3_open = true
    vim.defer_fn(function() vim.cmd("startinsert") end, 10)
  end
end

function _G.close_all_float_terms()
  if term1_open then float_term1:toggle(); term1_open = false end
  if term2_open then float_term2:toggle(); term2_open = false end
  if term3_open then float_term3:toggle(); term3_open = false end
end

vim.api.nvim_set_keymap('n', '<C-1>', '<cmd>lua toggle_float_term1()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-1>', '<cmd>lua toggle_float_term1()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-2>', '<cmd>lua toggle_float_term2()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-2>', '<cmd>lua toggle_float_term2()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-3>', '<cmd>lua toggle_float_term3()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-3>', '<cmd>lua toggle_float_term3()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-k>', '<C-c>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>w', '<cmd>w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>q', '<cmd>q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>wq', '<cmd>wq<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>f', '<cmd>lua require("telescope.builtin").buffers({ theme = "dropdown", previewer = false })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Up>', '<cmd>lua require("telescope.builtin").buffers({ theme = "dropdown", previewer = false })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Down>', '<cmd>bdelete<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Left>', '<cmd>bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Right>', '<cmd>bnext<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space><Space>j', '<cmd>vsplit | lua require("telescope.builtin").buffers({ theme = "dropdown", previewer = false })<CR>', { noremap = true, silent = true })

function _G.open_file_in_split()
  require("telescope.builtin").find_files({
    attach_mappings = function(prompt_bufnr, map)
      local action_state = require("telescope.actions.state")
      map("i", "<cr>", function()
        local selection = action_state.get_selected_entry()
        local filename = selection[1]
        vim.cmd("bd! " .. prompt_bufnr)
        local found = false
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_get_name(buf) == filename then
            vim.cmd("vsplit | buffer " .. buf)
            found = true
            break
          end
        end
        if not found then
          vim.cmd("vsplit " .. filename)
        end
      end)
      return true
    end
  })
end

vim.api.nvim_set_keymap('n', '<Space>h', '<cmd>lua open_file_in_split()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>j', '<cmd>wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>k', '<cmd>wincmd l<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'r', 'w', { noremap = true, silent = true })
vim.keymap.set('n', 'R', 'e', { noremap = true, silent = true })
vim.keymap.set('n', 'e', 'ge', { noremap = true, silent = true })
vim.keymap.set('n', 'E', 'b', { noremap = true, silent = true })

require("Comment").setup()

vim.keymap.set('n', '<leader>c', 'gcc', { noremap = true, silent = true })
vim.keymap.set('x', '<leader>c', 'gc', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bc', 'gbc', { noremap = true, silent = true })
