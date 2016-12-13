;;; Theme customization

(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
(add-to-list 'load-path (concat user-emacs-directory "themes"))




(load-theme 'wombat)

(set-background-color "#162E51")
(set-face-background 'fringe "#0E203A")
(set-cursor-color "#ffffff")
(set-default 'cursor-type 'bar)

(blink-cursor-mode 1)

(set-face-attribute 'default nil :height 190)
(hl-line-mode 0) ;; highlight line mode on/off


;; (set-face-attribute 'region nil :background "cornflower blue")
;; (set-face-attribute 'isearch nil :background "gold" :foreground "black")
;; (set-face-attribute 'lazy-highlight nil :background "dark goldenrod" :foreground "white")

;; Disable background color when in terminal
;; http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)
