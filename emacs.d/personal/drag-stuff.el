;; https://github.com/rejeep/drag-stuff.el
;;(drag-stuff-global-mode 1)
;;(drag-stuff-define-keys)

;; only support up down. M-left/right is used for slurp/barf
(global-set-key (kbd "M-<up>") 'drag-stuff-up)
(global-set-key (kbd "M-<down>") 'drag-stuff-down)
