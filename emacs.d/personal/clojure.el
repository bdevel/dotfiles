;;;;
;; Clojure
;;;;


(require 'clojure-mode)

;; Stop overriding { and } keys!
(defun clojure-paredit-setup ()
  )

;; Enable paredit for Clojure
;;(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(remove-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'electric-indent-mode)
(add-hook 'clojure-mode-hook 'idle-highlight-mode)

;; don't show error popup in repl
(setq cider-show-error-buffer nil)

;; A little more syntax highlighting
;;(require 'clojure-mode-extra-font-locking)

(setq clojure-align-forms-automatically t)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (customize-set-variable 'clojure-indent-style :align-arguments)
            (customize-set-variable 'clojure-align-forms-automatically t)
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))



;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


(add-hook 'clojure-mode-hook 'show-paren-mode)
