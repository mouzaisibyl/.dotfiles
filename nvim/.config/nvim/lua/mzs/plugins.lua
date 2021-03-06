local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("that did't work")
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}











-- Install your plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use 'wakatime/vim-wakatime'
    use 'bronson/vim-trailing-whitespace'

    -- colorscheme
    use 'folke/tokyonight.nvim'
    use 'morhetz/gruvbox'
    use 'luisiacc/gruvbox-baby'
    use 'liuchengxu/space-vim-theme'

    --use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
    --use 'honza/vim-snippets'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate"
    }
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    -- use {'vim-airline/vim-airline'}
    -- use {'vim-airline/vim-airline-themes'}
    use {'neomake/neomake'}
    use {'mbbill/undotree'}
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Git
    use {'tpope/vim-fugitive'}
    use {'airblade/vim-gitgutter'}
    use {'junegunn/gv.vim'}
    -- Vim's diff mode is pretty good, but there is no convenient
    -- way to quickly bring up all modified files in a diffsplit.
    -- This plugin aims to provide a simple, unified, single tabpage
    -- interface that lets you easily review all changed files for any git rev.
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- Nerdtree
    -- use {'preservim/nerdtree'}
    -- use {'jistr/vim-nerdtree-tabs'}
    -- use {'Xuyuanp/nerdtree-git-plugin'} -- A plugin of NERDTree showing git status flags.
    -- use {'tiagofumo/vim-nerdtree-syntax-highlight'} --add highlight
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Move
    use {'easymotion/vim-easymotion'}


    -- Format
    use {'psf/black'}
    use {
        'prettier/vim-prettier',
        run = 'yarn install --frozen-lockfile --production',
        ft = {'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'}
    }

    use { 'Yggdroot/indentLine' }
    --use { 'ap/vim-css-color' } -- show css color will have error when open .java with treesitter
    use { 'mattn/emmet-vim' }
    use { 'othree/xml.vim' }

    -- tags
    use { 'ludovicchabant/vim-gutentags' } -- build ctags auto and silent
    use { 'liuchengxu/vista.vim' } -- replace tagbar which could support LSP

    -- fzf
    use { 'Yggdroot/LeaderF', run = ':LeaderfInstallCExtension' }
    use { 'tamago324/LeaderF-filer' }
    use { 'Yggdroot/LeaderF-marks' }

    -- UI
    use { 'kshenoy/vim-signature' } -- vim marks
    --use { 'mhinz/vim-startify' } -- vim look
    use { 'ryanoasis/vim-devicons' } -- icons for them
    use { 'glepnir/dashboard-nvim' } -- dashboard

    -- code
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {}
        end
    }
    use {'numToStr/Comment.nvim'}

    -- diagnostics
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- cmp plugins
    use {"hrsh7th/nvim-cmp"} -- The completion plugin
    use {"hrsh7th/cmp-buffer"} -- buffer completions
    use {"hrsh7th/cmp-path"} -- path completions
    use {"hrsh7th/cmp-cmdline"} -- cmdline completions
    use {"saadparwaiz1/cmp_luasnip"} -- snippet co  -- snippets
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"L3MON4D3/LuaSnip"} --snippet engine
    use {"rafamadriz/friendly-snippets"} -- a bunch of snippets to usempletions

    -- LSP
    use {"neovim/nvim-lspconfig"} -- enable LSP
    use {"williamboman/nvim-lsp-installer"} -- simple to use language server installer
    use {
        'rmagatti/goto-preview'
    }

    -- Virtual Text
    use {'kevinhwang91/nvim-hlslens'} -- helps you better glance at matched information
    use {"APZelos/blamer.nvim"} -- show git blame

    -- startup time
    use {'dstein64/vim-startuptime'} -- A Vim plugin for profiling Vim's startup
    use {'lewis6991/impatient.nvim'} -- Speed up loading Lua modules in Neovim to improve startup time.
























    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
