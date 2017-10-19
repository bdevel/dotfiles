
(when (display-graphic-p (selected-frame))
  (setq tabbar-ruler-global-tabbar t) ; If you want tabbar
  (setq tabbar-ruler-global-ruler nil) ; if you want a global ruler
  (setq tabbar-ruler-popup-menu t) ; If you want a popup menu.
  (setq tabbar-ruler-popup-toolbar t) ; If you want a popup toolbar
  (setq tabbar-ruler-popup-scrollbar nil) ; If you want to only show the
                                        ; scroll bar when your mouse is moving.
  (setq tabbar-ruler-use-mode-icons nil)

  (require 'tabbar-ruler)
  (tabbar-ruler-group-by-projectile-project)
  
  ;; (set-face-attribute 'tabbara-default nil 
  ;;                     :foreground "#ffffff"
  ;;                     :background "#444444"
  ;;                     :nil)

  (global-unset-key (kbd "C-<left>"))
  (global-unset-key (kbd "C-<right>"))
  (global-unset-key (kbd "C-<up>"))
  (global-unset-key (kbd "C-<down>"))

  (global-set-key (kbd "C-<left>") 'tabbar-backward-tab)
  (global-set-key (kbd "C-<right>") 'tabbar-forward-tab)

  ;; This is annoying because fat fingers. plus it never goes
  ;; where you expect it to
  ;;(global-set-key (kbd "C-<up>") 'tabbar-forward-group)
  ;;(global-set-key (kbd "C-<down>") 'tabbar-backward-group)

  
)
 
