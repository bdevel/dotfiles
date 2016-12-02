;;; Global key bindigns

;; How to Define Keyboard Shortcuts in Emacs
;; http://xahlee.org/emacs/keyboard_shortcuts.html


;; recent files
(global-set-key (kbd "C-x C-r") 'recentf-open-files)


;; Disable asking to kill buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; don't ask if i want to save, just exit
;; http://stackoverflow.com/questions/6762686/prevent-emacs-from-asking-modified-buffers-exist-exit-anyway
(global-set-key (kbd "C-x C-c") 'kill-emacs)
