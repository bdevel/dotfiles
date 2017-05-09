(require 'multiple-cursors)

(global-set-key (kbd "C-c r") 'mc/edit-lines)
(global-set-key (kbd "C-c n")     'mc/mark-next-like-this)
(global-set-key (kbd "C-c p")     'mc/mark-previous-like-this)

(global-set-key (kbd "C-c s")     'mc/mark-next-like-this-symbol)

(global-set-key (kbd "C-c a")   'mc/mark-all-like-this)
;;(global-set-key (kbd "s-SPC")   'set-rectangular-region-anchor)
