;;; Configure UI (built-in)
;; Do *not* show the startup screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)

;; Do *not* create backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Do *not* beep at me
(setq visible-bell t)

;; Do *not* show menus
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Show column numbers in the modeline
(column-number-mode t)

;; Tweak the way parenthesis are displayed:
;; 1. Highlight parenthesis by default
(show-paren-mode t)
;; 2. Prevent parenthesis from being underlined:
(set-face-attribute
 'show-paren-match nil
 :underline nil)
;; 3. Prevent the font from "jumping around" slightly:
(set-face-attribute
 'show-paren-match nil
 :weight 'normal)

;; Automatically add a closing ), }, ], ", '.
(electric-pair-mode t)

;; Never indent with tabs
(setq-default indent-tabs-mode nil)
;; Use XX characters as the default width of a paragraph:
;; https://www.emacswiki.org/emacs/FillParagraph
;; http://johnlaudun.org/20080321-word-wrap-filling-in-emacs/
(setq-default fill-column 77)
;; When re-formatting a paragraph, do not put two spaces after the dot:
;; https://www.emacswiki.org/emacs/Sentences
(setq-default sentence-end-double-space nil)
;; By default, truncate long lines instead of wrapping them:
(setq-default truncate-lines t)

;; Choose fonts
(set-face-attribute
 'default nil
 :family "Fira Code Retina"
 :weight 'normal
 :slant 'normal
 :underline nil)
