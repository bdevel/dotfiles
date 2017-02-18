;; Hide the tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))

;; Slow down the mouse wheel acceleration
(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.001)))


;; C- mouse wheel to change font size. Can't get zoom to work
;; http://stackoverflow.com/questions/5533110/emacs-zoom-in-zoom-out
(setq text-scale-mode-step 1.05)
(global-set-key [C-wheel-down] 'text-scale-increase)
(global-set-key [C-wheel-up] 'text-scale-decrease)

;;(global-set-key (kbd "<triple-wheel-right>") 'previous-buffer)
;;(global-set-key (kbd "<triple-wheel-left>") 'next-buffer)


;; make option key control
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'hyper)
(setq mac-right-option-modifier 'control)

;; C-SPC for right option get's hosed for some reason. Fixes that.
(global-set-key (kbd "H-SPC") 'set-mark-command)



;; Disable killing to Mac clipboard
(setq x-select-enable-clipboard nil)

;;;;;;;;;;;;; Make copy paste work at f1 f2 ;;;;;;;;
(defun pbcopy ()
  (interactive)
  (let ((deactivate-mark t))
    (call-process-region (point) (mark) "pbcopy")))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))


(global-set-key [f1] 'pbcopy)
(global-set-key [f2] 'pbpaste)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;; Prevent anti aliasing
;; (setq mac-allow-anti-aliasing nil)


;; Full screen mode
;; (mac-hide-menu-bar)
;; (mac-show-menu-bar)
