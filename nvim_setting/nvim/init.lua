--
-- WorkFlow
-- Oil close:C-c 起動:Spc->o (開いてるファイルをカレントに）
-- Telescope
-- Telescope session-lens close:C-c 起動:Spc->fs
-- toggleterm close:exit 起動:tt (開いてるファイルをカレントに）
--
vim.cmd("autocmd!")
vim.scriptencoding = "utf-8"
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
  listchars = { tab = ">>", trail = "-", nbsp = "+" },
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
  -- 常にタブラインを非表示
  showtabline = 0,
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
  --cursorline = true,
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
  whichwrap = "b,s,h,l,[,],<,>",
  -- statusLineのアクティブ／非アクティブのfiller文字
  fillchars = { stl = "─", stlnc = "─" },
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.o.statusline = "%!v:lua.ModeShort()"

-- window height control function
local term_ratios = { 0.1, 0.5, 0.8, 0.95 } -- 全体に対する割合
local current_index = 1

local function cycle_term_height(force)
  local ui = vim.api.nvim_list_uis()[1]
  if not ui then return end

  local ratio
  if force ~= nil then
    -- 引数が指定された場合は最大値を使用
    ratio = math.max(unpack(term_ratios))
  else
    -- これまで通りサイクル
    current_index = current_index % #term_ratios + 1
    ratio = term_ratios[current_index]
  end

  local new_height = math.floor(ui.height * ratio)
  local win = vim.api.nvim_get_current_win()

  -- 1) 目的の高さにする
  vim.cmd("resize " .. new_height)

  -- 2) このウィンドウの高さを固定してから equalize
  vim.api.nvim_win_set_option(win, "winfixheight", true)
  vim.cmd("wincmd =")
  vim.api.nvim_win_set_option(win, "winfixheight", false)

  vim.notify(string.format("Terminal height: %d (%d%%)", new_height, term_ratios[current_index] * 100))
end

