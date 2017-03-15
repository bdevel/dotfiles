
(when (display-graphic-p (selected-frame))
  (setq tabbar-ruler-global-tabbar t) ; If you want tabbar
  (setq tabbar-ruler-global-ruler nil) ; if you want a global ruler
  (setq tabbar-ruler-popup-menu t) ; If you want a popup menu.
  (setq tabbar-ruler-popup-toolbar t) ; If you want a popup toolbar
  (setq tabbar-ruler-popup-scrollbar nil) ; If you want to only show the
                                        ; scroll bar when your mouse is moving.

  (require 'tabbar-ruler)
  (tabbar-ruler-group-by-projectile-project)

  (set-face-attribute 'tabbar-unselected nil 
                      :foreground "#bbbbbb"
                      :background "#666666"
                      :bold nil)


  (set-face-attribute 'tabbar-selected-modified nil 
                      :foreground "#ff2222"
                      :background "#0d4d8b"
                      :bold nil)

  ;; (set-face-attribute 'tabbara-default nil 
  ;;                     :foreground "#ffffff"
  ;;                     :background "#444444"
  ;;                     :bold nil)



)
