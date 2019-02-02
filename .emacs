;; Alex's .emacs file, 2018
;; C-h ? for help
;; C-h v to describe variable
;; C-h f to describe function

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/afternoon-theme-20140104.1059")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/darkokai-theme-20160803.2058/")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-alt-theme-20170325.1430/")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-theme-20170314.1612/")

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-20180402.221")

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/atom-one-dark-theme-20180607.1638")

(load-theme 'atom-one-dark t)

(show-paren-mode t)
(scroll-bar-mode -1)
(column-number-mode t)
(electric-pair-mode t)

(setq visible-bell t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq inhibit-splash-screen t)

(if window-system (tool-bar-mode 0))

(setq-default indent-tabs-mode nil)

(set-default-font "Inconsolata LGC for Powerline 10")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; c-mode
(setq c-default-style "linux")
(setq-default c-basic-offset 4)
;; brackets at same indentation as the statements they open
(c-set-offset 'substatement-open '0)
;; (add-hook 'c-mode-hook 'whitespace-mode)

;; c++-mode
;; (add-hook 'c-mode-hook 'company-mode)
;; (add-hook 'c++-mode-hook 'whitespace-mode)

;; Configure indent in XML files to be 4 spaces
;; See: https://emacs.stackexchange.com/questions/24371/how-to-set-indent-to-4-spaces-in-nxml-mode
(setq nxml-child-indent 4 nxml-attribute-indent 4)

;; Configure markdown mode
(require 'use-package)
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; ;; python-mode
;; (add-hook 'python-mode-hook 'jedi:setup)

;; ;; auto-complete mode
;; (ac-config-default)
;; (add-to-list 'ac-modes 'c-mode)
;; (add-to-list 'ac-modes 'c++-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dockerfile-mode markdown-mode+ rust-mode systemd yaml-mode org matlab-mode json-mode jedi helm haskell-mode flycheck company atom-one-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
