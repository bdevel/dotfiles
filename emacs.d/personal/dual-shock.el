
;; go to last place edited
;; https://github.com/camdez/goto-last-change.el

;; Doing repeat -- see setvar
;; (setq recenter-last-op
;; (if (eq this-command last-command)
;;     (car (or (cdr (member recenter-last-op recenter-positions))
;;              recenter-positions))
;;   (car recenter-positions)))


(require 'expand-region)
(require 'drag-stuff
)


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

;; foo_bar_BASS
;; ( :foo 'bar .bar  foo.bar )

;; TODO: Doesn't work when symbole is beginning of line
(defun ds-backward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  (setq ds-last-move 'ds-backward-symbol)
  ;; if starting in middle of a symbol, go to end of symbol first
  (let ((sc "[^'^@a-zA-Z0-9_\-!]"))
    (unless (string-match sc (string (preceding-char)) )
      (re-search-forward sc)))

  (re-search-backward "[\s\\(\.\"][\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:\-]*[a-zA-Z0-9]*")

  (ds-temp-mark-region  (match-end 0)
                        (if (member (string (following-char)) '(".") )
                            (+ 0 (match-beginning 0) );; dont forward one if it's a .something
                          (+ 1 (match-beginning 0)) 
                          ))
  )



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
      (let  ((deactivate-mark);; makes the mark not disapear when inserting text. wtf!
             (undo-inhibit-record-point t))
        ;;(undo-boundary)
        (insert
         (prog1 (delete-and-extract-region beg2 end2)
           (goto-char beg2)
           (insert 
            (delete-and-extract-region beg1 end1))
           (goto-char beg1)))
        
        ))))

;; todo: rename
;; (defun ds-drag-region-forward ()
;;   "Cuts region, transposes it with selected object from move-fn."
;;   (interactive)
;;   (let* ((move-fn 'ds-forward-symbol)
;;         (src (cons (region-beginning) (region-end) ))
;;         (dst (save-excursion (call-interactively move-fn)
;;                              (cons (region-beginning)
;;                                    (region-end) )))
;;         ;;(src-text (delete-and-extract-region (car src) (cdr src)))
;;         ;;(dst-text (delete-and-extract-region (car dst) (cdr dst)))
;;         ;; (src-len (- (cdr src) (car src)))
;;         ;; (dst-len (- (cdr dst) (car dst)))
        
;;         ;; (new-start (- (car src)
;;         ;;               (- src-len dst-len) ))

        
;;         (in-same-sexp (save-excursion;; if in same sexp
;;                         (call-interactively 'er/expand-region)
;;                         (and (<= (region-beginning)
;;                                 (car src))
;;                              (<= (region-beginning)
;;                                 (car dst))
                             
;;                              (>= (region-end)
;;                                  (cdr src))
;;                              (>= (region-end)
;;                                  (cdr src)))))
;;         )

;;     (when in-same-sexp

;;         ;; Only do this if they are in the same sexp
;;         (swap-regions (car src) (cdr src)
;;                       (car dst) (cdr dst))
;;       (exchange-point-and-mark)
;;       (push-mark (point) t t)
;;       (goto-char (+ (point)
;;                     (- (cdr src) (car src))  ))
;;       );;when
    
;;     ))

(setq ds-last-drag nil)
(defun ds-same-drag-from-last ()
    "Determines if the current region is the thing that was dragged last."
    (eq ds-last-drag
       (cons (region-beginning)
             (region-end))))

(defun ds-drag-region-to-move (move-fn &optional cleanup-from-cut)
  ""
  ;; cut the text
  ;; move to point
  ;; insert text
  ;; mark region again
  
  (let* ((deactivate-mark nil)
         ;; (from (region-beginning))
         ;; (to (region-end))
         
         (to-paste (prog1 (delete-and-extract-region (region-beginning)
                                                     (region-end) )
                     (if cleanup-from-cut
                         (funcall cleanup-from-cut)
                       (progn (fixup-whitespace)
                              (indent-for-tab-command)))))

         
         (paste-start (progn (funcall move-fn)                           
                             (indent-for-tab-command)
                             (point)))
         )

    (insert to-paste)
    (fixup-whitespace)
    
    (ds-temp-mark-region paste-start
                         (point))
    
    ;; clean up both sides after paste
    ;; 
    ;; (exchange-point-and-mark)
    ;; (fixup-whitespace)
    ;; (exchange-point-and-mark)

    ;; set this so when we call again we know if it's a repeat move
    ;; of the same text
    ;;(setq ds-last-drag (cons (region-beginning)
    ;;                         (region-end)))
    ))


(defun ds-drag-region-up ()
  ""
  (interactive)
  ;; todo: remove line if it's blank after cut
  (ds-drag-region-to-move (lambda ()
                            (previous-line)
                            (beginning-of-line-text)
                            )
                          ;;'delete-blank-lines
                          ))

(defun ds-drag-region-down ()
  ""
  (interactive)
  (ds-drag-region-to-move (lambda ()
                            (next-line)
                            (beginning-of-line-text)
                            (indent-for-tab-command)
                            )))

(defun ds-drag-region-left ()
  ""
  (interactive)
  (ds-drag-region-to-move 'ds-backward-symbol))

(defun ds-drag-region-right ()
  ""
  (interactive)
  (ds-drag-region-to-move 'ds-forward-symbol))



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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;   SHORT CUTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

  (ds-make-shortcut "H-3"  'ds-backward-symbol)
  (ds-make-shortcut "H-4" 'ds-forward-symbol)

  ;; Up
  ;; (ds-make-shortcut "H-3" (lambda ()
  ;;                           (interactive)
  ;;                           ;;(sp-select-next-thing 1)
  ;;                           (call-interactively 'sp-backward-symbol)
  ;;                           ;;(call-interactively 'er/expand-region)
  ;;                           ))
  ;; ;; Down
  ;; (ds-make-shortcut "H-4" (lambda ()
  ;;                           (interactive)
  ;;                           ;;(sp-select-next-thing -1)
  ;;                           (call-interactively 'sp-forward-symbol)
  ;;                           ;;(call-interactively 'er/expand-region)
  ;;                           ))

  ;; more/less
  ;;(ds-make-shortcut "H-`" 'er/expand-region)
  ;;(ds-make-shortcut "H-~" 'er/contract-region)
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
  
  (ds-make-shortcut "H-," 'ds-drag-region-up)
  (ds-make-shortcut "H-." 'ds-drag-region-down)

  (ds-make-shortcut "H-<" 'ds-drag-region-left)
  (ds-make-shortcut "H->" 'ds-drag-region-right)
  )

