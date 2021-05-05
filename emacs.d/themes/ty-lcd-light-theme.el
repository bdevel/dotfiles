(deftheme ty-lcd-light
  "For sunlight.")

;; font-lock-string-face strings
;; font-lock-builtin-face symbols
;; font-lock-comment-face  comments
;; font-lock-keyword-face  fn calls 
;; font-lock-type-face     classes


(let ((background "#f2f2e9")
      (contrast     "#000000")
      (selection  "#e3ff8f")
      
      (text       "#3d2b78")
      (strings    "#17a800")
      (methods    "#8fa1b3")
      (variables "#7d00d6") ; @vars
      (functions "#ff0000")
      (keywords "#004cff"); def begin
      (builtin      "#7d00d6") ;; 
      (constants "#ff6a00"); ClassNames, :symbols
      (comments   "#AAAAAA")
      (operators "#c0c5ce")
      (punctuation "#c0c5ce")
      (delimiters "#c0c5ce")
      
      (gutter-bg    "#FFFFFF")
      (gutter-fg  "#aaaaaa")
      (gutters-active "#4f5b66")
      
      
      )

  (custom-theme-set-faces
   'ty-lcd-light

   ;; Default colors
   ;; *****************************************************************************************

   `(default                          ((t (:foreground ,text :background ,background))))
   
   `(region                           ((t (:background ,selection                       ))))
   `(cursor                           ((t (:background ,contrast                        ))))
   `(fringe                           ((t (:background ,background   :foreground ,contrast))))
   `(linum                            ((t (:background ,background :foreground ,gutter-fg))))
   `(mode-line                        ((t (:foreground ,contrast :background ,gutters-active  ))))
   `(mode-line-inactive               ((t (:foreground ,gutter-fg :background ,gutter-bg  ))))

   ;; Font lock faces
   ;; *****************************************************************************************
   
   `(font-lock-negation-char-face     ((t (:foreground ,text))));; ! 
   `(font-lock-keyword-face           ((t (:foreground ,keywords))))
   `(font-lock-type-face              ((t (:foreground ,constants))))
   `(font-lock-constant-face          ((t (:foreground ,constants))))
   `(font-lock-variable-name-face     ((t (:foreground ,variables))))
   `(font-lock-builtin-face           ((t (:foreground ,builtin))))
   `(font-lock-string-face            ((t (:foreground ,strings))))
   `(font-lock-comment-face           ((t (:foreground ,comments))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,delimiters))))
   `(font-lock-function-name-face     ((t (:foreground ,functions))))
   `(font-lock-doc-string-face        ((t (:foreground ,strings))))
   `(font-lock-doc-face               ((t (:foreground ,strings))))
   
   ;; *****************************************************************************************

   `(bm-persistent-face        ((t (:background "#c9deff"))))
   `(line-number ((t (:background "#dddddd"   :foreground "#888888" :height 0.8))))
   `(hl-line ((t (:background "#efefef"))))
   

   ;; *****************************************************************************************
    '(mode-line ((t (:foreground "black" :background "#EFEFEF"))))
    ;; '(mode-line-buffer-id ((t (:weight bold))))
    ;; '(mode-line-emphasis ((t (:weight bold))))
    ;; '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
    ;; '(mode-line-inactive ((t (:foreground "#857b6f" :background "#444444"))))

   
  ;;  '(tabbar-default ((t (:inherit (default)
  ;;                                :height 0.9
  ;;                                :foreground "black"
  ;;                                :background "gray60"
  ;;                                :box nil; '(:line-width 1 :color "white" :style nil)
  ;;                                ))))
  
  ;;  ;; not selected
  ;;  '(tabbar-unselected ((t (:inherit (tabbar-default)
  ;;                                    :foreground "black"
  ;;                                    :background "grey80"
  ;;                                    ;;:underline (:color "black")
  ;;                                    ;;:box  nil;'(:line-width 3 :color "yellow" :style "released-button")
  ;;                                    ))))
  
  ;;  ;; selected
  ;;  '(tabbar-selected ((t (:inherit (tabbar-default)  
  ;;                                  :background  "white"
  ;;                                  :foreground "black"
  ;;                                         ;:box '(:line-width  :color "green" :style nil)
  ;;                                  ))))

  ;;  '(tabbar-separator ((t (:background "black" :height 0.6))))

  ;;  ;;'(tabbar-modified ((t (:forground "red" :weight normal) )))
  ;;  '(tabbar-selected-modified ((t (:inherit (tabbar-selected)  
  ;;                                           :foreground "#ff5526"
  ;;                                           :weight normal) )))
  
  ;;  '(tabbar-unselected-modified ((t (:inherit (tabbanr-unselected)  
  ;;                                             :foreground "#ff5526" :weight normal) )))

  
  ))



(provide-theme 'ty-lcd-light)