-- ── helper: そのバッファに紐づく LSP の root_dir を取得（最初の1つ）
local function lsp_root_dir(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if not clients or #clients == 0 then
    return nil
  end
  return clients[1].root_dir
      or (clients[1].config and clients[1].config.root_dir)
      or (
        clients[1].workspace_folders
        and clients[1].workspace_folders[1]
        and vim.uri_to_fname(clients[1].workspace_folders[1].uri)
      )
end

-- ── helper: root を基準に相対パスを作る（なければ nil）
local function relpath_from_root(abs_path, root)
  if not root or root == "" then
    return nil
  end
  -- Neovim 0.11 には vim.fs.relpath あり
  local ok, rel = pcall(vim.fs.relpath, abs_path, root)
  if ok and rel and rel ~= "" then
    return rel
  end
  -- 安全フォールバック：前方一致で手作業
  local norm_root = root:gsub("[/\\]+$", "")
  if abs_path:sub(1, #norm_root) == norm_root then
    local sep = abs_path:sub(#norm_root + 1, #norm_root + 1)
    local off = (sep == "/" or sep == "\\") and 2 or 1
    return abs_path:sub(#norm_root + off)
  end
  return nil
end

-- ── lualine 用カスタムコンポーネント
local function project_plus_path()
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  if file == "" then
    return ""
  end

  local root = lsp_root_dir(buf)
  if root and root ~= "" then
    local proj = vim.fs.basename(root)                -- Project名 = root のディレクトリ名
    local rel = relpath_from_root(file, root) or file -- 相対にできなければフルパス
    -- 形式: [Project名](プロジェクトルート名)+ 相対パス
    return string.format("[%s] %s", proj, rel)
  end

  -- LSPが無い場合はフルパス
  return file
end

-- タイムスタンプ付きのユニークセッション保存
local function timestamped_session_name()
  -- auto-session のデフォルト：カレントディレクトリ名
  local cwd = vim.fn.getcwd()
  local name = vim.fn.fnamemodify(cwd, ":t")

  -- タイムスタンプ [YYYYMMDD_HHmm]
  local stamp = os.date("[%Y%m%d_%H%M]")

  return string.format("%s_%s", name, stamp)
end

vim.api.nvim_create_user_command("SessionSaveTS", function()
  local name = timestamped_session_name()
  vim.cmd("SessionSave " .. name)
  print("Session saved as " .. name)
end, { desc = "Save session with timestamp" })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--  Oil->Terminal
local opts = { noremap = true, silent = true }
--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- ESC二回押しでハイライトを消す
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)
-- jjでesc
keymap("i", "jj", "<ESC>", opts)

vim.keymap.set("n", "<leader>c", "zz", { desc = "カーソル行を中央へ" })
vim.keymap.set("n", "n", "nzz", { desc = "カーソル行を中央へ" })
vim.keymap.set("n", "N", "Nzz", { desc = "カーソル行を中央へ" })

vim.keymap.set("n", "<leader>q", "<Cmd>qa!<CR>", { desc = "Quit all without saving" })
keymap("n", "<leader>w", ":w<cr>", opts)
--keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", opts)
keymap("n", "<leader>o", "<cmd>Oil<cr>", opts)


vim.keymap.set("n", "sd", "<cmd>Telescope oldfiles<cr>", opts)
vim.keymap.set("n", "sf", function()
  -- 現在 oil バッファかどうか判定
  local dir = vim.bo.filetype == "oil"
      and require("oil").get_current_dir() -- oil ならそのディレクトリ
      or vim.fn.expand("%:p:h")            -- 通常バッファならそのファイルのディレクトリ

  require("telescope.builtin").find_files({ cwd = dir })
end, { desc = "Find files in Oil directory" })

-- terminal
vim.keymap.set("n", "st", function()
  local oil = require("oil")
  local dir

  -- 今開いているバッファが oil の場合はそのディレクトリ
  if vim.bo.filetype == "oil" then
    dir = oil.get_current_dir()
  else
    -- それ以外は今開いてるファイルのディレクトリ
    dir = vim.fn.expand("%:p:h")
  end

  -- dir が nil でないことを確認してから実行
  if dir then
    vim.cmd("ToggleTerm dir=" .. dir)
  end
end, { desc = "Open ToggleTerm in current Oil dir" })

-- 常に「新規」ターミナルを、その時点のディレクトリで開く
vim.keymap.set({ "n" }, "<leader>th", function()
  -- dir を決める（OilならOilのdir／それ以外は開いてるファイルのdir、なければCWD）
  local dir
  local ok, oil = pcall(require, "oil")
  if ok and vim.bo.filetype == "oil" then
    dir = oil.get_current_dir()
    if dir and dir:sub(-1) == "/" then dir = dir:sub(1, -2) end -- 末尾スラッシュ除去（任意）
  else
    dir = vim.fn.expand("%:p:h")
    if dir == "" then dir = vim.loop.cwd() end
  end
  if not dir or dir == "" then
    vim.notify("directory not found", vim.log.levels.WARN)
    return
  end

  -- ここがポイント：毎回 new() で“新しい”ターミナルを作る
  require("toggleterm.terminal").Terminal:new({
    dir = dir,
    direction = "horizontal", -- "vertical" / "float" / "tab" に好みで変更
    -- size = math.floor(vim.o.lines * 0.3),  -- 横分割時の高さを調整したい場合
  }):toggle()

  -- 並べたときに見やすくする（任意）
  vim.cmd("wincmd J")
  vim.cmd("wincmd =")
end, { desc = "Open NEW ToggleTerm in Oil/current file dir" })

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)
keymap("n", "so", "<C-w>o", opts)
keymap("n", "sw", "<C-w>c", opts)
keymap("n", "sc", ":bd<CR>", opts)
keymap("n", "sa", "<cmd>SessionSaveTS<cr>", opts)
keymap("n", "sb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "sl", "<cmd>Telescope session-lens<cr>", opts)

-- terminal esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
-- pain size
vim.keymap.set({ "n", "i", "t" }, "<C-w><C-w>", cycle_term_height, opts)
vim.keymap.set({ "n", "i", "t" }, "<C-w>w", function() cycle_term_height("max") end, opts)
vim.keymap.set({ "n", "i", "t" }, "<C-w>e", "<C-w>=", opts)
-- pain move
vim.keymap.set({ "n", "i", "t" }, "<C-down>", "<CMD>wincmd j<CR>", opts)
vim.keymap.set({ "n", "i", "t" }, "<C-left>", "<CMD>wincmd h<CR>", opts)
vim.keymap.set({ "n", "i", "t" }, "<C-up>", "<CMD>wincmd k<CR>", opts)
vim.keymap.set({ "n", "i", "t" }, "<C-right>", "<CMD>wincmd l<CR>", opts)
--  See `:help lua-guide-autocommands`
-- arrow move
--Terminal利用時の設定

local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "startinsert",
})
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "setlocal nonumber",
})
autocmd({ "TermOpen" }, {
  pattern = "*",
  command = "setlocal norelativenumber",
})
-- init.lua あるいは lua/config ファイルなどに追記
-- フォーカスが当たったウィンドウで cursorline を有効化
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  callback = function()
    vim.wo.cursorline = true
  end,
})

