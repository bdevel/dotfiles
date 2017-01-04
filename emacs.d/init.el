(setq custom-file "~/.emacs.d/personal/custom.el")
(load custom-file 'noerror)

(load "~/.emacs.d/personal/defuns")

;; elpa managed
;; ------------------
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
       ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))

(package 'ace-jump-mode)
;; (package 'ag)
;; (package 'browse-kill-ring+)
;; (package 'bundler)

;; key bindings and code colorization for Clojure
;; https://github.com/clojure-emacs/clojure-mode
(package 'clojure-mode)

;; extra syntax highlighting for clojure
(package 'clojure-mode-extra-font-locking)

;; integration with a Clojure REPL
;; https://github.com/clojure-emacs/cider
(package 'cider)

(package 'csv-mode)
(package 'drag-stuff)
(package 'dropdown-list)
(package 'exec-path-from-shell)
(package 'expand-region)
;; (package 'feature-mode)

;; (package 'expand-region)
;; (package 'flx-isearch)
;(package 'haml-mode)
(package 'highlight-parentheses)
(package 'hydra)
;;(package 'ido-ubiquitous)
;; (package 'htmlize)
(package 'json-mode)
(package 'js2-mode)
;; (package 'lua-mode)
(package 'magit)
;; (package 'magit-gh-pulls)
(package 'markdown-mode)
;; (package 'maxframe)
;; (package 'motion-mode)
;;(package 'multiple-cursors)
;; (package 'powerline)
(package 'web-mode)

;; makes handling lisp expressions much, much easier
;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
;;(package 'paredit)

(package 'projectile)
(package 'projectile-rails)
;;(package 'sass-mode)
(package 'smex)
(package 'sos)
;; (package 'shell-pop)
;; (package 'toggle-quotes)
(package 'tabbar)

(package 'tagedit)
(package 'yaml-mode)
(package 'yasnippet)


;; self managed
;; ------------------
(personal 'theme);;make first as RYO looks for cursor color on setup
(personal 'bindings)
(personal 'cider)
(personal 'clojure)
(personal 'diff)
(personal 'dired)
(personal 'disabled)
(personal 'drag-stuff)
(personal 'elisp)
(personal 'expand-region)
(personal 'fonts)
(personal 'global)
(personal 'grep)
(personal 'highlight-parentheses)
(personal 'hippy-expand)
(personal 'hydra)
;(personal 'ido)
(personal 'idle-highlight)
(personal 'javascript)
(personal 'kbd-macros)
(personal 'mac)
(personal 'org)
(personal 'projectile)
(personal 'recentf)

;;(personal 'rectangle)
(personal 'ruby-mode)
(personal 'saveplace)
(personal 'scratch)
(personal 'server-mode)
(personal 'shell-mode)
(personal 'smex)
(personal 'tabs)
(personal 'utf-8)

;;(personal 'ryo)
;;(personal 'zoom) ; code folding


;; submodule managed
;; ------------------
(add-to-list 'load-path "~/.emacs.d/vendor/")

(vendor 'align)
(vendor 'revbufs       'revbufs)
;;(vendor 'ryo-modal)

;;(vendor 'electric-align 'electric-align-mode)
