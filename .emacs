;;; package --- Summary
;;; Commentary:
;;;   My .emacs file, 2020
;;;   C-h ? for help
;;;   C-h v to describe variable
;;;   C-h f to describe function
;;; If you're rusty on Emacs navigation, here is a refresher on bookmarks:
;;; https://emacs.stackexchange.com/a/3422/8889
;;; Code:

;; Set a theme:
;; Do M-x customize-theme to see what's available
;; When downloading themese from MELPA, just dump the directory
;; contents into the custom-theme-load-path directory:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;; Tweak common behaviors and UI elements
(menu-bar-mode -1)
;; takes 100ms
(scroll-bar-mode -1)
(column-number-mode t)
(electric-pair-mode t)

(setq visible-bell t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-splash-screen t)
;; (setq x-select-enable-primary nil)
;; (setq x-select-enable-clipboard t)

;;; Tweak the way parenthesis are displayed:
;; 1. Highlight parenthesis by default
(show-paren-mode t)
;; 2. Prevent parenthesis from being underlined:
(set-face-attribute 'show-paren-match nil :underline nil)
;; 3. Prevent the font from "jumping around" slightly:
(set-face-attribute 'show-paren-match nil :weight 'normal)

;; Removes the one-pixel borders around emacs window
(set-fringe-mode 0)
;; takes 50ms
(when window-system (tool-bar-mode 0))

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

(set-frame-font "Inconsolata LGC 10")

;; Increase garbage collection threshold to 20MiB
(setq gc-cons-threshold 20971520)

;;; Configure package management (this section is very common)
;; https://www.emacswiki.org/emacs/InstallingPackages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; Package initialization is part of the common package management steps.
;; Without it, subsequent calls to `require' will fail for different packages
;; It is not well documented, but relevant pointers would include:
;; https://github.com/melpa/melpa#usage
;; https://github.com/emacs-helm/helm/issues/744
(package-initialize)

;;; Configure helm
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x b") #'helm-mini)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; c-mode
(require 'cc-vars)
(setq c-default-style "linux")
(setq-default c-basic-offset 4)
;; brackets at same indentation as the statements they open
(c-set-offset 'substatement-open '0)
(add-hook 'c-mode-hook #'company-mode)
;; (add-hook 'c-mode-hook 'whitespace-mode)

;; c++-mode
(add-hook 'c++-mode-hook #'company-mode)

;; rust-mode
(require 'rust-mode)
;; racer (Rust Auto-Complete-ER)
;; See https://github.com/racer-rust/emacs-racer#installation
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'lsp)
(setq rust-format-on-save t)
;; Configure company for Rust
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)

;;; Configure Python
(require 'py-isort)
;; Configure LSP for Python
(add-hook 'python-mode-hook #'lsp)
;; Configure isort for Python
(add-hook 'before-save-hook 'py-isort-before-save)
(global-set-key (kbd "C-c b") #'python-black-region)

;;; Configure separedit
;; https://github.com/twlz0ne/separedit.el#installation
(require 'separedit)
(define-key prog-mode-map (kbd "C-c C-e") #'separedit)
(setq separedit-default-mode 'markdown-mode) ;; or org-mode

;;; Configure magit
(require 'magit)
;; See https://magit.vc/manual/magit/Getting-Started.html#Getting-Started
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)

;;; flycheck-mode
(require 'flycheck)
;;; Enable flycheck everywhere, see:
;;; https://www.flycheck.org/en/latest/user/quickstart.html#enable-flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; Configure flycheck for Rust
;;; See https://github.com/flycheck/flycheck-rust
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;;; company-mode (COMplete ANYthing mode)
(require 'company)
(setq company-tooltip-align-annotations nil)

;;; Language Server Protocol mode
(require 'lsp-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
