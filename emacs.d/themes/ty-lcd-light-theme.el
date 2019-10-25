(deftheme ty-lcd-light
  "Created 2019-07-08.")

(custom-theme-set-faces
 'ty-lcd-light
 '(default ((t (:family "Ubuntu Mono" :foundry "nil" :width normal :height 210 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#333333" :background "#FFFFFF" :stipple nil :inherit nil))))
 '(cursor-type 'bar) ;; TODO
 '(cursor ((t (:background "black"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "#008ED1"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:weight bold :foreground "black" :background "gold"))))
 '(highlight ((t (:background "#E6ECFF"))))
 '(region ((t (:background "#8ED3FF"))))
 '(shadow ((t (:foreground "#7F7F7F"))))
 '(secondary-selection ((t (:weight bold :background "#FFFF00"))))
 '(trailing-whitespace ((t (:foreground "#E8E8E8" :background "#FFFFAB"))))
 '(font-lock-builtin-face ((t (:foreground "#006FE0"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#8D8D84"))))
 '(font-lock-comment-face ((t (:slant italic :foreground "#8D8D84"))))
 '(font-lock-constant-face ((t (:foreground "chocolate"))))
 '(font-lock-doc-face ((t (:foreground "#036A07"))))
 '(font-lock-function-name-face ((t (:weight normal :foreground "#006699"))))
 '(font-lock-keyword-face ((t (:weight normal :foreground "#0000FF"))))
 '(font-lock-negation-char-face ((t (:weight normal :foreground "#000000"))))
 '(font-lock-preprocessor-face ((t (:foreground "#808080"))))
 '(font-lock-regexp-grouping-backslash ((t (:weight bold :inherit nil))))
 '(font-lock-regexp-grouping-construct ((t (:weight bold :inherit nil))))
 '(font-lock-string-face ((t (:foreground "green3"))))
 '(font-lock-type-face ((t (:weight normal :foreground "#6434A3"))))
 '(font-lock-variable-name-face ((t (:weight normal :foreground "#BA36A5"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "red"))))
 '(button ((t (:underline (:color foreground-color :style line) :background "#dddddd" :foreground "#006DAF"))))
 '(link ((t (:weight normal :underline (:color foreground-color :style line) :foreground "#006DAF"))))
 '(link-visited ((t (:underline (:color foreground-color :style line) :foreground "#E5786D"))))
 '(fringe ((t (:foreground "#4C9ED9" :background "gray90"))))
 '(linum ((t (:foreground "black" :background "gray90"))))
 '(header-line ((t (:box (:line-width 1 :color "black" :style nil) :foreground "black" :background "#F0F0F0"))))
 '(tooltip ((t (:foreground "black" :background "light yellow"))))
 '(mode-line ((t (:box (:line-width 1 :color "#1A2F54" :style nil) :foreground "#85CEEB" :background "#335EA8"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "white"))))
 '(mode-line-emphasis ((t (:weight bold :foreground "white"))))
 '(mode-line-highlight ((t (:foreground "yellow"))))
 '(mode-line-inactive ((t (:box (:line-width 1 :color "#4E4E4C" :style nil) :foreground "#F0F0EF" :background "#9B9C97"))))
 '(isearch ((t (:underline (:color "black" :style line) :foreground "white" :background "#5974AB"))))
 '(isearch-fail ((t (:weight bold :foreground "black" :background "#FFCCCC"))))
 '(lazy-highlight ((t (:foreground "black" :background "#FFFF00"))))
 '(match ((t (:weight bold :background "#FFFF00"))))
 '(next-error ((t (:height 1.1 :underline nil :foreground "white" :background "#9E3699"))))
 '(query-replace ((t (:inherit (isearch)))))

 '(tabbar-default ((t (:inherit (default)
                               :height 0.9
                               :foreground "black"
                               :background "gray60"
                               :box nil; '(:line-width 1 :color "white" :style nil)
                               ))))
 
 ;; not selected
 '(tabbar-unselected ((t (:inherit (tabbar-default)
                                   :background "grey80"
                                   :foreground "black"
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
                                          :foreground "#ff5526"
                                          :weight normal) )))
 
 '(tabbar-unselected-modified ((t (:inherit (tabbanr-unselected)  
                                            :foreground "#ff5526" :weight normal) )))

 )

(provide-theme 'ty-lcd-light)
;; (load-theme 'tylcd-light)t
