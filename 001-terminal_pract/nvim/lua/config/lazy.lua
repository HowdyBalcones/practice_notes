-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- sets mapleader and maplocalleader before loading lazyvim so that mappings are correct
-- also a good place to put other settings according to documentation
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup for lazy.nvim
require("lazy").setup({
	spec = {
		-- plugins go inside here
		{
			"tiagovla/tokyodark.nvim",
			opts = {},
			config = function(_, opts)
				require("tokyodark").setup(opts)
				vim.cmd [[colorscheme tokyodark]]
			end,
		},
	},
	install = { colorscheme = { "tokyodark" } },
	checker = { enabled = true },
})
