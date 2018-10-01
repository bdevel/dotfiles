;;; Global key bindigns

(require 'expand-region)

;; How to Define Keyboard Shortcuts in Emacs
;; http://xahlee.org/emacs/keyboard_shortcuts.html



(global-set-key (kbd "C-x C-r") 'recentf-open-files);; recent files
(global-set-key (kbd "H-SPC") 'er/expand-region)
(global-set-key (kbd "C-S-SPC") 'kill-whitespace)


;;(global-set-key (kbd "M-<right>") (lambda ()(interactive)
;;                                    (sp-foward-slurp-sexp 1))
(global-set-key (kbd "M-<righty>") 'sp-slurp-hybrid-sexp)
(global-set-key (kbd "M-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "S-M-<left>") 'sp-extract-before-sexp)
(global-set-key (kbd "S-M-<right>") 'sp-extract-after-sexp)


;; clear whole line
(global-set-key (kbd "M-k") (lambda ()(interactive)
                              (beginning-of-line)
                              (kill-line)
                              (kill-line)
                              (back-to-indentation)
                              ))

(defun kill-this-buffer-dont-ask ()
  (kill-buffer (current-buffer)))

;; Disable asking to kill buffer
;;(global-set-key (kbd "C-x k") 'kill-this-buffer-dont-ask)
(global-set-key (kbd "C-x k") (lambda ()(interactive) (kill-buffer (current-buffer)) ))

(global-set-key (kbd "C-x d") (lambda ()(interactive)
                                (move-beginning-of-line 1)
                                (kill-line)
                                (yank)
                                (open-line 1)
                                (next-line 1)
                                (yank)
                                ))




;; don't ask if i want to save, just exit
;; http://stackoverflow.com/questions/6762686/prevent-emacs-from-asking-modified-buffers-exist-exit-anyway
;(global-set-key (kbd "C-x C-c") 'kill-emacs)
