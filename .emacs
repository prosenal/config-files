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
(set-face-attribute 'show-paren-match nil :underline nil)
;; 3. Prevent the font from "jumping around" slightly:
(set-face-attribute 'show-paren-match nil :weight 'normal)

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
(use-package
  cyberpunk-theme
  :config (load-theme 'cyberpunk t nil))

;;; Configure packages

;; Hide some of the minor modes from the modeline
(use-package diminish)

;; Copy and paste things from the clipboard, everywhere
(use-package xclip
  :config
  (xclip-mode 1))

;; Fuzzy-match for everything
(use-package helm
  :bind (("M-x" . helm-M-x)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)))

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

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

;; Use company mode (aka complete anything)
(use-package company
  :after lsp-mode
  :config
  (setq company-tooltip-align-annotations t)
  :diminish company-mode
  :hook (lsp-mode . company-mode)
  ;; :bind
  ;; (:map company-active-map
  ;;       ("<tab>" . company-complete-selection))
  ;; (:map lsp-mode-map
  ;; 	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; Use flycheck mode (aka complain about everything)
(use-package flycheck
  :after lsp-mode)

;; Typescript for Language Server Protocol
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

;; WebMode for better .html handling
(use-package web-mode
  :mode ("\\.css\\'"  ;; Consider using plain CSS mode instead?
         "\\.erb\\'"
         "\\.html?\\'"
         ;; "\\.json\\'"
         "\\.djhtml\\'"
         "\\.mustache\\'")
  :hook (web-mode . lsp-deferred)
  :config
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-enable-auto-closing t)
  ;; 0 is no auto-closing
  ;; 1 is auto-close after "</"
  ;; 2 is auto-close after ">" or "</"
  (setq web-mode-tag-auto-close-style 1)
  (setq web-mode-enable-current-column-highlight t))

(use-package dockerfile-mode
  :mode ("Dockerfile\\'"))

(use-package yaml-mode
  :mode ("\\.yml\\'"
         "\\.yaml\\'")
  :hook (yaml-mode . lsp-deferred))

(use-package json-mode
  :mode ("\\.json\\'")
  :hook (json-mode . lsp-deferred)
  :config
  (setq js-indent-level 2)
  (setq json-reformat:indent-width 2))

(defun efs/display-startup-time ()
  (message "loaded in %s seconds with %d garbage collections"
	   (format "%.2f"
		   (float-time
		    (time-subtract after-init-time before-init-time)))
	   gcs-done))
(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Decrease garbage collection threshold:
(setq gc-cons-threshold 2 * 1024 * 1024)

;; Tell emacs to put its custom things somewhere else:
(setq custom-file "~/.emacs-custom")
(load custom-file)