-- フォーカスが外れたウィンドウで cursorline を無効化
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    vim.wo.cursorline = false
  end,
})

local mode_map = {
  ["n"] = "N",
  ["no"] = "O·P",
  ["nov"] = "O·P",
  ["noV"] = "O·P",
  ["no\22"] = "O·P",
  ["niI"] = "N·I",
  ["niR"] = "N·R",
  ["niV"] = "N",
  ["nt"] = "N·T",
  ["v"] = "V",
  ["vs"] = "V",
  ["V"] = "V·L",
  ["Vs"] = "V·L",
  ["\22"] = "V·B",
  ["\22s"] = "V·B",
  ["s"] = "S",
  ["S"] = "S·L",
  ["\19"] = "S·B",
  ["i"] = "I",
  ["ic"] = "I·C",
  ["ix"] = "I·X",
  ["R"] = "R",
  ["Rc"] = "R·C",
  ["Rx"] = "R·X",
  ["Rv"] = "V·R",
  ["Rvc"] = "RVC",
  ["Rvx"] = "RVX",
  ["c"] = "C",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "R",
  ["rm"] = "M",
  ["r?"] = "C",
  ["!"] = "SH",
  ["t"] = "T",
}

local function modes()
  return mode_map[vim.api.nvim_get_mode().mode] or "__"
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        style = "night",
        on_colors = function(colors)
          colors.bg = "#030303"
          colors.bg_float = "#030303"
          colors.bg_sidebar = "#030303"
          colors.bg_statusline = "#030303"
        end,
      },
      config = function(_, opts)
        require("tokyonight").setup(opts)
        vim.cmd([[colorscheme tokyonight]])
      end,
    },
    {
      'tadaa/vimade',
      event = 'VeryLazy',
      opts = {
        recipe = { 'duo', { animate = true } }, -- ←好みで 'default' でもOK
        ncmode = 'windows',                     -- 非アクティブ window を対象
        fadelevel = 1.0,                        -- ほんの少し暗く（数値↑ほど暗くならない）
        tint = {
          fg = { desaturate = 0.5, intensity = 0.15 },
          bg = {},
        },
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme                = "moonfly",
            -- component_separators = { left = '  ', right = '  ' },
            component_separators = { left = '│', right = '│' }, -- コンポーネント間
            section_separators   = { left = '', right = '' }, -- セクション間は無し
          },
          -- inactive_winbar = {
          --   lualine_a = { {'mode'}},
          --   lualine_b = {'branch', 'diff', 'diagnostics'},
          --   lualine_c = { {'filename', path = 3 }},
          --   lualine_x = {'encoding', 'fileformat', 'filetype'},
          --   lualine_y = {'progress'},
          --   lualine_z = {'location'}
          -- },
          -- winbar = {
          --   lualine_a = { {'mode'}},
          --   lualine_b = {'branch', 'diff', 'diagnostics'},
          --   lualine_c = { {'filename', path = 3 }},
          --   lualine_x = {'encoding', 'fileformat', 'filetype'},
          --   lualine_y = {'progress'},
          --   lualine_z = {'location'}
          -- },
          winbar = {},
          sections = {
            lualine_a = { { modes } },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { project_plus_path },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          inactive_sections = {
            lualine_a = { { color = { fg = "#FF0000", bg = "None" } } },
            lualine_b = { { color = { fg = "#FF0000", bg = "None" } } },
            lualine_c = { project_plus_path },
            lualine_x = { { color = { fg = "#FF0000", bg = "None" } } },
            lualine_y = { { color = { fg = "#FF0000", bg = "None" } } },
            lualine_z = { { color = { fg = "#FF0000", bg = "None" } } },
          },
        })
      end,
    },
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = true,
      opts = {
        direction = "horizontal",
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local telescope = require("telescope")

        telescope.setup({
          -- 必要ならここで設定
        })

        -- fzf-native をロード
        telescope.load_extension("fzf")
      end,
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require("harpoon")

        -- 基本セットアップ
        harpoon:setup({})

        -- ファイルを Harpoon に追加
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
          { desc = "Harpoon add file" })

        -- Harpoon メニューを開く (Telescope 風)
        vim.keymap.set("n", "<leader>h", function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon quick menu" })

        -- 登録済みファイルへジャンプ
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
      end,
    },
    {
      "folke/flash.nvim",
      opts = {
        modes = {
          char = {
            jump_labels = true,
          },
        },
      },
    },
    {
      "rmagatti/auto-session",
      opts = {},
      config = function()
        require("auto-session").setup({
          auto_save = false,
          auto_restore = false,
          pre_save_cmds = {
            -- "tabdo neotree close" -- close nerdtree before saving session
          },
          pre_restore_cmds = {
            -- "tabdo neotree close" -- close nerdtree before saving session
          },
        })
        -- 常に Normal モードで開始する
        local aug = vim.api.nvim_create_augroup("force_normal_start", { clear = true })

        -- 起動直後に Normal に戻す
        vim.api.nvim_create_autocmd("VimEnter", {
          group = aug,
          callback = function()
            vim.schedule(function()
              if vim.fn.mode() ~= "n" then vim.cmd("stopinsert") end
            end)
          end,
        })
      end,
    },
    {
      "stevearc/oil.nvim",
      ---@module 'oil'
      ---@type oil.setupopts
      opts = {
        default_file_explorer = true,
        watch_for_changes = true,
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
        preview = {
          split_direction = "right",
        },
      },
      -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      opts = {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        source_selector = {
          winbar = true,
          statusline = false,
        },
        filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
          },
          bind_to_cwd = true,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        sources = {
          "filesystem",
          "buffers",
          "git_status",
        },
        window = {
          position = "float",
          mappings = {
            ["<C-c>"] = "close_window",
          },
        },
      },
    },
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    },
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
    -- {
    --   "saghen/blink.cmp",
    --   version = "*", -- バイナリをダウンロードする場合
    --   opts = {
    --     -- 次の項目で紹介
    --   },
    -- },
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      opts = {
        indent = { char = "│" }, -- ガイドの記号
        scope = { enabled = true }, -- 現在スコープを強調
        exclude = { -- 不要なバッファは除外
          filetypes = { "help", "alpha", "dashboard", "neo-tree", "oil", "lazy", "mason", "Trouble" },
          buftypes  = { "terminal", "nofile" },
        },
      },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "rust_analyzer" },
      },
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
})

