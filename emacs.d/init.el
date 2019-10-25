(defmacro comment (&rest body)
  "Comment out one or more s-expressions."
  nil)
;; submodule managed
;; ------------------

(setq custom-file "~/.emacs.d/personal/custom.el")
(load custom-file)

(add-to-list 'load-path "/Users/tyler/.emacs.d/vendor")

(load "~/.emacs.d/personal/defuns")



;; ------------------
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/")
        )
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 0)
	))

(package-initialize)
;;(package-refresh-contents)
(when (not package-archive-contents) (package-refresh-contents))
(load "~/.emacs.d/vendor/init-use-package")


(personal 'theme);; might need to be called ahead of some packages like RYO

;;(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;;(package-initialize)


;;(package 'auto-complete)
;;(package 'ac-cider)

;;(package 'ace-jump-mode)
;; (package 'ag)
;; (package 'browse-kill-ring+)
;; (package 'bundler)
(package 'aggressive-indent)

;; key bindings and code colorization for Clojure
;; https://github.com/clojure-emacs/clojure-mode
(package 'clojure-mode)

;; extra syntax highlighting for clojure
(package 'clojure-mode-extra-font-locking)

;; integration with a Clojure REPL
;; https://github.com/clojure-emacs/cider
(package 'cider)
(package 'flycheck-joker)


;;(package 'company) ;; completion
(package 'drag-stuff)
(package 'dockerfile-mode)
;;(package 'dropdown-list)
(package 'exec-path-from-shell)
(package 'expand-region)
(package 'fiplr)

(package 'expand-region)
;; (package 'flx-isearch)
(package 'haml-mode)
(package 'highlight-parentheses)
(package 'helm)
(package 'helm-swoop)
(package 'helm-git-grep)
(package 'hydra)
;;(package 'ido-ubiquitous)
;; (package 'htmlize)
(package 'neotree)
(package 'json-mode) 
(package 'js2-mode)
(package 'jsx-mode)
(package 'magit)
;; (package 'magit-gh-pulls)
(package 'markdown-mode)
;;(package 'maxframe)
;; (package 'motion-mode)
(package 'multiple-cursors)
;; (package 'powerline)
(package 'web-mode)

;; makes handling lisp expressions much, much easier
;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
(package 'paredit)

(package 'projectile)
(package 'projectile-rails)
(package 'helm-projectile)
(package 'robe) ;; ruby auto-complete and docs
;;(package 'enh-ruby-mode)
(package 'rvm)
;;(package 'sass-mode)
(package 'smex)
(package 'sos)
(package 'smartparens)
;; (package 'shell-pop)
;; (package 'toggle-quotes)
(package 'tabbar-ruler)

(package 'tagedit)
(package 'yaml-mode)
(package 'yasnippet)


;; ===============================================
;;(personal 'auto-complete)


(personal 'align)
(personal 'clojure)
(personal 'cider)
(personal 'company-mode)
(personal 'diff)
(personal 'dired)
(personal 'disabled)
(personal 'drag-stuff)
(personal 'elisp)

(personal 'ergodox)
(personal 'expand-region)
(personal 'flycheck)
(personal 'global)

(personal 'grep)
(personal 'goto-last-change)
(personal 'haml-mode)
(personal 'highlight-parentheses)
(personal 'helm)
;;(personal 'hippy-expand)
(personal 'hydra)
;;(personal 'ido)
(personal 'idle-highlight)
(personal 'js2-mode)
(personal 'jsx-mode)


(personal 'multiple-cursors)
(personal 'org)
(personal 'projectile)
(personal 'recentf)

;;(personal 'rectangle)
(personal 'ruby-mode)
(personal 'saveplace)
(personal 'scratch)
(personal 'server-mode)
(personal 'shell-mode)
(personal 'smartparens)
(personal 'smex)
(personal 'tabs)

;;(personal 'utf-8) ;; emacs 26 has some problems... tbd
(personal 'web-mode)
;;(personal 'ryo)
;;(personal 'xkeys)
(personal 'dual-shock)
(personal 'yasnippet)

;;(personal 'zoom) ; code folding

(personal 'tabbar-ruler)

;; needs to go last for overrides
(personal 'bindings)
(personal 'mac)
;;(load "midi-kbd")


;;(vendor 'revbufs 'revbufs)
;;(vendor 'ryo-modal)
;;(vendor 'electric-align 'electric-align-mode)



