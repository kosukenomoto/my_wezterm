vim.cmd("autocmd!")
vim.scriptencoding="utf-8"
local options = {
  -- Make line numbers default
  number = true,
  -- ファイルのエンコーディングをUTF-8に設定
  encoding = "utf-8",
  -- ファイルを保存する際のエンコーディングをUTF-8に設定
  fileencoding = "utf-8",
  -- ターミナルのウィンドウタイトルを現在編集中のファイル名に設定
  title = true,
  -- 特殊文字を可視化
  list = true,
  -- 特殊文字の表示方法を定義
  listchars = { tab = '>>', trail = '-', nbsp = '+' },
  -- タブをスペースに展開
  expandtab = true,
  -- 自動インデント時のスペース数を2に設定
  shiftwidth = 2,
  -- タブの幅を2スペースに設定
  tabstop = 2,
  -- ファイルのバックアップを作成しない
  backup = false,
  -- システムのクリップボードとNeovimのクリップボードを共有
  clipboard = "unnamedplus",
  -- コマンドラインの高さを1行に設定
  cmdheight = 1,
  -- 検索した文字列をハイライト表示
  hlsearch = true,
  -- 検索において大文字と小文字を区別しない
  ignorecase = true,
  -- モード（INSERTなど）を表示
  showmode = true,
  -- 常にタブラインを表示
  showtabline = 2,
  -- 大文字が含まれている場合のみ、大文字と小文字を区別して検索
  smartcase = true,
  -- スマートインデントを有効に
  smartindent = true,
  -- スワップファイルを作成しない
  swapfile = false,
  -- アンドゥ情報をファイルに保存し、セッション間でアンドゥを可能に
  undofile = true,
  -- 書き込み中にバックアップファイルを作成しない
  writebackup = false,
  -- シェルとしてbashを使用
  shell = "bash",
  backupskip = { "/tmp/*", "/private/tmp/*" },
  -- カーソルのある行をハイライト表示
  cursorline = true,
  -- 行番号の表示幅を4に設定
  numberwidth = 4,
  -- サインカラム（エラーマーカーなどの表示領域）を常に表示
  signcolumn = "yes",
  -- 長い行を折り返さない
  wrap = false,
  -- ウィンドウの透過度を設定
  -- winblend = 10,
  -- 縦スクロールのオフセットを設定
  scrolloff = 8,
  -- 横スクロールのオフセットを設定
  sidescrolloff = 8,
  sessionoptions = { "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" },
  whichwrap = "b,s,h,l,[,],<,>"
}
for k, v in pairs(options) do
        vim.opt[k] = v
end

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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = false,
      priority = 1000,
      config = function()
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          integrations = {
            cmp = true,
            telescope = true,
            treesitter = true,
          }
        })
        vim.cmd.colorscheme("catppuccin")
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
})

