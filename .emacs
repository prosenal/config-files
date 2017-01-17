;;; Alex's .emacs file, 2016
;;; C-h ? for help
;;; C-h v to describe variable
;;; C-h f to describe function

(setq inhibit-splash-screen t)

(column-number-mode t)
(show-paren-mode t)


(if window-system (tool-bar-mode 0))

(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'flycheck)
(flycheck-add-mode 'javascript-standard 'js-mode)

;; c-mode
(setq-default c-default-style "user")
(add-hook 'c-mode-hook 'whitespace-mode)

;; c++-mode
(add-hook 'c++-mode-hook 'whitespace-mode)

;; js-mode
(setq-default js-indent-level 2)
(add-hook 'js-mode-hook 'flycheck-mode)
(add-hook 'js-mode-hook 'whitespace-mode)

;; python-mode
(add-hook 'python-mode-hook 'whitespace-mode)

;; irony mode
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
 

;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (sql-indent solarized-theme python-environment popup polymode haskell-mode git-commit flycheck epc diminish bind-key alect-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
