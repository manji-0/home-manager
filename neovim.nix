{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    neovim
    nvimpager
    pyright
    ruby
    terraform-ls
    tflint
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };

  home.sessionVariables = {
    PAGER = "nvimpager";
    MANPAGER = "nvimpager";
  };

  home.file.".config/nvim/init.lua".text = ''
    vim.opt.autoindent = true
    vim.opt.smartindent = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.splitright = true
    vim.opt.clipboard = "unnamedplus"
    vim.opt.hls = true

    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup("plugins")
  '';

  home.file.".config/nvim/lua/plugins/lazy.lua".text = ''
    return {
      {
        "folke/lazy.nvim",
        lazy = false,
        priority = 1000,
      }      
    }
  '';

  home.file.".config/nvim/lua/plugins/standards.lua".text = ''
    return {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = {
              "python",
              "go",
              "bash",
              "lua",
            },
            highlight = {
              enable = true,
            },
            indent = {
              enable = true,
            },
          })
        end,
      },
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          "williamboman/mason.nvim",
          "williamboman/mason-lspconfig.nvim",
        },
        config = function()
          require("mason").setup()
          require("mason-lspconfig").setup({
            ensure_installed = {
              "ruff",
              "lua_ls",
              "gopls",
              "marksman",
              "tflint",
              "terraformls",
              },
          })

          local lspconfig = require("lspconfig")

          lspconfig.pyright.setup({
            settings = {
              python = {
                venvPath = ".",
                pythonPath = ".venv/bin/python",
                analysis = {
                  typeCheckingMode = "basic",
                },
              },
            },
          })
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            }
          })
          lspconfig.gopls.setup({
            settings = {
              gopls = {
                analyses = {
                  unuseparams = true,
                  nilness = true,
                  shadow = true,
                },
                staticcheck = true,
              },
            },
          })
        end
      },
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          local telescope = require("telescope")
          telescope.setup({
            defaults = {
              mappings = {
                i = {
                  ["<C-j>"] = require("telescope.actions").move_selection_next,
                  ["<C-k>"] = require("telescope.actions").move_selection_previous,
                },
              },
            },
          })
        end,
      },
      {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("lualine").setup({
            options = {
	            icons_enabled = true,
              theme = "palenight",
    	        component_separators = { left = '', right = ''},
              section_separators = { left = '', right = ''},
	            always_divide_middle = true,
	            globalstatus = false,
            },
          })
        end,
      },
      {
        "github/copilot.vim",
      },
    }
  '';
}
