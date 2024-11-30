vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
-- vim.cmd("set nuw=4")
vim.cmd("set clipboard=unnamedplus")
function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC'})
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F'})
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

LineNumberColors()

-- require("nvim-tree").setup {}
vim.keymap.set("n", "<leader>xx", ":Neotree filesystem reveal right<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>xr", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>xf", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