-- nvim-lspconfigプラグイン読込後に実行される設定
local on_attach = function(client, bufnr)
  -- LSP有効時のみのキーマップを設定（bufferローカル）
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)           -- カーソル下のシンボル情報をホバー表示
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)     -- 定義へジャンプ (Go to definition)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)     -- 参照の一覧を表示 (Find references)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- 実装箇所へジャンプ (Go to implementation)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts) -- シンボル名のリネーム (Rename)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)   -- 前の診断メッセージへ
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)   -- 次の診断メッセージへ
  -- ※<Leader>は通常「\\」キーに割り当てられています。必要に応じて読み替えてください。
  if client.server_capabilities.documentFormattingProvider then
    local grp = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
      end,
    })
  end
end

-- Rust AnalyzerのLSPクライアント設定を有効化
vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  -- on_attach = function(client, bufnr)
  --   if on_attach then
  --     on_attach(client, bufnr)
  --   end
  -- end,
  settings = {
    ["rust-analyzer"] = {
      -- Rust Analyzerの各種設定（必要に応じて追記可能）。空のテーブル{}でデフォルト設定を使用します:contentReference[oaicite:5]{index=5}。
    },
  },
})

vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  -- on_attach = function(client, bufnr)
  --   if on_attach then
  --     on_attach(client, bufnr)
  --   end
  -- end,
  settings = { Lua = { diagnostics = { globals = { "vim" } } } }
})
