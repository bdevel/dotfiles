(deftheme ty-space
  "Created 2019-12-02.")



;; bg #222433 ;; grey
;; bright blue #2E37E4
;; blues #2D2F89 #0000FF Bright: #5664CE #5A68CB Faded: #7979AD
;; green #8CD867
;; red #E44B44
;; teal green #6DECB9
;; grey #646570
;; orange #FF961C


;; tangerine orange #FDCB00
;; pink #F51996
;; electric blue #038DD8
;; lavendar #9963FF
(let (
      (background "#1E0D4B") ;; 
      (foreground "#ffffff") ;;#c0c5ce
      (selection  "#48378c")
      (background-alt "#221b3b") ;; 
      
      (text       "white")
      (white     "#ffffff")
      (strings    "green")
      (keywords   "#F51996")
      (builtin      "#C18CFF")
      (methods    "#8fa1b3")
      (constants "#C18CFF")
      (punctuation "#c0c5ce")
      (variables "#C18CFF")
      (functions "#FDCB00")
      (comments   "#65737e")
      
      (gutters-active "#4f5b66")
      (delimiters "#c0c5ce")
      (gutters    "#343d46")
      (gutter-fg  "#65737e")
      )

  (custom-theme-set-faces
   'ty-space

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

   ;; Font lock faces
   ;; *****************************************************************************************
   `(font-lock-negation-char-face     ((t (:foreground ,text))));; ! 
   `(font-lock-keyword-face           ((t (:foreground ,keywords))))
   `(font-lock-type-face              ((t (:foreground ,punctuation))))
   `(font-lock-constant-face          ((t (:foreground ,constants))))
   `(font-lock-variable-name-face     ((t (:foreground ,variables))))
   `(font-lock-builtin-face           ((t (:foreground ,builtin))))
   `(font-lock-string-face            ((t (:foreground ,strings))))
   `(font-lock-comment-face           ((t (:foreground ,comments))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,delimiters))))
   `(font-lock-function-name-face     ((t (:foreground ,functions))))
   `(font-lock-doc-string-face        ((t (:foreground ,strings))))

   ;; Interface components
   ;; *****************************************************************************************
   
   ;; `(fringe ((t (:foreground "white" :background ,gutters ))))
   ;; `(linum ((t (:background ,gutters   :foreground ,text :height 0.8))))

   ;; ;; For display-line-numbers-mode which is faster
   ;; `(line-number ((t (:background ,gutters   :foreground "#aaa" :height 0.8))))


   ;; Special modes
   ;; *****************************************************************************************
   `(bm-persistent-face        ((t (:background "#cc7b6c"))))

   ))


