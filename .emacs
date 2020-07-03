;;; package --- Summary
;;; Commentary:
;;;   My .emacs file, 2020
;;;   C-h ? for help
;;;   C-h v to describe variable
;;;   C-h f to describe function
;;; Code:

;; Set a theme:
;; Do M-x customize-theme to see what's available
;; When downloading themese from MELPA, just dump the directory
;; contents into the custom-theme-load-path directory:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(menu-bar-mode -1)
;; takes 100ms
(scroll-bar-mode -1)
(column-number-mode t)
(electric-pair-mode t)

(setq visible-bell t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-splash-screen t)

;; Configure show parenthesis mode
(show-paren-mode t)
;;  2. Prevent parenthesis from being underlined:
(set-face-attribute 'show-paren-match nil :underline nil)
;; 3. Prevent the font from "jumping around" slightly:
(set-face-attribute 'show-paren-match nil :weight 'normal)

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

(set-frame-font "Inconsolata LGC 10")

;; Increase garbage collection threshold to 20MiB
(setq gc-cons-threshold 20971520)

;; Common package management configuration:
;; https://www.emacswiki.org/emacs/InstallingPackages
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; Package initialization is part of the common package management steps.
;; Without it, subsequent calls to `require' will fail for different packages
;; It is not well documented, but relevant pointers would include:
;; https://github.com/melpa/melpa#usage
;; https://github.com/emacs-helm/helm/issues/744
(package-initialize)

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

;; py-isort
(require 'py-isort)
;; Configure isort for Python
(add-hook 'before-save-hook 'py-isort-before-save)
;; Configure LSP for python
(add-hook 'python-mode-hook #'lsp)

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

;;; Separate Edit mode
;; https://github.com/twlz0ne/separedit.el#installation
(require 'separedit)
(define-key prog-mode-map (kbd "C-c C-e") #'separedit)
(setq separedit-default-mode 'markdown-mode) ;; or org-mode
