;;; Global key bindigns

;; How to Define Keyboard Shortcuts in Emacs
;; http://xahlee.org/emacs/keyboard_shortcuts.html


;; recent files
(global-set-key (kbd "C-x C-r") 'recentf-open-files)


(defun kill-this-buffer-dont-ask ()
  (kill-buffer (current-buffer)))

;; Disable asking to kill buffer
;;(global-set-key (kbd "C-x k") 'kill-this-buffer-dont-ask)
(global-set-key (kbd "C-x k") (lambda ()(interactive) (kill-buffer (current-buffer)) ))

;; (kill-buffer (current-buffer))

;; don't ask if i want to save, just exit
;; http://stackoverflow.com/questions/6762686/prevent-emacs-from-asking-modified-buffers-exist-exit-anyway
;(global-set-key (kbd "C-x C-c") 'kill-emacs)
