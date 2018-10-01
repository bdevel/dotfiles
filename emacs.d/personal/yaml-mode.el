(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (setq electric-indent-mode nil)
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