(set-face-attribute
 'bold-italic nil
 :family "Fira Code Retina"
 :weight 'bold
 :slant 'normal)

;; Increase garbage collection threshold:
(setq gc-cons-threshold 64 * 1024 * 1024)

;;; Configure package management
(require 'package)
;; Use both community-driven melpa and the built-in elpa package archives:
(setq package-archives
 '(("melpa" . "https://melpa.org/packages/")
   ("elpa" . "https://elpa.gnu.org/packages/")))
;; Load Emacs Lisp packages, and activate them
(package-initialize)
;; Ask package archives for packages if you don't know which are available:
(unless package-archive-contents
  (package-refresh-contents))
;; Use use-package instead of the built-in package mechanism to get packages:
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
;; If the target package is not installed, always download and install it:
(setq use-package-always-ensure t)

;;; Configure UI (theme)
;; (load-theme 'manoj-dark t nil)
(use-package
  darktooth-theme
  :config (load-theme 'darktooth t nil))
;; (use-package
;;   gruvbox-theme
;;   :config (load-theme 'gruvbox-dark-hard t nil))
;; (use-package
;;   zenburn-theme
;;   :config (load-theme 'zenburn t nil))
;; (use-package
;;   ample-theme
;;   :config (load-theme 'ample t nil))
;; (use-package kaolin-themes
;;   :config
;;   (load-theme 'kaolin-galaxy t nil))
;; (use-package
;;   cyberpunk-theme
;;   :config (load-theme 'cyberpunk t nil))
;; (use-package
;;   flatland-theme
;;   :config (load-theme 'flatland t nil))
;; (use-package
;;   inkpot-theme
;;   :config (load-theme 'inkpot t nil))
(use-package unobtrusive-magit-theme)

;;; Configure packages

;; Hide some of the minor modes from the modeline
(use-package diminish)

;; Copy and paste things from the clipboard, everywhere
(use-package xclip
  :config
  (xclip-mode 1))

;; Fuzzy-match for everything
(use-package helm
  :config
  (setq helm-split-window-default-side 'right)
  (set-face-attribute
   'helm-selection nil
   :family "Hack Nerd Font Mono"
   :weight 'normal
   :slant 'normal)
  :bind
  (("M-x" . helm-M-x)
   ("C-x b" . helm-mini)
   ("C-x C-f" . helm-find-files)))

(use-package rg
  :after helm)

;; Reason one to use emacs
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :config
  (setq magit-blame-echo-style 'headings))

;; Show available shortcuts
(use-package which-key
  :diminish which-key-mode
  :defer 1
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; Language Server Protocol
;; Here are some of the LSP servers that you should be installing:
;;  1. sudo npm -g install vscode-css-languageserver-bin
;;  2. sudo npm -g install vscode-html-languageserver-bin
;;  3. sudo npm -g install vscode-json-languageserver
;;  4. sudo npm -g install yaml-language-server
;;  5. sudo npm -g install typescript-language-server
;;  6. sudo npm -g install @angular/language-server
;;  7. sudo npm -g install @angular/language-service
;;  8. yay -Syu jedi-language-server
;;  9. yay -Syu deno
;; To enable a server for your mode, search for server-id here:
;; https://github.com/emacs-lsp/lsp-mode/tree/master/clients
;;
;; For example, lsp-javascript.el provides definitions for:
;;  1. ts-ls (typescript)
;;  2. deno-ls (typescript)
;; As well as that, lsp-angular.el provides angular-ls
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))
;; (use-package lsp-ui
;;   :commands (lsp-ui))
(use-package helm-lsp
  :commands (helm-lsp-workspace-buffer))

;; Company stands for "Complete Anything"
(use-package company
  :after lsp-mode
  :diminish company-mode
  :config
  (setq company-tooltip-align-annotations t)
  ;; :bind
  ;; (:map company-active-map
  ;;       ("<tab>" . company-complete-selection))
  ;; (:map lsp-mode-map
  ;; 	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package projectile :diminish
  :hook (projectile-mode . helm-mode)
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  (when (file-directory-p "~/Code")
    (setq projectile-project-search-path '("~/Code")))
  :config
  (projectile-mode)
  :custom
  ((projectile-completion-system 'helm))
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package yasnippet
  :after lsp-mode)

(use-package flycheck
  :after lsp-mode)

(use-package dockerfile-mode
  :mode ("Dockerfile\\'"))

(use-package cmake-mode
  :mode ("CMakeLists.txt\\'"))

(use-package python-mode
  :hook (python-mode . lsp-deferred)
  :mode "\\.py\\'")

;; (use-package pyenv-mode
;;  :after python-mode)

(use-package lsp-jedi
  :after (lsp-mode python-mode)
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package typescript-mode
  :hook (typescript-mode . lsp-deferred)
  :mode "\\.ts\\'"
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-enabled-clients 'deno-ls)
    (add-to-list 'lsp-enabled-clients 'angular-ls)))

(use-package web-mode
  :hook (web-mode . lsp-deferred)
  :mode ("\\.css\\'"  ;; Consider using plain CSS mode instead?
         "\\.erb\\'"
         "\\.html?\\'"
         ;; "\\.json\\'"
         "\\.djhtml\\'"
         "\\.mustache\\'")
  :config
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-closing t)
  ;; 0 is no auto-closing
  ;; 1 is auto-close after "</"
  ;; 2 is auto-close after ">" or "</"
  (setq web-mode-tag-auto-close-style 1)
  (setq web-mode-enable-current-column-highlight t)
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-enabled-clients 'html-ls)))

(use-package yaml-mode
  :hook (yaml-mode . lsp-deferred)
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))

(use-package json-mode
  :hook (json-mode . lsp-deferred)
  :mode ("\\.json\\'")
  :config
  (setq js-indent-level 2)
  (setq json-reformat:indent-width 2)
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-enabled-clients 'json-ls)))

(use-package rust-mode
  :hook
  (rust-mode . lsp-deferred)
  ;; See https://github.com/racer-rust/emacs-racer#installation
  (rust-mode . racer-mode)
  (rust-mode . hs-minor-mode)
  :mode "\\.rs\\'"
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-enabled-clients 'rls)))

(use-package kotlin-mode
  :hook (kotlin-mode . lsp-deferred)
  :mode "\\.kt\\'"
  :config
  (with-eval-after-load "lsp-mode"
    (setq lsp-clients-kotlin-server-executable "/home/alex/Code/fwcd/kotlin-language-server/server/build/install/server/bin/kotlin-language-server")
    (add-to-list 'lsp-enabled-clients 'kotlin-ls)))

(use-package antlr-mode
  :mode "\\.g4\\'")

(defun efs/display-startup-time ()
  (message "loaded in %s seconds with %d garbage collections"
	   (format "%.2f"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Use special modes for special files:
(add-to-list 'auto-mode-alist '(".zshrc.local" . shell-script-mode))

;; Decrease garbage collection threshold:
(setq gc-cons-threshold 2 * 1024 * 1024)

;; Tell emacs to put its custom things somewhere else:
(setq custom-file "~/.emacs-custom")
(load custom-file)

(load "~/.emacs.d/horst.el")
