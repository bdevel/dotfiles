
;; go to last place edited
;; https://github.com/camdez/goto-last-change.el

;; Doing repeat -- see setvar
;; (setq recenter-last-op
;; (if (eq this-command last-command)
;;     (car (or (cdr (member recenter-last-op recenter-positions))
;;              recenter-positions))
;;   (car recenter-positions)))


(require 'expand-region)
(require 'drag-stuff)
(require 'paredit)

;; TODO:
;; triangle new / insert, tap again to change from parens to quotes, square brackets,
;; x - Kill
;; O - Yank
;; Square. meta x
;;
;; Dragging Stuff:
;;   SELECTED ITEM    LEFT                          RIGHT                                  UP/DOWN
;;      Symbol          Swap with prev symbol           Swap with next symbol.                Move to prev/next line, insert.
;;      Sexp, String    Swap with prev symbol/sexp      Swap with next symbol/sexp.           Move to prev/next line, insert.
;;      Paragraph       Swap with prev paragraph/defn   Swap with next paragraph/defn         Same
;;       (begin of line + multilines)

;; Coding tips, Put comments for classes, defns, large bodies, inside the definition
;; so that you can move the comments with the object.




;;;;;;;;;;;;;;;;;;;;;;; Helpers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ds-cleanup-around-here ()
  "adds commas if nessiary, cleans up extra white space"
  ;; TODO: do the rest of the code
  (just-one-space)
  )


;;;;;;;;;;;;;;;;;;;;;;; Verbs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ds-kill-this-thing (start end)
  "Cleanly kill region if active, else thing under cursor"
  (interactive "r")

  (unless (region-active-p);;use-region-p
    (call-interactively 'er/expand-region)
    ;; (if (member (string (following-char)) '("'" "\"" "{" "(") )
    ;;     (progn
    ;;       (message "@222")
    ;;       (er/expand-region))
    ;;   (progn
    ;;     (messag "for sym")
    ;;     (call-interactively 'ds-forward-symbol))) 
    )

  ;;(call-interactively 'kill-region)
  (kill-region (region-beginning) (region-end))

  ;; (unless (member  ds-last-move '('ds-forward-symbol 'ds-backward-symbol) )
  ;;   (funcall-interactively ds-last-move)
  ;;   ;; todo: clean up white space if between symbols
  ;;   (setq deactivate-mark  nil)    
  ;;   )

  )


(defun what-face ()
  "returns list of faces applied under point"
  ;;(interactive)
  ;; (let ((face (or (get-char-property (point) 'read-face-name)
  ;;                 (get-char-property (point) 'face))))
  ;;   (print face)
  ;;   face)
  (let ((face (get-char-property (point) 'face)))
    (if  (listp face) face (list face) ))
  )

(defun location-after-move (move-fn)
    "Give a list of moves, then returns cursor location after applied."
    (save-excursion
      (call-interactively move-fn)
      ;;(move-fn)
      (point)))


;; (apply 'min (mapcar 'location-after-move '(forward-char forward-symbol)))
;;(remove-if-not (lambda (v) (> v (point))) (mapcar 'location-after-move '(forward-char forward-symbol)))


(defun nearest-next (fns)
  ""
  (let* ((move-locs (remove-if-not (lambda (v) (> v (point)))
                                   (mapcar 'location-after-move fns)))
         ;;(xx (print (point)))
         ;;(xx (print move-locs))
         (nearest-pos (apply 'min move-locs)))
    nearest-pos))


(defun nearest-prev (fns)
  ""
  (let* ((move-locs (remove-if-not (lambda (v) (< v (point)))
                               (mapcar 'location-after-move fns)))
         (nearest-pos (apply 'max move-locs)))
    nearest-pos))

(defun goto-nearest-next (fns)
  ""
  (goto-char (nearest-next fns)))

(defun goto-nearest-prev (fns)
  ""
  (goto-char (nearest-prev fns)))




(defun region-boundry-chars ()
    "What are the chars that are on the outside of the region. For a paragraph it's \n\n"
    (let* ((cbrb (string (char-before (region-beginning))));; ( "
           (care (string (char-after (region-end))))) ;; ) "
           (concat cbrb care)
           ))

(defun region-wrapper-chars ()
  "What are the chars that are on the inside of the region. For a sexp it's ()"
  (let* ((carb (string (char-after (region-beginning))));; ( "
         (cbre (string (char-before (region-end)))) );; ) "
         (concat carb cbre)
         ))



(defun ds-region-at-end-of-list ()
  ""
  (member (string (char-after (region-end)))
          '(")" "]" "\"" "'" "}")))

(defun ds-region-at-start-of-list ()
  ""
  (member (string (char-before (region-beginning)))
          '("(" "[" "\"" "'" "{")))



(defun region-is-sexp ()
  ""
  (let* ((wrapper (region-wrapper-chars)) );; whitespace    
    (or
     (equal"{}"    wrapper)
     (equal "()"   wrapper)
     (equal "\"\"" wrapper)
     (equal "''"   wrapper)
     (equal "#}"   wrapper)
     
     )))

(defun region-is-item ()
  "Determines if region is a small thing in a list of things."
  (let* ((boundry (region-boundry-chars)) );; whitespace    
    (or
     (equal"  "    boundry);; foo BAR baz

     (equal "( " boundry);; (FOO bar
     (equal "(," boundry);; (FOO, bar

     (equal " )" boundry);; foo BAR)
     (equal ",)" boundry);; foo,BAR)

     ;; quoted symbol
     (equal "')" boundry);; foo 'BAR)
     (equal "' " boundry);; foo 'BAR baz)
     (equal "'," boundry (comment "foo 'BAR, baz"))

     (equal " \n" boundry);; is indented line
     ;;(equal "\n\n" boundry);; this one might cause problems with paragraph
     
     )))


(defun region-is-paragraph ()
  "Determines if region has newlines on either side."
  (let* ((boundry (region-boundry-chars)) );; whitespace    
    (or
     (equal "\n\n"    boundry)
     (and (eobp) (bobp))
     )))


;; (defun sp-next-paragraph ()
;;   "TODO Must  be beol though, need better white space detection for Ruby def"
;;   (call-interactively 'ds-forward-symbol)
;;   (while (not (region-is-paragraph))
;;     (call-interactively 'er/expand-region))  
;;   )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ds-temp-region ()
  "Enables exiting region left or right by using arrow keys. Also allows buffer undo with active region."
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     ;;(define-key map [switch-frame] #'ignore)
     (define-key map (kbd "<left>") 'ds-exit-region-left)
     (define-key map (kbd "<right>") 'ds-exit-region-right)
     (define-key map (kbd "<up>") 'ds-exit-region-left)
     (define-key map (kbd "<down>") 'ds-exit-region-right)

     ;; Able to undo outside of selected region..
     (define-key map (kbd "C-/") 'ds-undo)
     (define-key map (kbd "C-_") 'ds-undo)
     (define-key map (kbd "C-x u") 'ds-undo)

     map)
   )
  )

(defun ds-temp-mark-region (start end)
  "Marks an active region, then calls ds-temp-region"
  ;;(setq ds-last-region (cons (region-beginning) (region-end) ))
  (push-mark start t t)
  (goto-char end)
  (activate-mark);; tt should activate it though..
  (ds-temp-region)
  )

(defun ds-exit-region-left ()
  "If a buffer is active, then move point to beginning of region."
  (interactive)
  (when (use-region-p)
    (goto-char (region-beginning) )
    (deactivate-mark)))

(defun ds-exit-region-right ()
  "If a buffer is active, then move point to end of region."
  (interactive)
  (when (use-region-p)
    (goto-char (region-end) )
    (deactivate-mark)))



(defun ds-undo ()
  "Undos without reguards to active region. Goes back and marks previously selected region."
  (interactive)
  (print "Doing DS Undo")
  (deactivate-mark)
  (undo)

  ;; This only works once...
  ;; This would require logging all marks with every undo state. Do later. 

  ;; (when ds-last-region
  ;;   (ds-temp-mark-region (car ds-last-region) (cdr ds-last-region))
  ;;   )
  )

;;;;;;;;;;;;; Buffers ;;;;;;;;;;;;;;;;;;

(defun ds-next-buffer ()
  "goes to next buffer"
  (setq ds-last-move 'ds-next-buffer)
  (previous-buffer)
  )


;;;;;;;;;;;;; Symbol ;;;;;;;;;;;;;;;;;;

(defun ds-mark-symbol ()
  "Marks symbol under cursor"
  (interactive)
  ;; if starting in middle of a symbol, go to begining of symbol first
  (unless (string-match "[^'^@a-zA-Z0-9_\-!]" (string (following-char)))
    (re-search-backward "[\s\\(\.\\s-\"]"))

  ;; look for a symbol
  ;; Don't select words ending in colons, as in with javascript foo: function()

  (if (member major-mode '(clojure-mode elisp-mode))
      (re-search-forward "[\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:-]*[a-zA-Z0-9]+")
    (re-search-forward "[\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:-]*[a-zA-Z0-9]+"))
  
  
  (ds-temp-mark-region (match-beginning 0)
                       (match-end 0))
  )

(defun ds-forward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  ;; search forward for boundry incase starting in the middle of a word/symbol
  ;; if starting in middle of a symbol, go to begining of symbol first
  (unless (string-match "[^'^@a-zA-Z0-9_\-!]" (string (following-char)))
    (re-search-backward "[\s\\(\.\\s-\"]"))

  ;; look for a symbol
  (re-search-forward "[\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:-]*[a-zA-Z0-9]*")
  (ds-temp-mark-region (match-beginning 0)
                       (match-end 0))
  )


;; TODO: Doesn't work when symbole is beginning of buffer
(defun ds-backward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  (setq ds-last-move 'ds-backward-symbol)
  ;; if starting in middle of a symbol, go to end of symbol first
  (let ((sc "[^'^@a-zA-Z0-9_\-!]"))
    (unless (string-match sc (string (preceding-char)) )
      (re-search-forward sc)))

  (re-search-backward "[\s\n\\(\.\"][\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:\-]*[a-zA-Z0-9]*")

  (ds-temp-mark-region  (match-end 0)
                        (if (member (string (following-char)) '(".") )
                            (+ 0 (match-beginning 0) );; dont forward one if it's a .something
                          (+ 1 (match-beginning 0)) 
                          ))
  )



;;;;;;;;;;;;;;;;;;;;;;; SEXP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; LEFT => UP
;; Right => Down
;; Up => backward
;; Down => forward


;; (defun ds-sexp-up ()
;;   ""
;;   (interactive)
;;   ;;"Finds next string () {}. Automaticaly steps into and out of expressions."
;;   ;;(call-interactively 'sp-forward-sexp);; Move forward across one balanced expression.

;;   (ds-exit-region-left)
;;   (call-interactively 'sp-previous-sexp);; Move forward to the beginning of next balanced expression.
;;   (call-interactively 'er/expand-region)
;;   (ds-temp-region)
;;   )


;; (defun ds-sexp-down ()
;;   ""
;;   (interactive)
;;   ;;"Finds next string () {}. Automaticaly steps into and out of expressions."
;;   ;;(call-interactively 'sp-forward-sexp);; Move forward across one balanced expression.

;;   (ds-exit-region-right)
;;  ;; (goto-nearest-next '(sp-forward-sexp sp-next-sexp))
;;   ;;(call-interactively 'sp-next-sexp);; Move forward to the beginning of next balanced expression.
;;   ;;(call-interactively 'sp-forward-parallel-sexp)
;;   (call-interactively 'sp-beginning-of-next-sexp)
;;   (call-interactively 'er/expand-region)
;;   (ds-temp-region)
;;   )



(defun ds-point-of-re-search-forward-skip-faces (r skip-faces)
  "Search backwards,"
  (save-mark-and-excursion
   (if (re-search-forward r nil t 1)
       (if (and (not (eobp)) (cl-intersection (what-face) skip-faces)) ;; todo: may need to check if 
           (progn (goto-char (match-end 0))
                  (ds-point-of-re-search-forward-skip-faces r skip-faces))
         (match-end 0))
     nil)
   ))

(defun ds-point-of-re-search-backward-skip-faces (r skip-faces)
  "Search backwards, ignoring things with skip-faces"
  (save-mark-and-excursion
   (if (re-search-backward r nil t 1)
       (if (and (not (bobp)) (cl-intersection (what-face) skip-faces)) ;; todo: may need to check if 
           (progn (goto-char (match-beginning 0))
                  (ds-point-of-re-search-backward-skip-faces r skip-faces))
         (match-beginning 0))
     nil)
   ))


(defun ds-goto-nearest-re-search-forward (re-list)
  "" 
  (let* ((skip-faces '(font-lock-doc-face font-lock-string-face font-lock-comment-face))
         (move-locs (remove-if-not (lambda (l) (or (not (equal l nil)) )) ;; (< l (point)
                                   (mapcar (lambda (r) (ds-point-of-re-search-forward-skip-faces r skip-faces))
                                           re-list)))
         
         (nearest-loc (if (< 0 (length move-locs))
                          (apply 'min move-locs)
                        nil)))
    
    (print move-locs)
    (print nearest-loc)
    (if nearest-loc
        (goto-char nearest-loc)
      nil)
    ))


(defun ds-goto-nearest-re-search-backward (re-list)
  "" 
  (let* ((skip-faces '(font-lock-doc-face font-lock-string-face font-lock-comment-face))
         (move-locs (remove-if-not (lambda (l) (or (not (equal l nil)) )) ;; (< l (point)
                                   (mapcar (lambda (r) (ds-point-of-re-search-backward-skip-faces r skip-faces))
                                           re-list)))
         
         (nearest-loc (if (< 0 (length move-locs))
                          (apply 'max move-locs)
                        nil)))
    
    (print move-locs)
    (print nearest-loc)
    (if nearest-loc
        (goto-char nearest-loc)
      nil)
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SEXP Movement ;;;;;;;;;;;;;;;;;;

(defun ds-forward-sexp ()
  ""
  (interactive)
  (ds-exit-region-left)
  (forward-char)
  (if (ds-goto-nearest-re-search-forward (append (list (regexp-quote "(")
                                                   (regexp-quote "'(")
                                                   (regexp-quote "{")
                                                   (regexp-quote "#{")
                                                   (regexp-quote "#(")
                                                   (regexp-quote "#'(")
                                                   )
                                                 (list "\b\"" ) ));; todo: add matcher for 'foo'
      (progn
        (backward-char)
        (call-interactively 'er/expand-region)
        (ds-temp-region)
        (ds-point-to-start-region))
    (progn
      (backward-char))
    )
  )

(defun ds-backward-sexp ()
  ""
  (interactive)
  (ds-exit-region-right)
  (backward-char)
  (if (ds-goto-nearest-re-search-backward (append (list "\)";;(regexp-quote ")")
                                                        "\}" ;;(regexp-quote "}")
                                                        )
                                                  (list "\"\b") ))
      (progn
        (forward-char)
        (call-interactively 'er/expand-region)
        (ds-temp-region)
        (ds-point-to-end-region)
        )
    (progn
      ;; Go back to where they were
      (forward-char)
      ;; (call-interactively 'er/expand-region)
      ;; (ds-temp-region)
      ;; (ds-point-to-start-region))
      )))




;; (defun ds-sexp-left ()
;;   ""
;;   (interactive)
;;   (ds-exit-region-left)
;;   (call-interactively 'sp-backward-sexp);; Move forward to the beginning of next balanced expression.
;;   (call-interactively 'er/expand-region)
;;   (ds-temp-region)
;;   )

;; (defun ds-sexp-right ()
;;   ""
;;   (interactive)
;;   (ds-exit-region-right)
;;   (goto-nearest-next '(sp-backward-sexp))
;;   (call-interactively 'sp-backward-sexp);; Move forward to the beginning of next balanced expression.
;;   (call-interactively 'er/expand-region)
;;   (ds-temp-region)
;;   )





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; REGION  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; From https://www.emacswiki.org/emacs/SwapRegions
(defun swap-regions (beg1 end1 beg2 end2)
  "Swap region between BEG1 and END1 with region BEG2 and END2.

For the first region, mark the first region and set mark at
point.  The second region only needs to be marked normally.
Again, set the mark at the beginning and end of the first region,
then mark the second region with mark and point.

The order of the two regions in the buffer doesn't matter.
Either one can precede the other.  However, the regions can not
be swapped if they overlap.

All arguments can either be a number for a position in the buffer
or a marker."
  ;;(interactive)
  (if (or (and (< beg2 beg1) (< beg1 end2))
          (and (< beg1 beg2) (< beg2 end1)))
      (error "Unable to swap overlapping regions")
    (save-excursion
      (let  ((deactivate-mark)
             (undo-inhibit-record-point t))
        ;;(undo-boundary)
        (insert
         (prog1 (delete-and-extract-region beg2 end2)
           (goto-char beg2)
           (insert 
            (delete-and-extract-region beg1 end1))
           (goto-char beg1)))
        
        ))))


(defun ds-point-to-start-region ()
    "If the point is greater than region-beginning, then exchange point and mark."
    (if (> (point) (region-beginning))
        (exchange-point-and-mark)))

(defun ds-point-to-end-region ()
  "If the point is greater than region-beginning, then exchange point and mark."
  (if (> (region-end) (point))
      (exchange-point-and-mark)))

(defun ds-insert-activate-region (to-paste)
  "Inserts text at current point and marks it with"
  (let* ((start-loc (point)))
    (insert to-paste)
    (ds-temp-mark-region start-loc (+ start-loc (length to-paste)))
    
    ))


(defun ds-swap-region-with-next-selection (select-fn)
  ""
  (let* ((curr-reg (list (region-beginning) (region-end)))
         (dest-reg (save-excursion
                     (ds-exit-region-right)
                     (call-interactively select-fn)
                     (list (region-beginning) (region-end))))

         (beg1 (first curr-reg))
         (end1 (second curr-reg))
         
         (beg2 (first dest-reg))
         (end2 (second dest-reg))

         (len1 (- end1 beg1))
         (len2 (- end2 beg2))
         (gap (- beg2 end1))
         
         (reg-beg (+ beg1 len2 gap))
         (reg-end (+ reg-beg len1))
         )
    
    (swap-regions beg1 end1 beg2 end2)
    
    (ds-temp-mark-region reg-beg reg-end)
    nil
    ))


(defun ds-swap-region-with-prev-selection (select-fn)
  ""
  (let* ((curr-reg (list (region-beginning) (region-end)))
         (dest-reg (save-excursion
                     (ds-exit-region-left)
                     (call-interactively select-fn)
                     (list (region-beginning) (region-end))))

         (beg1 (first curr-reg))                                           
         (end1 (second curr-reg))
         
         (beg2 (first dest-reg))
         (end2 (second dest-reg))

         (len1 (- end1 beg1))
         ;; (len2 (- end2 beg2))
         ;; (gap (- beg2 end1))
         
         (reg-beg beg2)
         (reg-end (+ reg-beg len1))
         )
    ;; (print beg1)
    ;; (print end1)
    ;; (print beg2)
    ;; (print end2)
    (swap-regions  beg2 end2 beg1 end1)
    
    (ds-temp-mark-region reg-beg reg-end)
    nil
    ))

(defun ds-move-region-before-next-selection (select-fn)
  "Use for inserting something at beginning of list."
  (let* ((deactivate-mark)
         (undo-inhibit-record-point t)
         (to-paste (prog1 (delete-and-extract-region (region-beginning) (region-end))
                     (fixup-whitespace)))
         (start-loc (save-excursion (call-interactively select-fn)
                                    (ds-exit-region-left)
                                    (point))))
    
    (goto-char start-loc)
    (insert to-paste)
    (just-one-space)
    (ds-temp-mark-region start-loc (+ start-loc (length to-paste)))
    
    nil
    ))

(defun ds-move-region-after-next-selection (select-fn)
  "Used to move symbol to end of list."
  (let* ((deactivate-mark)
         (undo-inhibit-record-point t)
         (to-paste (delete-and-extract-region (region-beginning) (region-end)))
         )
    (fixup-whitespace)
    (call-interactively select-fn)
    (ds-exit-region-right)
    (just-one-space)
    (ds-insert-activate-region to-paste)
    (ds-point-to-start-region)
    nil
    ))


(defun ds-swap-foward-selection (move-fn)
  "Assuming an active region, swap with selection from move-fn. Handles forward moves."
  (let* ((do-other (save-mark-and-excursion
                    (call-interactively move-fn)
                    (ds-region-at-start-of-list)
                    )
                   ))
    (print "do other")
    (print do-other)
    (if do-other;; new selection is at start of list
        (ds-move-region-before-next-selection move-fn);; insert infront of the new selection
      (ds-swap-region-with-next-selection move-fn);; safe to actually swap
        )
    ))

(defun ds-swap-backward-selection (move-fn)
  "Assuming an active region, swap with selection from move-fn. Handles backward moves."
  (let* ((do-other (save-mark-and-excursion
                    (call-interactively move-fn)
                    (ds-region-at-end-of-list)
                    )))
    (if do-other;; new selection is at end of list
        (ds-move-region-after-next-selection move-fn);; move region to end of next selection
      (ds-swap-region-with-prev-selection move-fn);; else, swap into other sexp
      )
    ))

(defun ds-swap-forward-symbol ()
  (interactive)
  (ds-swap-foward-selection 'ds-forward-symbol))

(defun ds-swap-backward-symbol ()
  (interactive)
  (ds-swap-backward-selection 'ds-backward-symbol))

(defun ds-swap-forward-sexp ()
  (interactive)
  (ds-swap-foward-selection 'ds-forward-sexp)
  nil)

(defun ds-swap-backward-sexp ()
  (interactive)
  (ds-swap-backward-selection 'ds-backward-sexp)
  nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Dragging ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ds-drag-region-down ()
  "Determines what is selected, the does appropriate moveing and swaping of thing."
  (cond
   ((ds-region-is-item) (ds-swap-symbol-forward))
   ((ds-region-is-sexp) (ds-swap-symbol-forward))
   
   (t nil)
   ))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;   Keyboard Map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ds-make-shortcut (keys to-call)
  "shortcut-helper"
  (global-set-key (kbd keys) to-call))


;; Disable this as caps has been remapped to home
;;(global-unset-key (kbd "C-<home>"))
;;(global-set-key (kbd "C-<home>") nil)
;;(global-set-key (kbd "C-\]") nil)

;; ;;(global-set-key (kbd "C-\\") nil)

;; (global-set-key (kbd "C-;") nil)
;; (global-set-key (kbd "C-'") nil)

;; (global-set-key (kbd "C-d") nil)

(progn
  ;; using obscure shortcuts

  ;; Up Down
  (ds-make-shortcut "H-3"  'ds-backward-symbol)
  (ds-make-shortcut "H-4" 'ds-forward-symbol)

  ;;(ds-make-shortcut "H-3"  'ds-prev-thing)
  ;;(ds-make-shortcut "H-4" 'ds-next-thing)  
  
  
  
  ;; Up
  ;; Left
  (ds-make-shortcut "H-`" (lambda () 
                            (interactive)
                            (call-interactively 'er/expand-region)
                            (ds-temp-region)))

  ;; Right
  (ds-make-shortcut "H-~" (lambda () 
                            (interactive)
                            (call-interactively 'er/contract-region)
                            (ds-temp-region)))

  ;; (ds-make-shortcut "H-<" (lambda () 
  ;;                           (interactive)
  ;;                           (ds-drag-region-to-move 'ds-backward-symbol)
  ;;                           ;;(smart-shift-right 1)
  ;;                           ))
  


  ;; (ds-make-shortcut "H-3" (lambda () 
  ;;                           (interactive)
  ;;                           (call-interactively 'ds-exit-region-left)
  ;;                           (call-interactively 'sp-up-sexp)
  ;;                           (call-interactively 'er/expand-region)
  ;;                           (ds-temp-region)))

  ;; (ds-make-shortcut "H-4" (lambda () 
  ;;                           (interactive)
  ;;                           (call-interactively 'ds-exit-region-right)
  ;;                           (call-interactively 'sp-down-sexp)
  ;;                           (call-interactively 'er/expand-region)
  ;;                           (exchange-point-and-mark)
  ;;                           (ds-temp-region)))

  ;; (ds-make-shortcut "H-`" (lambda () 
  ;;                           (interactive)
  ;;                           (call-interactively 'ds-exit-region-left)
  ;;                           (call-interactively 'sp-backward-sexp)
  ;;                           (call-interactively 'er/expand-region)
  ;;                           (ds-temp-region)))

  ;; (ds-make-shortcut "H-~" (lambda () 
  ;;                           (interactive)
  ;;                           (call-interactively 'ds-exit-region-right)
  ;;                           (call-interactively 'sp-forward-sexp)
  ;;                           (call-interactively 'er/expand-region)
  ;;                           (exchange-point-and-mark)
  ;;                           (ds-temp-region)))


  ;; RIGHT JOYSTICK
  ;; (ds-make-shortcut "H-," 'ds-drag-region-up)
  ;; (ds-make-shortcut "H-." 'ds-drag-region-down)

  ;; (ds-make-shortcut "H-<" 'ds-drag-region-left)
  ;; (ds-make-shortcut "H->" 'ds-drag-region-right)

  
  (ds-make-shortcut "H-," 'ds-swap-backward-symbol)
  (ds-make-shortcut "H-." 'ds-swap-forward-sexp)

  (ds-make-shortcut "H-<" 'ds-swap-backward-symbol)
  (ds-make-shortcut "H->" 'ds-swap-forward-symbol)

  

  )
