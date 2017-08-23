
(global-set-key (kbd "C-1") 'sp-next-sexp)
(global-set-key (kbd "C-2") 'sp-up-sexp)
(global-set-key (kbd "C-3") 'sp-down-sexp)


                                        ;(setq myHash (make-hash-table :test 'equal :age 34))
                                        ;(puthash :age 33 myHash)

                                        ;(gethash :age myHash)

(setq xx '(a 1 b 2))
(plist-get xx 'a)



(let ((to-paste (buffer-substring exit-start exit-end)))
  (save-excursion
    (ty-exit-region-right)
    
    ;; if end of line, make new line. Otherwise we need to add a new argument
    ;; but for now just add one space. 
    (if
      (eolp)
      (unless
        (string-match "^\n" to-paste)
        (electric-newline-and-maybe-indent))
      (just-one-space));; TODO: might need a comma

    (insert to-paste foo-bar)
    (ty-cleanup-around-here);; Here it might mush two symbols together. might need comma
    )
  )

;;(1 (2 2.5) 3 4) 



;; backward-barf = unshift, move up
;; fwd-barf = pop, move up


(defun ty-sexp-to-tree ()
  ""
  (let ((this-sexp (buffer-substring exit-start exit-end)))
    (with-temp-buffer
      (insert this-sexp)
      (if (following-char))
      )
    )
  
  )

(syntax-after (point))[;;

](defun ty-make-zipper ()
  ""
  (save-excursion
    (goto-char 1)
    )
  )

