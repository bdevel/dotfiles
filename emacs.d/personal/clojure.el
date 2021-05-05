;;;
;; Clojure
;;;;


;; NOTE, read the docs for flycheck-joker
;;    Need to brew install joker
(require 'clojure-mode)
(require 'flycheck-joker)

;; Stop overriding { and } keys!
(defun clojure-paredit-setup ()
  )

;; Enable paredit for Clojure
(remove-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'electric-indent-mode)
(add-hook 'clojure-mode-hook 'electric-pair-mode)
(add-hook 'clojure-mode-hook 'idle-highlight-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)
(add-hook 'clojure-mode-hook 'flycheck-mode)
(add-hook 'clojure-mode-hook 'display-line-numbers-mode)

;;(require 'real-auto-save)
;;(add-hook 'clojure-mode-hook 'real-auto-save-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

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
            (define-clojure-indent (facts 1))

            ;; Adds a command to switch to core and run the (-main) fn
            (fset 'core-main-eval
                  [?\C-x ?b ?a ?h ?o ?i ?/ ?c ?o ?r ?e ?. ?c ?l ?j return ?\M-< ?\C-s ?\( ?- ?m ?a ?i ?n ?\C-e ?\C-x ?\C-e ?\C-x ?b return])

            ))



;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


(add-hook 'clojure-mode-hook 'show-paren-mode)
