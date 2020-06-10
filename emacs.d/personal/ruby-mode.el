;;; Ruby


;; Use Enhanced Ruby Mode instead
;;(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;;(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
;; (add-hook 'enh-ruby-mode-hook 'robe-mode)

;; must start robe with M-x robe-start (Can I add a hook for rails apps?)
;; (eval-after-load 'company
;;   '(push 'company-robe company-backends))


;; todo, after typing end, go prev line, indent.
;; (add-hook 'post-self-insert-hook 'complete-end)


;; make robe-start use rvm. Requires rvm package
(require 'rvm)
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; Run the current ruby buffer
(defun ruby-eval-buffer()
   "Evaluate the buffer with ruby."
   (interactive)
   (shell-command-on-region (point-min) (point-max) "ruby"))

(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

;; Local key bindings
(add-hook 'ruby-mode-hook
          (lambda ()
            ;; (ruby-electric-mode)
            (electric-indent-mode t)
            (local-set-key [(control c) (control e)] 'ruby-insert-end)
            (local-set-key [(control meta f1)] 'xmp) ;; gem install rcodetools
            (local-set-key [(control meta shift f1)] 'ruby-eval-buffer)
            ;;(local-set-key (kbd "TAB") 'smart-tab)
            (local-set-key (kbd "<return>") 'newline-and-indent)
            ))


;;(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("autotest$" . ruby-mode))
(add-to-list 'auto-mode-alist '("irbrc$" . ruby-mode))
(add-to-list 'auto-mode-alist '("sake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("god$" . ruby-mode))
(add-to-list 'auto-mode-alist '("thor$" . ruby-mode))
(add-to-list 'auto-mode-alist '("gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("builder$" . ruby-mode))
(add-to-list 'auto-mode-alist '("jbuilder$" . ruby-mode))

;; Better indention for multi-line paren blocks
(setq ruby-deep-indent-paren-style nil)

;; Until Emacs 24.4
;; http://stackoverflow.com/questions/7961533/emacs-ruby-method-parameter-indentation
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; https://github.com/zenspider/enhanced-ruby-mode/blob/master/enh-ruby-mode.el
;; https://www.emacswiki.org/emacs/EmacsSyntaxTable
(defvar enh-ruby-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\' "\"" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\` "\"" table)
    (modify-syntax-entry ?#  "<"  table)
    (modify-syntax-entry ?\n ">"  table)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?$  "."  table)
    (modify-syntax-entry ??  "_"  table)
    (modify-syntax-entry ?_  "_"  table)
    (modify-syntax-entry ?:  "."  table)
    (modify-syntax-entry ?<  "."  table)
    (modify-syntax-entry ?>  "."  table)
    (modify-syntax-entry ?&  "."  table)
    (modify-syntax-entry ?|  "."  table)
    (modify-syntax-entry ?%  "."  table)
    (modify-syntax-entry ?=  "."  table)
    (modify-syntax-entry ?/  "."  table)
    (modify-syntax-entry ?+  "."  table)
    (modify-syntax-entry ?*  "."  table)
    (modify-syntax-entry ?-  "."  table)
    (modify-syntax-entry ?\; "."  table)
    (modify-syntax-entry ?\( "()" table)
    (modify-syntax-entry ?\) ")(" table)
    (modify-syntax-entry ?\{ "(}" table)
    (modify-syntax-entry ?\} "){" table)
    (modify-syntax-entry ?\[ "(]" table)
    (modify-syntax-entry ?\] ")[" table)
    table)
  "Syntax table used by enh-ruby-mode buffers.")

(add-hook 'ruby-mode-hook (lambda ()
                            (set-syntax-table enh-ruby-mode-syntax-table)))



;; (defun er/mark-ruby-class ()
;;   "Marks "
;;   (when (looking-at "::")
;;     (forward-char 1))
;;   (when (er/looking-back-exact "::")
;;     (er/mark-symbol)
;;     (forward-char -2)))


;; (defun er/add-ruby-mode-expansions ()
;;   "Adds Ruby-specific expansions for buffers in ruby-mode"
;;   (set (make-local-variable 'er/try-expand-list)
;;        (remove 'er/mark-defun 
;;                (append
;;                 (default-value 'er/try-expand-list)
;;                 '(er/mark-ruby-instance-variable
;;                   er/mark-ruby-class
;;                   er/mark-ruby-block-up
;;                   er/mark-ruby-heredoc)))))
;; (er/enable-mode-expansions 'ruby-mode 'er/add-ruby-mode-expansions)

