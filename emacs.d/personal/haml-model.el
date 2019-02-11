
(require 'haml-mode)

(add-hook 'haml-mode-hook
           (lambda ()
             (electric-indent-mode -1)
             ;;(setq indent-tabs-mode nil)
             ;;(define-key haml-mode-map "\C-m" 'newline-and-indent)
             ))

