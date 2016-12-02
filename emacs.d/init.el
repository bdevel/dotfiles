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
;; (package 'coffee-mode)
(package 'csv-mode)
;; (package 'dired-details+)
(package 'dropdown-list)
;; (package 'expand-region)
(package 'exec-path-from-shell)
;; (package 'feature-mode)
;; (package 'flx-ido)
;; (package 'flx-isearch)
;; (package 'haml-mode)
(package 'highlight-parentheses)
;; (package 'htmlize)
(package 'json-mode)
(package 'js2-mode)
;; (package 'lua-mode)
;; (package 'magit)
;; (package 'magit-gh-pulls)
(package 'markdown-mode)
;; (package 'maxframe)
;; (package 'motion-mode)
(package 'multiple-cursors)
;; (package 'powerline)
(package 'projectile)
(package 'projectile-rails)
(package 'sass-mode)
;; (package 'shell-pop)
;; (package 'toggle-quotes)
;; (package 'textile-mode)
(package 'yaml-mode)
(package 'yasnippet)


;; self managed
;; ------------------

(personal 'bindings)
;(personal 'c)
(personal 'diff)
(personal 'dired)
(personal 'disabled)
;;(personal 'flymake)
(personal 'fonts)
(personal 'global)
(personal 'grep)
(personal 'highlight-parentheses)
(personal 'javascript)
(personal 'kbd-macros)
(personal 'mac)
(personal 'org)
;;(personal 'private)
(personal 'recentf)
;;(personal 'rectangle)
(personal 'ruby-mode)
(personal 'saveplace)
(personal 'scratch)
(personal 'server-mode)
(personal 'shell-mode)
(personal 'tabs)
(personal 'theme)
(personal 'utf-8)
;;(personal 'zoom) ; code folding


;; submodule managed
;; ------------------
(add-to-list 'load-path "~/.emacs.d/vendor/")

;;(vendor 'filladapt)
(vendor 'revbufs       'revbufs)
(vendor 'electric-align 'electric-align-mode)
