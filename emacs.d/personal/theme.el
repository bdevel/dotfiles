;;; Theme customization

(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
(add-to-list 'load-path (concat user-emacs-directory "themes"))

(defun lcd-monitor-mode ()
  (interactive)
  (load-theme 'wombat)

  (set-face-attribute 'default nil
                      :height 130
                      :font "Courier New")


  (set-background-color "#0d4d8b")
  (set-face-background 'fringe "#0d4d8b")

  (set-cursor-color "#ffff00")
  (set-default 'cursor-type 'bar)
  (blink-cursor-mode t)

  (set-face-attribute 'region nil :background "#2a67a2")

  (linum-mode t)
  ;;(idle-highlight-mode t)
  (setq linum-format "%4d")
  (set-face-attribute
   'linum nil :background "#093d6f" :foreground "#aaaaaa" :height 0.8)


  (set-face-attribute 'font-lock-function-name-face nil
		      :weight 'normal
		      )
  (set-face-attribute 'font-lock-type-face nil
                      :weight     'normal
                      :foreground "grey70")

  (set-face-attribute 'font-lock-keyword-face nil
                      :weight     'normal)
  (set-face-attribute 'font-lock-variable-name-face nil
                      :weight     'normal
                      :foreground "#c4e454")

  ;; (set-face-attribute 'tabbar-unselected nil 
  ;;                     :foreground "#bbbbbb"
  ;;                     :background "#666666"
  ;;                     :bold nil)

  ;; (set-face-attribute 'tabbar-selected-modified nil 
  ;;                     :foreground "#ff2222"
  ;;                     :background "#0d4d8b"
  ;;                     :bold nil)

)

(defun repaint-paperlike ()
  (interactive)
  (call-interactively 'eval-defun)
  (call-interactively 'paperlike-mode)
)

;; TODO:
;;   * Make a mode that is a bar 
(defun paperlike-mode ()
  (interactive)
  (load-theme 'tao-yang)
  ;;(load-theme 'whiteboard)

  (set 'a2-grey "grey80")

  (set-background-color "#ffffff")
  (set-face-background 'fringe a2-grey)

  (set-cursor-color "#000000")
  (set-default 'cursor-type '(hbar . 2))
  (blink-cursor-mode 0)
  
  (set-face-attribute 'default nil
                      :height 180
                      :font "OCR A Std:antialias=none" ;Inconsolata
                      :foreground "#000000"
                      :
                      weight 'normal
                      )
  (set-face-attribute 'font-lock-keyword-face nil
                      :weight     'bold)
  ;;(linum-mode 0)
  ;;(setq linum-format "%4d")

  ;; (set-face-attribute
  ;;  'linum nil :background "grey70" :foreground "#000000" :height 0.8)

  
  ;;(set-face-attribute
  ;;'font-lock-comment-face nil :foreground "#aaaaaa" :slant 'italic :weight 'normal)

  
  )

;; Disable background color when in terminal
;; http://stackoverflow.com/questions/19054228/emacs-disable-theme-background-color-in-terminal
;; (defun on-after-init ()
;;   (unless (display-graphic-p (selected-frame))
;;     (set-face-background 'default "unspecified-bg" (selected-frame))))
;; (add-hook 'window-setup-hook 'on-after-init)




(when (display-graphic-p (selected-frame))
  (call-interactively 'lcd-monitor-mode))
