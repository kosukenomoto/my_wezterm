;;; init.el --- tidy minimal config -*- lexical-binding: t; -*-

;;; Early UI tweaks ----------------------------------------------------------
(setq inhibit-startup-screen t)
      
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode 1)
(column-number-mode 1)
(display-battery-mode 1)

(global-display-line-numbers-mode 1)

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

(global-set-key [f11] #'toggle-frame-fullscreen)

;;; Package system bootstrap -------------------------------------------------
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu". "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;;; Theme --------------------------------------------------------------------
(load-theme 'modus-vivendi t)   ; 高コントラストのダーク

;; Core UX packages ---------------------------------------------------------
(use-package which-key
  :defer nil
  :config
  (which-key-mode))

(use-package beacon
  :custom
  (beacon-color "yellow")
  :config
  (beacon-mode 1))

(setq wl-copy-process nil)
(defun wl-copy (text)
  (setq wl-copy-process (make-process :name "wl-copy"
                                      :buffer nil
                                      :command '("wl-copy" "-f" "-n")
                                      :connection-type 'pipe
                                      :noquery t))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))
(defun wl-paste ()
  (if (and wl-copy-process (process-live-p wl-copy-process))
      nil ; should return nil if we're the current paste owner
      (shell-command-to-string "wl-paste -n | tr -d \r")))
(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)

;; Completion stack ---------------------------------------------------------
(use-package vertico
  :init
  (vertico-mode)                          ; すでに有効なら省略可
  :config
  ;; ディレクトリ操作拡張
  (use-package vertico-directory          ; Vertico 同梱の拡張ファイル
    :ensure nil                           ; MELPA から別途取る必要なし
    :after vertico
    :bind (:map vertico-map
                ("DEL"   . vertico-directory-delete-char)  ; Backspac
                ("M-DEL" . vertico-directory-delete-word))) ; 単語/階層ごと
)

(use-package orderless
  :custom (completion-styles '(orderless)))

(use-package marginalia
  :after vertico
  :init (marginalia-mode))

(use-package consult
  :bind (("M-;" . consult-buffer)))

;; Recent files -------------------------------------------------------------
(use-package recentf
  :init
  (setq recentf-max-saved-items 200
        recentf-max-menu-items 200)
  (recentf-mode 1))

;; dirvish -------------------------------------------------------------------

(use-package vterm
  :ensure t
  :custom
  (vterm-max-scrollback 10000)
  (vterm-shell "/usr/bin/bash"))  ;; 好きなシェル

;;; Programming tools --------------------------------------------------------

;(dolist (element treesit-language-source-alist)
;  (let* ((lang (car element)))
;    (if (treesit-language-available-p lang)
;        (message "tree-sistter: %s is already installed" lang)
;      (message "tree-sitter: %s is not installed" lang)
;      (treesit-install-language-grammar lang))))
;
;(add-to-list 'major-mode-remap-alist '(c-mode   . c-ts-mode))
;(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))

;; Rust用Tree-sitterモードの設定
;; init.el に追記（インストール前でも後でも OK）

(setq treesit-language-source-alist
      '((rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.21.2")
	(c "https://github.com/tree-sitter/tree-sitter-c" "v0.21.4")))

;;rust-ts-mode
(use-package rust-ts-mode
  :ensure nil                        ;; Emacs組み込みのためパッケージをインストールしない
  :mode "\\.rs\\'"                   ;; 拡張子 .rs に対して rust-ts-mode を適用
  :hook (rust-ts-mode . (lambda ()
                          ;; 必要なら追加の設定をここに書けます
                          (message "rust-ts-mode activated")))
)
;; Rustファイル保存時に自動でフォーマット
(add-hook 'rust-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format nil t)))
;; eglot
(use-package eglot
  :hook ((c-mode c++-mode rust-ts-mode) . eglot-ensure)
  :config
  ;;c++
  (add-to-list 'eglot-server-programs 
               `(c++-mode . ("clangd" 
                             "--query-driver=/usr/bin/g++"
                             "--log=verbose")))
  ;;rust
  (add-to-list 'eglot-server-programs
	       `((rust-ts-mode rust-mode) . ("rust-analyzer"
					     :initializationOptions
					     (:check (:command "clippy"))))))

;; inlay-hint off
(setq eglot-ignored-server-capabilities '(:inlayHintProvider))

;;************************************************************************************
;;--query-driver=/usr/bin/g++を指定することで以下のような内容の .clangd ファイルを
;;projectフォルダの直下に置くことでg++によるinclude参照とeglotが稼働可能になる。
;;ちなみに、CMakeがclang++をコンパイラとしていても、CMakeのcompile-command.jsonの参照
;;には影響を与えず、それはそれで稼働する。
;;```.clangd```
;;CompileFlags:
;;  Add: [-isystem, /usr/include/c++/14, -isystem, /usr/include/c++/14/x86_64-linux-gnu, -isystem, /usr/include/c++/14/backward]
;;  Compiler: /usr/bin/g++
;;```
;;************************************************************************************** 

;;; Navigation & window management ------------------------------------------
(global-set-key (kbd "M-\= ") 'split-window-right) ;; 縦分割
(global-set-key (kbd "M-\- ") 'split-window-below) ;; 横分割
(windmove-default-keybindings 'control)
(dolist (pair '(("M-<left>"  . shrink-window-horizontally)
                ("M-<right>" . enlarge-window-horizontally)
                ("M-<up>"    . enlarge-window)
                ("M-<down>"  . shrink-window)))
  (keymap-set global-map (car pair) (cdr pair)))

(provide 'init)
