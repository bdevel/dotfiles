;;; Global key bindigns

(require 'expand-region)


;; How to Define Keyboard Shortcuts in Emacs
;; http://xahlee.org/emacs/keyboard_shortcuts.html


(global-set-key (kbd "C-x C-r") 'recentf-open-files);; recent files
(global-set-key (kbd "H-SPC") 'er/expand-region)
(global-set-key (kbd "C-S-SPC") 'kill-whitespace)
(global-set-key (kbd "C-<tab>") 'kill-whitespace)
(global-set-key (kbd "C-a") 'back-to-indentation) ;; beginning-of-line-text
(global-set-key (kbd "M-w") 'copy-region-dont-deactivate)

;;(global-set-key (kbd "M-<right>") (lambda ()(interactive)
;;                                    (sp-foward-slurp-sexp 1))
(global-set-key (kbd "M-<right>") 'sp-slurp-hybrid-sexp)
(global-set-key (kbd "M-<left>") 'sp-forward-barf-sexp)
(global-set-key (kbd "S-M-<left>") 'sp-extract-before-sexp)
(global-set-key (kbd "S-M-<right>") 'sp-extract-after-sexp)

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
;;(global-set-key (kbd "C-x C-c") 'kill-emacs)




(defun do-nothing ()
  "Used to disable warning about key not being bound."
  (interactive "*")
  nil)

(global-set-key (kbd "<f4>") 'ty-eval-buffer)
(global-set-key (kbd "<f5>") 'ty-eval-defun)
(global-set-key (kbd "<f6>") 'ty-eval-last-sexp)
(global-set-key (kbd "<f7>") 'ty-eval-region)
(global-set-key (kbd "<f8>") 'do-nothing);; undo
(global-set-key (kbd "<f9>") 'undo)

;;==========================


;; ()
;;

;; (defun click-is-within-region (event)   
;;   ""
;;   (let* ((cpos (nth 1 (nth 1 event)) ))
;;     (and (use-region-p)
;;          (>= cpos (region-beginning))
;;          (<= cpos (region-end)))))

;; ;; Disable moving cursor to another location inside the region.
;; ;; required for click expanding
;; (global-set-key (kbd "<down-mouse-1>")
;;                 (lambda
;;                   (event)
;;                   (interactive "e")
;;                   (if (click-is-within-region event)
;;                       nil
;;                     (mouse-drag-region event))))

;; (setq last-mouse-click-at 0)
;; (setq expand-region-fast-keys-enabled nil);; prevents extra keymap on expand
;; (global-set-key (kbd "<mouse-1>")
;;                 (lambda
;;                   (event)
;;                   (interactive "e")
;;                   (let* ((cpos (nth 1 (nth 1 event)) ))                    
;;                     (if (or (= last-mouse-click-at cpos)
;;                             ;;(click-is-within-region event)
;;                             )
;;                         ;;(call-interactively 'er/expand-region)
;;                         (er/expand-region 1)
;;                       (progn
;;                         (deactivate-mark)
;;                         (mouse-set-point event)))
;;                     (setq last-mouse-click-at cpos))
                  
;;                   ))


;; ;; To reset mouse click
;; (global-set-key (kbd "<mouse-1>")
;;                 (lambda
;;                   (event)
;;                   (interactive "e")
;;                   (mouse-set-point event)

;;                   ))




