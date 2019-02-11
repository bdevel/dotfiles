;; Hide the tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))

;; Mouse Wheel stuff
;; Slow down the mouse wheel acceleration
;; (when (boundp 'mouse-wheel-scroll-amount)
;;   (setq mouse-wheel-scroll-amount '(0.2)))

;; (setq scroll-step 1)
;; (setq scroll-conservatively 101)
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
;; (setq mouse-wheel-progressive-speed nil)
;; (setq mouse-wheel-follow-mouse t)


(setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
(setq mouse-wheel-scroll-amount '(2)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
(setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line


;; C- mouse wheel to change font size. Can't get zoom to work
;; http://stackoverflow.com/questions/5533110/emacs-zoom-in-zoom-out
(setq text-scale-mode-step 1.05)
(global-set-key [C-wheel-down] 'text-scale-increase)
(global-set-key [C-wheel-up] 'text-scale-decrease)

;;(setq-default line-spacing 2);; this hoses up the hydra status bar

;;(global-set-key (kbd "<triple-wheel-right>") 'previous-buffer)
;;(global-set-key (kbd "<triple-wheel-left>") 'next-buffer)


;; TODO: These don't seem to stick when reloading from desktop
;; make option key control
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'hyper)
(setq mac-right-option-modifier 'control)
(global-set-key (kbd "H-SPC") 'set-mark-command) ;; C-SPC for right option get's hosed for some reason. Fixes that.



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



;; Macbook keyboard
(global-set-key (kbd "H-c") 'pbcopy) ;; [f1]
(global-set-key (kbd "H-v") 'pbpaste)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-c") 'copy-region-dont-deactivate)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-a") 'er/expand-region)


;; Turn off bell warnings.
;; https://www.emacswiki.org/emacs/AlarmBell
(setq ring-bell-function 'ignore)

;; Prevent anti aliasing
;; (setq mac-allow-anti-aliasing nil)


;; Full screen mode
;; (mac-hide-menu-bar)
;; (mac-show-menu-bar)


;; Adds rectable selection with mouse. Hold down shift.
;; TODO: Make work with multiple cursors
;; https://emacs.stackexchange.com/questions/7244/enable-emacs-column-selection-using-mouse
(defun mouse-start-rectangle (start-event)
  (interactive "e")
  (deactivate-mark)
  (mouse-set-point start-event)
  (rectangle-mark-mode +1)
  (let ((drag-event))
    (track-mouse
      (while (progn
               (setq drag-event (read-event))
               (mouse-movement-p drag-event))
        (mouse-set-point drag-event)))))

(global-set-key (kbd "S-<down-mouse-1>") #'mouse-start-rectangle)
