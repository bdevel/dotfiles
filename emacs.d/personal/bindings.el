;;; Global key bindigns

(require 'expand-region)


;; How to Define Keyboard Shortcuts in Emacs
;; http://xahlee.org/emacs/keyboard_shortcuts.html

(global-set-key (kbd "C-x C-r") 'recentf-open-files);; recent files
(global-set-key (kbd "H-SPC") 'er/expand-region)
(global-set-key (kbd "C-S-SPC") 'kill-whitespace)
(global-set-key (kbd "C-a") 'beginning-of-line-text)
(global-set-key (kbd "M-w") 'copy-region-dont-deactivate)

;;(global-set-key (kbd "M-<right>") (lambda ()(interactive)
;;                                    (sp-foward-slurp-sexp 1))
(global-set-key (kbd "M-<right>") 'sp-slurp-hybrid-sexp)
(global-set-key (kbd "M-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "S-M-<left>") 'sp-extract-before-sexp)
(global-set-key (kbd "S-M-<right>") 'sp-extract-after-sexp)

(global-set-key (kbd "M-k") (lambda ()(interactive)
                              (beginning-of-line)
                              ))

;; clear whole line
(global-set-key (kbd "M-k") (lambda ()(interactive)
                              (kill-whole-line)
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


;; Dislable secondary selection
;; https://emacs.stackexchange.com/questions/8225/clear-secondary-selection-without-using-mouse
(global-unset-key [M-mouse-1])
(global-unset-key [M-drag-mouse-1])
(global-unset-key [M-down-mouse-1])
(global-unset-key [M-mouse-3])
(global-unset-key [M-mouse-2])
;; don't ask if i want to save, just exit
;; http://stackoverflow.com/questions/6762686/prevent-emacs-from-asking-modified-buffers-exist-exit-anyway
;(global-set-key (kbd "C-x C-c") 'kill-emacs)
