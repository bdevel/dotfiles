(deftheme ty-dark
  "Created 2021-03-16.")


;; blue shades, lightest to darkest
;; #5B7A9F
;; #1E3D68
;; #1B202E
;; #071934
;; #062043
;; darkest #081122

;; greys
;; #6F89A6
;; #7A8F9F
;; #5A5D74


;; greens
;; #4C5852
;; #1F2728


(let (
      (background "#0B1D34")
      (foreground "#6382A4")
      (selection  "#1E3A5D")
      (background-alt "black") ;; 
      
      (text       "#6382A4")
      (white     "#ffffff")
      (strings    "#4C5852")
      (keywords   "#635e69")
      (builtin      "#81784D")
      (methods    "#8fa1b3")
      (constants "#C18CFF")
      (punctuation "#4C5852")
      (variables "#81784D")
      (functions "#81784D")
      (comments   "#424242")
      
      (gutters-active "black")
      (delimiters "#c0c5ce")
      (gutters    "#343d46")
      (gutter-fg  "#65737e")
      )

  (custom-theme-set-faces
   'ty-dark

   ;; Default colors
   ;; *****************************************************************************************

   `(default                          ((t (:foreground ,text :background ,background))))
   `(region                           ((t (:background ,selection                       ))))
   `(cursor                           ((t (:background ,white                        ))))
   `(fringe                           ((t (:background ,background   :foreground ,white))))
   `(linum                            ((t (:background ,background :foreground ,gutter-fg))))
   `(line-number                        ((t (:foreground ,comments :background ,background-alt  ))))
   `(mode-line                        ((t (:foreground ,white :background ,gutters-active  ))))
   `(mode-line-inactive               ((t (:foreground ,gutter-fg :background ,gutters  ))))
   `(hl-line ((t (:background ,background-alt))))
   
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

   ;; Interface components
   ;; *****************************************************************************************
   
   ;; `(fringe ((t (:foreground "white" :background ,gutters ))))
   ;; `(linum ((t (:background ,gutters   :foreground ,text :height 0.8))))

   ;; ;; For display-line-numbers-mode which is faster
   ;; `(line-number ((t (:background ,gutters   :foreground "#aaa" :height 0.8))))


   ;; Special modes
   ;; *****************************************************************************************
   `(bm-persistent-face        ((t (:background "#2222222"))))



   `(tabbar-default ((t (:inherit (default)
                                  :family "Ubuntu Mono"
                                  :height 180
                                  :foreground "white"
                                  :background ,background-alt
                                  ;;:underline "#2a67a2" ;;(:color )
                                  :box nil; '(:line-width 1 :color "white" :style nil)
                                  ))))

   ;; not selected
   `(tabbar-unselected ((t (:inherit (tabbar-default)
                                     :background ,background-alt
                                     :foreground ,foreground
                                     ;;:underline (:color "black")
                                     ;;:box  nil;'(:line-width 3 :color "yellow" :style "released-button")
                                     ))))
   
   ;; selected
   `(tabbar-selected ((t (:inherit (tabbar-default)  
                                   :background  ,background
                                   :foreground ,foreground
                                        ;:box '(:line-width  :color "green" :style nil)
                                   ))))

   '(tabbar-separator ((t (:background "black"
                                       :height 0.9))))

   ;;'(tabbar-modified ((t (:forground "red" :weight normal) )))
   '(tabbar-selected-modified ((t (:inherit (tabbar-selected)  
                                            ;;:foreground "#ff5526"
                                            :foreground "red"
                                            :weight normal) )))
   
   '(tabbar-unselected-modified ((t (:inherit (tabbar-unselected)  
                                              :foreground "#ff5526"
                                              :weight normal) )))

   
   ))


(provide-theme 'ty-dark)
