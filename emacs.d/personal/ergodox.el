;; (global-set-key (kbd "C-n") )

;; (defmacro () (list 'defhydra () ))

;; Change cursor on in and out

;; :after-exit => start caps mode again


;;(hydra-set-property 'hydra-lispy-x :verbosity 1) (setq hydra-is-helpful 1)

;;(customize-set-variable 'browse-kill-ring-separator "")


;; Ergodox keyboard


(global-set-key (kbd  "<end>") 'smex)
(global-set-key (kbd "<C-end>") nil)
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "M-c") 'pbcopy)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-x !") 'delete-other-windows)
(global-set-key (kbd "C-<up>") 'scroll-down-command)
(global-set-key (kbd "C-<down>") 'scroll-up-command)
;;(global-set-key (kbd "M-v") 'pbpaste)
;;(global-set-key (kbd "M-v") 'scroll-down-command)


(global-set-key (kbd "<f13>") (lambda () (interactive)
                                (insert "()")
                                (backward-char) ))
(global-set-key (kbd "C-<f13>") (lambda () (interactive)
                                (insert "#()")
                                (backward-char) ))
(global-set-key (kbd "H-<f13>") (lambda () (interactive)
                                (insert "[]")
                                (backward-char) ))
(global-set-key (kbd "H-S-<f13>") (lambda () (interactive)
                                  (insert "{}")
                                  (backward-char) ))

(defun smart-line-beginning () "Move point to the beginning of text on the
  current line; if that is already the current position of point, then move it
  to the beginning of the line."  (interactive) (let ((pt (point)))
                                                  (beginning-of-line-text) (when (eq pt (point)) (beginning-of-line))))



;; (defhydra hydra-ergodox (:exit t ;;:foreign-keys warn :pre (hydra-enter) :post
;;                               (hydra-exit))

;;   "Ergodox mode."  
;;   ;;("f" hydra-file/body "File") ("e" hydra-edit/body "Edit")

;;   ;; FWD / BACK SYMBOL
;;   ("d" ds-backward-symbol "backward-symbol" :exit nil)
;;   ("f" ds-forward-symbol "forward-symbol" :exit nil)

;;   ("a" er/expand-region "expand-region" :exit nil)
;;   ("s" er/contract-region "contract-region" :exit nil)

;;   ;;   ("a" smart-line-beginning "smart-line-beginning" :exit nil) ("g"
;;   ;;   move-end-of-line "end line" :exit nil)

;;   ;; er for changing buffers
;;   ;; df for marking symbol
;;   ;; space tab for more less
;;   ;;  for cursor edit locations

;;   ;; Right Hand
;;   ;; jk for kill yank

;;   )

;;(global-set-key (kbd "<home>") 'hydra-ergodox/body)

