;;;;
;; Clojure
;;;;

;; Enable paredit for Clojure
;;(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'idle-highlight-mode)

;; don't show error popup in repl
(setq cider-show-error-buffer nil)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)


;; (define-key cider-repl-mode-map (kbd "<up>") 'cider-repl-previous-input)
;; (define-key cider-repl-mode-map (kbd "C-p") 'cider-repl-previous-input)
;; (define-key cider-repl-mode-map (kbd "<down>") 'cider-repl-next-input)
;; (define-key cider-repl-mode-map (kbd "C-n") 'cider-repl-next-input)
;; (define-key cider-repl-mode-map (kbd "C-l") 'cider-repl-clear-buffer)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))
