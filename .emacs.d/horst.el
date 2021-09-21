(message "here is your horst.el")

(defvar horst-mode-hook nil)
(add-to-list 'auto-mode-alist '("\\.horst\\'" . horst-mode))

(defconst horst-font-lock-keywords-0
  (list
   '("\\<clause\\>" . font-lock-builtin-face)
   '("\\<const\\>" . font-lock-builtin-face)
   '("\\<datatype\\>" . font-lock-builtin-face)
   '("\\<expect\\>" . font-lock-builtin-face)
   '("\\<for\\>" . font-lock-builtin-face)
   '("\\<in\\(\\|it\\)\\>" . font-lock-builtin-face)
   '("\\<match\\>" . font-lock-builtin-face)
   '("\\<mod\\>" . font-lock-builtin-face)
   '("\\<op\\>" . font-lock-builtin-face)
   '("\\<pred\\>" . font-lock-builtin-face)
   '("\\<query\\>" . font-lock-builtin-face)
   '("\\<rule\\>" . font-lock-builtin-face)
   '("\\<sel\\(\\|ect\\)\\>" . font-lock-builtin-face)
   '("\\<store\\>" . font-lock-builtin-face)
   '("\\<test\\>" . font-lock-builtin-face)
   '("\\<with\\>" . font-lock-builtin-face))
  "Highlight HoRST keywords")
(defconst horst-font-lock-keywords-1
  (append horst-font-lock-keywords-0
          (list
           '("op \\([^()]+?\\)(" . (1 font-lock-function-name-face))
           '("pred \\([^{]+?\\){" . (1 font-lock-function-name-face))
           '("rule \\([^:]+?\\):" . (1 font-lock-function-name-face))
           '("sel \\([^:]+?\\):" . (1 font-lock-function-name-face))))
  "Highlight HoRST function-like objects")
(defconst horst-font-lock-keywords-2
  (append horst-font-lock-keywords-1
          (list
           '("\\<array\\>" . font-lock-preprocessor-face)
           '("\\<bool\\>" . font-lock-type-face)
           '("\\<int\\>" . font-lock-type-face)
           '("\\<unit\\>" . font-lock-type-face)))
  "Minimal highlighting expressions for HoRST type-likes")
(defconst horst-font-lock-keywords-3
  (append horst-font-lock-keywords-2
          (list
           '("?[a-zA-Z0-9]+" . font-lock-variable-name-face)
           '("![a-zA-Z0-9]+" . font-lock-constant-face)))
  "Minimal highlighting expressions for HoRST free & bound variables")
(defvar horst-font-lock-keywords horst-font-lock-keywords-3
  "Default highlighting expressions for HoRST mode")

(defvar horst-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for HoRST mode")

(defun horst-mode ()
  "Major mode for editing HoRST specifications"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table horst-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(horst-font-lock-keywords))
  (setq major-mode 'horst-mode)
  (setq mode-name "HoRST")
  (run-hooks 'horst-mode-hook))

(provide 'horst-most)