;; (custom-theme-set-faces
;;  'ty-space
;;  `(default ((t (:family "Ubuntu Mono"
;;                         :foundry "nil" 
;;                         :width normal
;;                         :height 210
;;                         :weight normal 
;;                         :slant normal 
;;                         :underline nil 
;;                         :overline nil 
;;                         :strike-through nil 
;;                         :box nil 
;;                         :inverse-video nil 
;;                         :foreground "#f6f3e8" 
;;                         :background ,default-bg
;;                         :stipple nil 
;;                         :inherit nil))))

;;  '(cursor-type ((bar . 2)))
;;  '(cursor ((t (:background "#ffff00"))))
;;  ;; '(fixed-pitch ((t (:family "Monospace"))))
;;  ;; '(variable-pitch ((((type w32)) (:font "-outline-Arial-normal-normal-normal-sans-*-*-*-*-p-*-iso8859-1")) (t (:family "Sans Serif"))))
;;  '(escape-glyph ((t (:weight bold :foreground "#ddaa6f"))))
;;  '(minibuffer-prompt ((t (:foreground "#e5786d"))))
;;  '(highlight ((t (:underline (:color foreground-color :style line) :foreground "#ffffff" :background "#454545"))))
;;  '(region ((t (:foreground "#f6f3e8" :background "#2a67a2"))))
;;  '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
;;  '(secondary-selection ((t (:foreground "#f6f3e8" :background "#333366"))))
;;  '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))

 
;;  '(font-lock-builtin-face              ((t (:foreground my-builtin))))
;;  '(font-lock-comment-face              ((t (:foreground my-comments))))
;;  '(font-lock-comment-delimiter-face    ((default (:inherit (font-lock-comment-face)))))
;;  '(font-lock-doc-face                  ((t (:inherit (font-lock-string-face) :foreground my-strings))))
;;  '(font-lock-string-face               ((t (:foreground my-strings))))
;;  '(font-lock-constant-face             ((t (:foreground my-fns))))
;;  '(font-lock-function-name-face        ((t (:weight normal :foreground my-fns))))
 
;;  '(font-lock-variable-name-face        ((t (:weight normal :foreground "#c4e454"))))
;;  '(font-lock-warning-face              ((t (:foreground "#ccaa8f"))))
;;  '(font-lock-keyword-face              ((t (:weight normal :foreground "#8ac6f2"))))
;;  '(font-lock-negation-char-face        ((t :inherit (default) :foreground "white" :weight bold)))
;;  '(font-lock-preprocessor-face         ((t (:inherit (font-lock-builtin-face)))))
;;  '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
;;  '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
;;  '(font-lock-type-face                 ((t (:weight normal :foreground "grey70"))))
 
;;  '(button ((t (:foreground "#f6f3e8" :background "#333333"))))
;;  ;;'(linum ((t (:background dark-bg :foreground "#aaaaaa" :height 0.6))))
;;  ;;'(linum ((t (:foreground "black" :background dark-bg))))
;;  '(link ((t (:underline (:color foreground-color :style line) :foreground "#8ac6f2"))))
;;  '(link-visited ((t (:underline (:color foreground-color :style line) :foreground "#e5786d"))))
;;  ;;'(fringe ((t (:background dark-bg))))
;;  '(header-line ((t (:foreground "#e7f6da" :background "#303030"))))
;;  '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))
;;  '(mode-line ((t (:foreground "#f6f3e8" :background "#444444"))))
;;  '(mode-line-buffer-id ((t (:weight bold))))
;;  '(mode-line-emphasis ((t (:weight bold))))
;;  '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
;;  '(mode-line-inactive ((t (:foreground "#857b6f" :background "#444444"))))
;;  '(isearch ((t (:foreground "#857b6f" :background "#343434"))))
;;  '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
;;  '(lazy-highlight ((t (:foreground "#a0a8b0" :background "#384048"))))
;;  '(match ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
;;  '(next-error ((t (:inherit (region)))))
;;  '(query-replace ((t (:inherit (isearch)))))

 
;;  `(tabbar-default ((t (:inherit (default)
;;                                 :height 0.9
;;                                 :foreground "white"
;;                                 :background ,default-bg
;;                                 ;;:underline "#2a67a2" ;;(:color )
;;                                 :box nil; '(:line-width 1 :color "white" :style nil)
;;                                 ))))

;;  ;; not selected
;;  '(tabbar-unselected ((t (:inherit (tabbar-default)
;;                                    :background "#093d6f"
;;                                    :foreground "grey70"
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
;;                                           ;;:foreground "#ff5526"
;;                                           :foreground "red"
;;                                           :weight normal) )))
 
;;  '(tabbar-unselected-modified ((t (:inherit (tabbar-unselected)  
;;                                             :foreground "#ff5526" :weight normal) )))

 
 
;;  ;; tabbar-unselected-modified
;;  ;; tabbar-selected-modified
;;  ;; tabbar-separator

;;  ;; for mouse over
;;  ;; '(tabbar-highlight ((t (:inherit (default)  
;;  ;;                                  :background "white"
;;  ;;                                  :foreground "black"
;;  ;;                                  :underline nil
;;  ;;                                  :box '(:line-width 5 :color "red" :style nil)))))


;;  )

(provide-theme 'ty-space)
