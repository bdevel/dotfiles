;; ideas: * use sticky keys for mac kbd.  c-1 c-9 or c-!  c-@ * make a way to
;; go see another area in the same buffer by splitting the window in half and
;; switch frames easily.  * Fwd/bwd defun/defn/def foo/function
;; ()/etc... searches then puts it at the top of the screen. Can scroll fast *
;; "return" button does M-j if in code, otherwise enter.  * Code is always
;; formatted. Start first with aligning arguments.
;;
;; * Hitting enter will indent properly and may put in two newlines
;;   if doing <enter> before a ) as to supply an argument

;; * + cursor button looks for marked region and adds cursor
;; * Add macro based on last N command calls, show history, capture backwards

;; go to last place edited
;; https://github.com/camdez/goto-last-change.el

;; Doing repeat -- see setvar
;; (setq recenter-last-op
;; (if (eq this-command last-command)
;;     (car (or (cdr (member recenter-last-op recenter-positions))
;;              recenter-positions))
;;   (car recenter-positions)))


(require 'expand-region)
;;(require 'move-text)
(setq ty-last-move nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       Nouns
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun move-and-mark (next-fn prev-fn)
  ""
  ;; (let (start-point (point))
  ;;   (apply prev-fn)
  ;;   (push-mark (point) t t)
  ;;   (apply next-fn)
  ;;   ;; If in the same point where we started
  ;;   (when (eq start-point (point))
  ;;     (apply next-fn)
  ;;     (apply prev-fn)
  ;;     (push-mark (point) t t)
  ;;     (apply next-fn)
  ;;     )
  ;;   )
  ;;  (apply next-fn)
  )



;;;;;;;; Strings ;;;;;;;

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


(defun ty-mark-next-face (&rest ok-faces)
  "asdf"
  
  ;; Move to beginning of in the middle
  (if (cl-intersection ok-faces (what-face))
      (while (cl-intersection ok-faces (what-face))
        (backward-char))
    )

  ;; Move until start
  (while
      (not
       (cl-intersection ok-faces (what-face)))
    (forward-char))
  
  (push-mark (point) t t)

  ;; Move until end
  (while
      (cl-intersection ok-faces (what-face))
    (forward-char))
  (ty-temp-mark-thing)
  )

(defun ty-mark-prev-face (&rest ok-faces)
  "asdf"
  
  ;; Move to beginning of in the middle
  (if (cl-intersection ok-faces (what-face))
      (while (cl-intersection ok-faces (what-face))
        (forward-char))
      )

  ;; Move until start
  (while
   (not
    (cl-intersection ok-faces (what-face)))
   (backward-char))
  
  (forward-char);; go forward to capture the quote
  (push-mark (point) t t)

  ;; ;; Move until end
  (backward-char)
  (while
      (cl-intersection ok-faces (what-face))
    (backward-char))
  (forward-char);; Keep cursor on the edge of the quote
  (ty-temp-mark-thing)

  )

(defun ty-next-quoted-string ()
  "Looks forward for quoted string"
  (interactive)

  ;; (unless (string-match "[^'^@a-zA-Z0-9_\-!]" (string (following-char)))
  ;;   (re-search-backward "[\s\\(\.\\s-\"]"))

  ;; (ty-exit-region-right)

  ;; ;; look for a symbol
  ;; (re-search-forward (rx "\"" (group (0+ (or (1+ (not (any "\"" "\\"))) (seq "\\" anything)))) "\"") )
  ;; (push-mark (match-beginning 0) t t)
  ;; (goto-char (match-end 0))
  ;; (ty-temp-mark-thing)
  
  (ty-mark-next-face 'font-lock-doc-face 'font-lock-string-face)


  ;; (ty-exit-region-left)
  ;; (forward-char)

  ;; (search-forward "\"")
  ;; (backward-char)
  ;; (push-mark (point) t t)

  ;; ;;(forward-list nil)
  ;; ;;(exchange-point-and-mark)
  ;; (mark-sexp)
  ;; (ty-temp-mark-thing)


  )

(defun ty-prev-quoted-string ()
  "Looks backward for quoted string"
  (interactive)
  
  ;; (unless (string-match "[^'^@a-zA-Z0-9_\-!]" (string (following-char)))
  ;;   (re-search-backward "[\s\\(\.\\s-\"]"))

  ;; (ty-exit-region-left)

  ;; ;; look for a symbol
  ;; (re-search-backward (rx "\"" (group (0+ (or (1+ (not (any "\"" "\\" "\n"))) (seq "\\" anything)))) "\"") )
  ;; (push-mark (match-end 0) t t)
  ;; (goto-char (match-beginning 0))
  ;; (ty-temp-mark-thing)
  (ty-mark-prev-face 'font-lock-doc-face 'font-lock-string-face)

  )


(global-set-key (kbd "C-0") 'ty-next-quoted-string)
(global-set-key (kbd "C-9") 'ty-prev-quoted-string)



;;;;;;;;;;;; Paragraphs ;;;;;;;;;;;

(defun ty-next-paragraph ()
  "Goes to and marks the next paragraph"
  (interactive)
  (setq ty-last-move 'ty-next-paragraph)
  
  (ty-exit-region-right)
  (forward-paragraph)
  (push-mark (point) t t)
  (backward-paragraph)
  (exchange-point-and-mark)
  (ty-temp-mark-thing)

  )

(defun ty-prev-paragraph ()
  ""
  (interactive)
  (setq ty-last-move 'ty-prev-paragraph "foobar")
  (ty-exit-region-left)
  (backward-paragraph)
  (push-mark (point) t t)
  (forward-paragraph)
  (exchange-point-and-mark)
  (ty-temp-mark-thing)
  ) 

;;;;;;;;;;;;; Buffers ;;;;;;;;;;;;;;;;;;

(defun ty-next-buffer ()
    "goes to next buffer"
    (setq ty-last-move 'ty-next-buffer)
    (previous-buffer)
  )


;;;;;;;;;;;;; Parens ;;;;;;;;;;;;;;;;e;;

(defun ty-next-parens-outside ()
  "goes to and marks the next parens"
  (interactive)
  (setq ty-last-move 'ty-next-parens-outside)
  (ty-exit-region-left)
  (forward-char)

  (search-forward "(")
  (backward-char)
  (push-mark (point) t t)

  (forward-list nil)
  (exchange-point-and-mark)
  (ty-temp-mark-thing)
  )

(defun ty-prev-parens-outside ()
  "goes to previous or higher parens"
  (interactive)
  (setq ty-last-move 'ty-prev-parens-outside)

  (ty-exit-region-left)
  (backward-char )

  (search-backward ")")
  (forward-char)
  (push-mark (point) t t)

  (backward-list nil)
  ;;(exchange-point-and-mark)

  )
;;(global-set-key (kbd "C-5") 'ty-prev-parens-outside)
;;(global-set-key (kbd "C-6") 'ty-next-parens-outside)




;;;;;;;;;;;;; Line ;;;;;;;;;;;;;;;;;;

(defun ty-next-line ()
  "Goto next line, mark next line"
  (interactive )

  (setq ty-last-move 'ty-next-line)
  (unless (eolp);; point end of line
      (previous-line))
  (move-end-of-line nil)
  (push-mark (point) t t)
  (next-line)
  (move-end-of-line nil)

  ;; (move-end-of-line nil)
  ;; (push-mark (point) t t)
  ;; (next-line)

  (ty-temp-mark-thing)
  )


(defun ty-previous-line ()
  "Goto next line, mark next line"
  (interactive )

  (setq ty-last-move 'ty-previous-line)
  (move-end-of-line nil)
  (push-mark (point) t t)

  (previous-line)
  (move-end-of-line nil)

  (ty-temp-mark-thing)
  )



;;;;;;;;;;;;; Symbol ;;;;;;;;;;;;;;;;;;



(defun ty-forward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  ;; search forward for boundry incase starting in the middle of a word/symbol
  (setq ty-last-move 'ty-forward-symbol)
  ;; if starting in middle of a symbol, go to begining of symbol first
  (unless (string-match "[^'^@a-zA-Z0-9_\-!]" (string (following-char)))
    (re-search-backward "[\s\\(\.\\s-\"]"))


  ;; look for a symbol
  (re-search-forward "[\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:-]*[a-zA-Z0-9]*")
  (push-mark (match-beginning 0) t t)
  (goto-char (match-end 0))
  (ty-temp-mark-thing)
  )

;; foo_bar_BASS
;; ( :foo 'bar .bar  foo.bar )

(defun ty-backward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  (setq ty-last-move 'ty-backward-symbol)
  ;; if starting in middle of a symbol, go to end of symbol first
  (let ((sc "[^'^@a-zA-Z0-9_\-!]"))
    (unless (string-match sc (string (preceding-char)) )
      (re-search-forward sc)))

  (re-search-backward "[\s\\(\.\"][\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:\-]*[a-zA-Z0-9]*")

  (push-mark (match-end 0) t t)

  (if (member (string (following-char)) '(".") )
      (goto-char (+ 0 (match-beginning 0)) );; dont forward one if it's a .something
    (goto-char (+ 1 (match-beginning 0)) )
    )

  (ty-temp-mark-thing)
)



;;;;;;;;;;;;; args ;;;;;;;;;;;;;;;;;;

(defun ty-next-arg ()
  ""
  (interactive )

  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; Helpers  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ty-cleanup-around-here ()
  "adds commas if nessiary, cleans up extra white space"
  ;; TODO: do the rest of the code
  (just-one-space)
  )

(defun ty-exit-region-left ()
  "If a buffer is active, then move point to beginning of region."
  (interactive)
  (when (use-region-p)
    (goto-char (region-beginning) )
    (deactivate-mark)))

(defun ty-exit-region-right ()
  "If a buffer is active, then move point to end of region."
  (interactive)
  (when (use-region-p)
      (goto-char (region-end) )
      (deactivate-mark)))


;; (defun ty-temp-mark-thing ()
  
;;   (transient-mark-mode nil)
  
;;   (set-transient-map
;;    ;; the keymap
;;    ;; todo:a
;;    (let ((map (make-sparse-keymap)))
;;      ;;(define-key map [switch-frame] #'ignore)

;;      (define-key map (kbd "<left>") 'ty-exit-region-left)
;;      (define-key map (kbd "<right>") 'ty-exit-region-right)
;;      (define-key map (kbd "<up>") 'ty-exit-region-left)
;;      (define-key map (kbd "<down>") 'ty-exit-region-right)

;;      (define-key map (kbd "C-/") (lambda () (print "undo") ))

;;      ;; (define-key map (kbd "C-_") (lambda ()
;;      ;;                               ;;(pop-mark)
;;      ;;                               (print "quitting")
;;      ;;                               (deactivate-mark)
;;      ;;                               ;;(call-interactively 'keyboard-quit)
;;      ;;                               ))
     
;;      ;; (define-key map "t" (lambda ()
;;      ;;                        (message "pushed T")))
;;      ;; (define-key map "k" kill-region)
;;      ;; (define-key map "x" delete-region)
;;      ;; (define-key map "w" kill-ring-save)
;;      ;; (define-key map "n" copy-to-register) ;; "n" for name and m for move-to
;;      map)

;;      ;; r = replace

;;      ;; n = next p = prev (need to pass in fn)

;;      ;; nil means dont stay active as long as a key they press is in our map (can be t)
;;      ;; the lambda is the exit

;;      nil (lambda ()
;;            (message "exiting tmp mark")
;;            (deactivate-mark)
;;            (transient-mark-mode t)
;;            ;;(pop-mark)
;;            )
;;    )


(defun ty-temp-mark-thing ()
  (set-transient-map

   (let ((map (make-sparse-keymap)))
     ;;(define-key map [switch-frame] #'ignore)
     (define-key map (kbd "<left>") 'ty-exit-region-left)
     (define-key map (kbd "<right>") 'ty-exit-region-right)
     (define-key map (kbd "<up>") 'ty-exit-region-left)
     (define-key map (kbd "<down>") 'ty-exit-region-right)


     ;; Able to undo outside of selected region..
     ;; TODO
     ;;   * bind to C-/  also
     ;;   * Mark the undo text
     (define-key map (kbd "C-_") (lambda ()
                                   (interactive)
                                   (deactivate-mark)))
     
     ;;(define-key "<left>" ty-exit-region-left)

     ;; r = replace
     ;; k = kill
     ;; n = next
     ;; p = prev
     map)

   ;; nil means dont stay active as long as a key they press is in our map (can be t)
   ;; the lambda is the exit
   ;; nil (lambda ()
       
   ;;     ;(message "exiting tmp mark")
   ;;     (deactivate-mark)
   ;;     ;(pop-mark)
   ;;     ))
   ;(setq deactivate-mark  nil)
  )
)



(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))



;;;;;;;;;;;;;;;;;;;;;;; Verbs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ty-kill-this-thing (start end)
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
    ;;     (call-interactively 'ty-forward-symbol))) 
    )

  ;;(call-interactively 'kill-region)
  (kill-region (region-beginning) (region-end))

  ;; (unless (member  ty-last-move '('ty-forward-symbol 'ty-backward-symbol) )
  ;;   (funcall-interactively ty-last-move)
  ;;   ;; todo: clean up white space if between symbols
  ;;   (setq deactivate-mark  nil)    
  ;;   )

  )

;; (defun ty-point-to-register ()
;;     ""
;;     (interactive)
;;   (point-to-register "c")

;;   )


;; TODO: dup a function needs to make a new line
(defun ty-duplicate (start end)
  "Takes region or thing under cursor and duplicates it"
  (interactive "r")
  
  (unless (region-active-p)
    ;; todo : make smarter
    (message "marking reg")
    ;;(call-interactively 'ty-forward-symbol)
    (call-interactively 'er/expand-region)
    )

  (setq exit-start (region-beginning))
  (setq exit-end (region-end))
  
  (let ((to-paste (buffer-substring exit-start exit-end)))
    (save-excursion
      (ty-exit-region-right)
      
      ;; if end of line, make new line. Otherwise we need to add a new argument
      ;; but for now just add one space. 
      (if (eolp)
          (unless (string-match "^\n" to-paste)
            (electric-newline-and-maybe-indent))
        (just-one-space));; TODO: might need a comma

      (insert to-paste)
      (ty-cleanup-around-here);; Here it might mush two symbols together. might need comma
      )
    );; together region-beginning and region-end
  
  (push-mark exit-start t t)
  (goto-char exit-end)
  (setq deactivate-mark  nil)
  (ty-temp-mark-thing)
)

(defun ty-question ()
    "Looks up documenation"
  (interactive)
  (call-interactively 'describe-function);; elisp mode
  )


(defun ty-close-or-save ()
  "Saves "
  ()
 )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;   SHORT CUTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ty-make-shortcut (keys to-call)
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

  ;; Noun movement
  (ty-make-shortcut "H-1" 'ty-previous-line)
  (ty-make-shortcut "H-2" 'ty-next-line)

  (ty-make-shortcut "H-3"  'ty-backward-symbol)
  (ty-make-shortcut "H-4" 'ty-forward-symbol)

  (ty-make-shortcut "H-5" 'ty-prev-parens-outside)
  (ty-make-shortcut "H-6" 'ty-next-parens-outside)

  (ty-make-shortcut "H-7" 'previous-buffer)
  (ty-make-shortcut "H-8" 'next-buffer)

  (ty-make-shortcut "H-9" 'ty-prev-paragraph)
  (ty-make-shortcut "H-0" 'ty-next-paragraph)


  (ty-make-shortcut "H-!" 'ty-prev-quoted-string)
  (ty-make-shortcut "H-@" 'ty-next-quoted-string)

  
  ;; Verbs
  (ty-make-shortcut "H-x" 'ty-kill-this-thing)
  ;;(ty-make-shortcut "H-k" 'kill-region)

  (ty-make-shortcut "H-d" 'ty-duplicate)
  
  (ty-make-shortcut "H-;" (lambda () 
                            (interactive)
                            (call-interactively 'point-to-register)
                            (message "Point Saved")))
  (ty-make-shortcut "H-'" 'jump-to-register)

  ;; todo make cm
  ;;(ty-make-shortcut "H-[" 'copy-to-register)
  (ty-make-shortcut "H-[" (lambda () 
                            (interactive)
                            (call-interactively 'copy-to-register)
                            (activate-mark)
                            (message "Saved")) )

  (ty-make-shortcut "H-]" 'insert-register)
  

  (ty-make-shortcut "H-g" 'rgrep)

  (ty-make-shortcut "H-f" 'find-file)
  (ty-make-shortcut "H-r" 'replace-string)

  
  ;; (ty-make-shortcut "H-p 1" (lambda () (interactive)(point-to-register "1") (message "saved") ))
  ;; (ty-make-shortcut "H-p 1" (lambda () (interactive)(point-to-register "1") (message "saved") ))


  ;; Adverbs
  (ty-make-shortcut "H-?" 'ty-question)


  ;; Windows
  (ty-make-shortcut "H-w" (lambda () (interactive) (other-window 1)))
  (ty-make-shortcut "H-W" (lambda () (interactive) (other-window -1))) 


  ;; more/less
  (ty-make-shortcut "H-`" 'er/expand-region)
  (ty-make-shortcut "H-~" 'er/contract-region)



  ;; sexp

  (ty-make-shortcut "H-<right>" 'sp-forward-slurp-sexp)
  (ty-make-shortcut "H-<left>"  'sp-forward-barf-sexp) 
  (ty-make-shortcut "H-<up>"    'sp-splice-sexp) 
  (ty-make-shortcut "H-<down>"  'sp-split-sexp)


)

;;(global-unset-key (kbd "C-<home>"))
;;(global-set-key (kbd "C-<home>") nil)
;;(global-unset-key (kbd "C-<home>"))
;;(global-set-key (kbd "C-<home>") nil)
;;(global-unset-key (kbd "C-<home>"))
;;(global-set-key (kbd "C-<home>") nil)
;;(global-unset-key (kbd "C-<home>"))
;;(global-set-key (kbd "C-<home>") nil)

;; (defun  (key-list &rest)
;;   "sets global keys for functions"
;;   (when key-list
;;     (print "=============")
;;     (print key-list)

;;     ;; (let (item (car key-list))
;;     ;;   (print item)
;;     ;;   (global-set-key (kbd (car item)) (cdr item))
;;     ;;   )

;;     ;;(

;;     (apply ty-make-shortcuts rest) ))


;; (ty-make-shortcuts '("C-!" ty-previous-line)  '("C-@" kill-region))


;;(car (car '(("C-!" ty-previous-line))))
;; (car [1 2 4])


;; (setq verb-calls '(
;;                    ;;("v" ) duplicate

;;                    ;; requires specific implementations ;;
;;                    ;;("o" ) ("s" );; open/save the thing
;;                    ;;("m" ) mark the thing

;;                    ))

;; ;; Noun navigation
;; (global-set-key (kbd "C-`") 'ryo-modal-mode)
;; (ryo-modal-keys

;;  ;; line
;;  ("l" (
;;        ("<>"  ty-next-line     :exit t)
;;        ("<>"   ty-previous-line :exit t)

;;        ("<up>" ty-previous-line :exit t)
;;        ("<down>" ty-next-line :exit t)

;;        ))

;;  ("s" ( ;append verb-calls
;;        ("<left>"  ty-backward-symbol :exit t)
;;        ("<right>" ty-forward-symbol :exit t)

;;        ("<up>" ty-previous-line :exit t)
;;        ("<down>" ty-next-line :exit t)

;;        ))

;;  ("p" (;append verb-calls
;;        ("<left>"  ty-prev-parens-outside :exit t)
;;        ("<right>" ty-next-parens-outside :exit t)

;;        
;;        

;;        ))

;; ;; region
;;  ("r" (
;;        
;;        
;;        ;; ;; todo: copy region, replace in file, look for others other files
;;        ;; run
;;        
;;        ))

;;  )


;; (defun ty-mark-thing (thing-type)
;;   "Marks a line, symbol, parens, etc."
;;     (push-mark (point) t t)
;;     (move-end-of-line nil)
;;     )

;;   (when (eq thing-type 'symbol)
;;     ()
;;     )

;;   (when (eq thing-type 'word)
;;     (er/mark-word))

;;   )
