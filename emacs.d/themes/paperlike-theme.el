(deftheme paperlike
  "For use with Paperlike E-Ink monitor in A2 or A5 mode.")


;; Paperlike has A5 for five shades of grey and A2 for two colors
;;
;; A2 Mode
;;  < grey 67 then black 
;; 	> grey67 then white
;;
;; A5 mode:
;;   > grey80 is white
;;     grey79 looks good
;;     grey70 looks ok
;;   	 grey69 is tiny vertical lines
;; 	 < grey50 is black
(set 'a5-grey0 "grey0")
(set 'a5-grey1 "grey40")
(set 'a5-grey2 "grey45")  
(set 'a5-grey3 "grey79") (set 'a5-light-grey a5-grey3)
(set 'a5-grey4 "grey100")



(custom-theme-set-faces
 'paperlike
 '(default ((t (:family "OCR A Std"
                :foundry "nil" 
                :width normal 
                :height 150 
                :weight normal 
                :slant normal 
                :underline nil 
                :overline nil 
                :strike-through nil 
                :box nil 
                :inverse-video nil 
                :foreground "#000000" 
                :background "#ffffff" 
                :stipple nil 
                :inherit nil))))

 '(cursor ((t (:background "#000000"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:font "-outline-Arial-normal-normal-normal-sans-*-*-*-*-p-*-iso8859-1")) (t (:family "Sans Serif"))))
 '(escape-glyph ((t (:weight bold :foreground "grey0"))))
 '(minibuffer-prompt ((t (:height 1.0 :foreground "grey0"))))
 '(highlight ((t (:underline (:color foreground-color :style line) :foreground "#ffffff" :background "grey79"))))
 '(region ((t (:foreground "grey0" :background "grey79"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:foreground "#f6f3e8" :background "grey79"))))
 '(trailing-whitespace ((t (:background "grey40"))))
 '(font-lock-builtin-face ((t (:weight bold :foreground "grey0"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "grey45" :inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:weight normal :foreground "grey40"))))
 '(font-lock-constant-face ((t (:weight bold :foreground "grey0"))))
 '(font-lock-doc-face ((t (:weight bold :foreground "grey45" :inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:weight normal :foreground "grey0"))))
 '(font-lock-keyword-face ((t (:weight bold :foreground "grey0"))))
 '(font-lock-negation-char-face ((t (:weight bold :foreground "grey0"))))
 '(font-lock-preprocessor-face ((t (:foreground "grey40" :inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:weight bold :foreground "grey40" :inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:weight bold :foreground "grey0" :inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "grey45"))))
 '(font-lock-type-face ((t (:weight normal :underline (:color foreground-color :style line) :foreground "grey40"))))
 '(font-lock-variable-name-face ((t (:weight normal :foreground "grey0"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "grey40"))))
 '(button ((t (:underline (:color foreground-color :style line) :foreground "#f6f3e8" :background "#333333"))))
 '(link ((t (:weight bold :underline (:color foreground-color :style line) :foreground "grey0"))))
 '(link-visited ((t (:weight normal :underline (:color foreground-color :style line) :foreground "grey40"))))
 '(fringe ((t (:foreground "grey100" :background "grey80"))))
 '(header-line ((t (:foreground "#e7f6da" :background "#303030" :inherit (mode-line)))))
 '(tooltip ((((class color)) (:background "lightyellow" :foreground "black" :inherit (variable-pitch))) (t (:inherit (variable-pitch)))))
 '(mode-line ((t (:height 1.0 :box nil :background "grey79"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "grey79"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:height 1.0 :box nil :foreground "grey100" :background "grey45"))))
 '(isearch ((t (:weight bold :foreground "grey40" :background "grey45"))))
 '(isearch-fail ((t (:foreground "grey0" :background "grey45"))))
 '(lazy-highlight ((t (:weight bold :foreground "grey40" :background "grey79"))))
 '(match ((t (:weight bold :foreground "grey40" :background "grey100"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))




 '(linum ((t ( :background "grey79" :foreground "black" ))))

 '(tabbar-default ((t (
                       :foreground "black"
                                   :box nil
                                   :weight bold
                                   :background "white"
                                   ))))
 ;; selected
 '(tabbar-selected ((t (:inherit (tabbar-default)  
                                 :foreground "black"
                                 ))))

 ;; not selected
 '(tabbar-unselected ((t (:inherit (tabbar-default)  
                                   :background "grey79";;a5-grey4
                                   :foreground "black" 
                                   ;;:underline (:color "black")
                                   ;;:box  nil;'(:line-width 3 :color "yellow" :style "released-button")
                                   ))))

 '(tabbar-separator ((t (:background "black" :height 0.6))))

 '(tabbar-selected-modified ((t (:inherit (tabbar-selected)  
                                          :weight normal) )))
 
 '(tabbar-unselected-modified ((t (:inherit (tabbar-unselected)  
                                            :weight normal) ))) 




)

(provide-theme 'paperlike)
