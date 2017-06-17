(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js-indent-level 2)
(setq js2-cleanup-whitespace t)
(setq js2-basic-offset 2)
(setq js2-bounce-indent-p nil)


;(add-hook 'js2-mode-hook (lambda () (electric-pair-mode 1)))
(add-hook 'js2-mode-hook 'idle-highlight-mode)


;; Special improvements using the mooz fork
;; https://github.com/mooz/js2-mode
;;(setq js2-consistent-level-indent-inner-bracket-p t)
;;(setq js2-use-ast-for-indentation-p t)
