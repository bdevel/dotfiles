
(require 'haml-mode)

(add-hook 'haml-mode-hook
          (lambda ()
            (electric-indent-mode -1)
            (aggressive-indent-mode -1)
            (define-key haml-mode-map (kbd "<return>") 'newline)
            ))

