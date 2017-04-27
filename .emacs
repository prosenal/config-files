;; Alex's .emacs file, 2016
;; C-h ? for help
;; C-h v to describe variable
;; C-h f to describe function

(add-to-list 'custom-theme-load-path
             "~/.emacs.d/elpa/atom-one-dark-theme-20170117.1905")

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
(add-hook 'c-mode-hook 'whitespace-mode)

;; c++-mode
;; (add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'whitespace-mode)

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
(add-hook 'web-mode-hook (lambda () (electric-pair-local-mode -1)))
