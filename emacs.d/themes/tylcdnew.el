(deftheme tylcdnew
  "Created 2019-12-02.")

;; todo, the t here means terminal. fix this so it's for gui only. See defface docs
(fset 'reload-theme-buffer
      [escape ?x ?l ?o ?a ?d return ?t ?y ?- ?l tab return ?y ?y])



;; New colors:
;;  text white
;;    pink 180 120 255 #C18CFF
;;    teal #10E0EC
;;    dark purple #1E0D4B
;;   grey #A09CAA  #9C9BA1   darker #36353C
;;   green #0D3149   darker #042D31

(setq default-bg "#1E0D4B")
(setq dark-bg "#093d6f")
(setq darker-bg "#003054")

(setq my-strings "#003054")
(setq my-comments "#003054")


;; font-lock-string-face strings
;; font-lock-builtin-face symbols
;; font-lock-comment-face  comments
;; font-lock-keyword-face  fn calls 
;; font-lock-type-face     classes



;; region

(custom-theme-set-faces
 'tylcdnew
 `(default ((t (:family "Ubuntu Mono"
                        :foundry "nil" 
                        :width normal
                        :height 210
                        :weight normal 
                        :slant normal 
                        :underline nil 
                        :overline nil 
                        :strike-through nil 
                        :box nil 
                        :inverse-video nil 
                        :foreground "#f6f3e8" 
                        :background ,default-bg
                        :stipple nil 
                        :inherit nil))))

 '(cursor-type ((bar . 2)))
 '(cursor ((t (:background "#ffff00"))))
 ;; '(fixed-pitch ((t (:family "Monospace"))))
 ;; '(variable-pitch ((((type w32)) (:font "-outline-Arial-normal-normal-normal-sans-*-*-*-*-p-*-iso8859-1")) (t (:family "Sans Serif"))))
 '(escape-glyph ((t (:weight bold :foreground "#ddaa6f"))))
 '(minibuffer-prompt ((t (:foreground "#e5786d"))))
 '(highlight ((t (:underline (:color foreground-color :style line) :foreground "#ffffff" :background "#454545"))))
 '(region ((t (:foreground "#f6f3e8" :background "#2a67a2"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:foreground "#f6f3e8" :background "#333366"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))

 
 '(font-lock-builtin-face              ((t (:foreground "#e5786d"))))
 '(font-lock-comment-delimiter-face    ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face              ((t (:foreground my-comments))))
 '(font-lock-doc-face                  ((t (:inherit (font-lock-string-face) :foreground "#95e454"))))
 '(font-lock-constant-face             ((t (:foreground "#cae682"))))
 '(font-lock-function-name-face        ((t (:weight normal :foreground "#cae682"))))
 '(font-lock-keyword-face              ((t (:weight normal :foreground "#8ac6f2"))))
 '(font-lock-negation-char-face        ((t :inherit (default) :foreground "white" :weight bold)))
 '(font-lock-preprocessor-face         ((t (:inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face               ((t (:foreground "#95e454"))))
 '(font-lock-type-face                 ((t (:weight normal :foreground "grey70"))))
 '(font-lock-variable-name-face        ((t (:weight normal :foreground "#c4e454"))))
 '(font-lock-warning-face              ((t (:foreground "#ccaa8f"))))
 '(button ((t (:foreground "#f6f3e8" :background "#333333"))))
 ;;'(linum ((t (:background dark-bg :foreground "#aaaaaa" :height 0.6))))
 ;;'(linum ((t (:foreground "black" :background dark-bg))))
 '(link ((t (:underline (:color foreground-color :style line) :foreground "#8ac6f2"))))
 '(link-visited ((t (:underline (:color foreground-color :style line) :foreground "#e5786d"))))
 ;;'(fringe ((t (:background dark-bg))))
 '(header-line ((t (:foreground "#e7f6da" :background "#303030"))))
 '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))
 '(mode-line ((t (:foreground "#f6f3e8" :background "#444444"))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:foreground "#857b6f" :background "#444444"))))
 '(isearch ((t (:foreground "#857b6f" :background "#343434"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((t (:foreground "#a0a8b0" :background "#384048"))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))

 
 `(tabbar-default ((t (:inherit (default)
                                :height 0.9
                                :foreground "white"
                                :background ,default-bg
                                ;;:underline "#2a67a2" ;;(:color )
                                :box nil; '(:line-width 1 :color "white" :style nil)
                                ))))

 ;; not selected
 '(tabbar-unselected ((t (:inherit (tabbar-default)
                                   :background "#093d6f"
                                   :foreground "grey70"
                                   ;;:underline (:color "black")
                                   ;;:box  nil;'(:line-width 3 :color "yellow" :style "released-button")
                                   ))))
 
 ;; selected
 '(tabbar-selected ((t (:inherit (tabbar-default)  
                                 :background  "white"
                                 :foreground "black"
                                        ;:box '(:line-width  :color "green" :style nil)
                                 ))))

 '(tabbar-separator ((t (:background "black" :height 0.6))))

 ;;'(tabbar-modified ((t (:forground "red" :weight normal) )))
 '(tabbar-selected-modified ((t (:inherit (tabbar-selected)  
                                          ;;:foreground "#ff5526"
                                          :foreground "red"
                                          :weight normal) )))
 
 '(tabbar-unselected-modified ((t (:inherit (tabbar-unselected)  
                                            :foreground "#ff5526" :weight normal) )))

 
 
 ;; tabbar-unselected-modified
 ;; tabbar-selected-modified
 ;; tabbar-separator

 ;; for mouse over
 ;; '(tabbar-highlight ((t (:inherit (default)  
 ;;                                  :background "white"
 ;;                                  :foreground "black"
 ;;                                  :underline nil
 ;;                                  :box '(:line-width 5 :color "red" :style nil)))))


 )

(provide-theme 'tylcdnew)
