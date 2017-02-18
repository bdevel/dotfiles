;;; Theme customization

(when (display-graphic-p (selected-frame))

  (add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
  (add-to-list 'load-path (concat user-emacs-directory "themes"))

  (load-theme 'wombat)

  ;;(set-background-color "#162E51")
  (set-background-color "#0d4d8b")
  (set-face-background 'fringe "#0d4d8b")

  (set-cursor-color "#ffff00")
  (set-default 'cursor-type 'bar)
  (blink-cursor-mode t)

  (set-face-attribute 'default nil :height 200)

  ;;(set-face-attribute 'region nil :background "#093d6f");;2a67a2
  (set-face-attribute 'region nil :background "#2a67a2")

  (hl-line-mode 0) ;; highlight line mode on/off

  (linum-mode t)
  (setq linum-format "%4d")
  
  (set-face-attribute
   'linum nil :background "#093d6f" :foreground "#aaaaaa" :height 0.8)

)

;; Disable background color when in terminal
;; http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
;; (defun on-after-init ()
;;   (unless (display-graphic-p (selected-frame))
;;     (set-face-background 'default "unspecified-bg" (selected-frame))))
;; (add-hook 'window-setup-hook 'on-after-init)
