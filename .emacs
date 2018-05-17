;; Alex's .emacs file, 2016
;; C-h ? for help
;; C-h v to describe variable
;; C-h f to describe function

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/atom-one-dark-theme-20170117.1905")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/afternoon-theme-20140104.1059")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/darkokai-theme-20160803.2058/")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-alt-theme-20170325.1430/")

;; (add-to-list 'custom-theme-load-path
;;              "~/.emacs.d/elpa/monokai-theme-20170314.1612/")

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-20171013.236")

(load-theme 'monokai t)

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

(set-default-font "Inconsolata LGC for Powerline 12")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

(yas-global-mode 1)

(require 'flycheck)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; suppress js2-mode check (workaround)
(setq js2-strict-missing-semi-warning nil)
;; use flycheck-mode (javascript-eslint by default) to check style
(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))
(add-hook 'json-mode-hook 'flycheck-mode)

;; c-mode
(setq c-default-style "linux")
(setq-default c-basic-offset 4)
(c-set-offset 'substatement-open '0) ;; brackets at same indentation as the statements they open
;; (add-hook 'c-mode-hook 'whitespace-mode)

;; c++-mode
;; (add-hook 'c-mode-hook 'company-mode)
;; (add-hook 'c++-mode-hook 'whitespace-mode)

;; python-mode
(add-hook 'python-mode-hook 'jedi:setup)

;; auto-complete mode
(ac-config-default)
(add-to-list 'ac-modes 'c-mode)
(add-to-list 'ac-modes 'c++-mode)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(add-to-list 'web-mode-engines-alist '("django" . "\\.html\\'"))
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-pairing t)

;; customize org-mode
(setq org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d!)" "SKIP(s!)")))
(setq org-habit-graph-column 100)

;; configure gradle-mode
(require 'gradle-mode)

(gradle-mode 1)

;; configure nxml mode
(require 'nxml-mode)

(setq-default nxml-child-indent 4)

;; Enable syntax highlighting for Dockerfiles
(add-to-list 'load-path "/your/path/to/dockerfile-mode/")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" default)))
 '(org-agenda-files (quote ("~/Dropbox/Documents/Orgzly/daylog.org")))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(org-support-shift-select nil)
 '(package-selected-packages
   (quote
    (dockerfile-mode docker-compose-mode typescript-mode gradle-mode auto-org-md yaml-mode haskell-mode darkokai-theme monokai-alt-theme monokai-theme afternoon-theme yasnippet web-mode json-mode js2-mode jedi helm flycheck company atom-one-dark-theme)))
 '(safe-local-variable-values (quote ((js2-basic-offset . 2)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
