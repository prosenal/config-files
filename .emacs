;;; package --- Summary
;;; Commentary:
;;;   My .emacs file, 2019
;;;   C-h ? for help
;;;   C-h v to describe variable
;;;   C-h f to describe function
;;; Code:

;; ;; Set a theme:
;;
;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/afternoon-theme-20140104.1059")
;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/darkokai-theme-20160803.2058/")
;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-alt-theme-20170325.1430/")
;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-theme-20170314.1612/")
;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-theme-20180402.221")


(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/atom-one-dark-theme-20190705.554")

(load-theme 'atom-one-dark t)


(scroll-bar-mode -1)
(column-number-mode t)
(electric-pair-mode t)

(setq visible-bell t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-splash-screen t)

;;; Configure show parenthesis mode
(show-paren-mode t)
;;; ;;;  2. Prevent parenthesis from being underlined:
;;; (set-face-attribute 'show-paren-match nil :underline nil)
;;; 3. Prevent the font from "jumping around" slightly:
(set-face-attribute 'show-paren-match nil :weight 'normal)

(when window-system (tool-bar-mode 0))

(setq-default indent-tabs-mode nil)

(set-frame-font "Inconsolata LGC for Powerline 10")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'use-package)

(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
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
;; racer (autocompletion for rust)
;; See https://github.com/racer-rust/emacs-racer#installation
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

;;; flycheck-mode
(require 'flycheck)
;;; Enable flycheck everywhere
;;; See https://www.flycheck.org/en/latest/user/quickstart.html#enable-flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; Configure flycheck for Rust
;;; See https://github.com/flycheck/flycheck-rust
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;;; company-mode (aka COMplete ANYthing mode)
(require 'company)
(setq company-tooltip-align-annotations nil)
;;; Configure company for Rust
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit racer flycheck-rust use-package rtags dockerfile-mode markdown-mode+ rust-mode systemd yaml-mode org matlab-mode json-mode jedi helm haskell-mode flycheck company atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
