;; http://stackoverflow.com/questions/16298895/emacs-greedy-search-backward-regexp
(defun ar-greedy-search-backward-regexp (regexp)
  "Match backward the whole expression as search-forward would do. "
  (interactive (list (read-from-minibuffer "Regexp: " (car kill-ring))))
  (let (last)
    (when (re-search-backward regexp nil t 1)
      (push-mark)
      (while (looking-at regexp)
        (setq last (match-end 0))
        (forward-char -1))
      (forward-char 1)
      (push-mark)
      (goto-char last)
      (exchange-point-and-mark))))


(defun ryo-nothing (*args)
  "Display a buffer of all bindings in `ryo-modal-mode'."
  ()
  )


;;(setq ryo-modal-cursor-type 'block)

;(ryo-modal-mode 1)

;;(ryo-modal-bindings-list)

;; :foo

(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))


(defun kill-this-thing ()
  "Cleanly kill thing under cursor"
  (interactive)

  (if (use-region-p)
      ();; already marked
    (if (member (string (following-char)) '("'" "\"" "{" "(") )
        (progn (mark-sexp))
      (er/mark-symbol)) )

  (kill-region (region-beginning) (region-end))

  ;; Move it it's own function to cleanup whitespace
  ;; (kill-whitespace)
  ;; ;;(string-match "[a-zA-Z'\"]" (string (following-char)))
  ;; (if (member (string (preceding-char)) '("{" "(" ";") )
  ;;     ();; do nothing
  ;;   (if (member (string (following-char)) '("{" "}" "(" ")" ";") )
  ;;       ();; do nothing
  ;;     (just-one-space)))

  )



(require 'thingatpt)
(defun ty-next-line ()
  "Goto next line, mark next line"
  (interactive )
  ;;(next-line)
  ;;(ty-mark-thing 'line)
  ;;()
  ;; (move-beginning-of-line nil)
  ;; (re-search-forward "[^\n]+\n")
  ;; (push-mark (match-beginning 0) t t)
  ;; (goto-char (match-end 0))

  (move-beginning-of-line nil)
  (push-mark (point) t t)
  (next-line)

  ;(temp-mark-thing)
  )
(global-set-key (kbd "C-2") 'ty-next-line)

;; 1 asdf asdf a;
;; 2 asdf asdf
;; 3 asdf asf

(defun ty-previous-line ()
  "Goto next line, mark next line"
  (interactive )
  ;;(previous-line)
  ;;(ty-mark-thing 'line)
  ;; (move-end-of-line nil)
  ;; (re-search-backward "\n[^\n]+\n")
  ;; (push-mark (match-end 0) t t)
  ;; (goto-char (match-beginning 0))

  ;; (previous-line)
  (move-end-of-line nil)
  (push-mark (point) t t)

  (previous-line)
  (move-end-of-line nil)

  ;(temp-mark-thing)
  )
(global-set-key (kbd "C-1") 'ty-previous-line)

;
;;(setq ty-symbol-re )
;;(setq ty-symbol-re "[\\(]['^@a-zA-Z0-9_\\/:-]+")

(defun ty-forward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  ;; search forward for boundry incase starting in the middle of a word/symbol
  ;;(re-search-forward "\\_>")
  ;;(re-search-backward "\\_>")

  ;; look for a symbol
  (re-search-forward "[\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:-]*[a-zA-Z0-9]*")
  (push-mark (match-beginning 0) t t)
  (goto-char (match-end 0))
  (ty-temp-mark-thing)
  )

;; ( :foo 'bar .bar  foo.bar )

(defun ty-backward-symbol ()
  "Regex forward for words plus colons, hyphens and underscores"
  (interactive)
  (re-search-backward "[\s\\(\.\"][\.\\:'@a-zA-Z0-9]['^@a-zA-Z0-9_\\/:\-]*[a-zA-Z0-9]*")

  ;;(print (match-end 1))
  ;;(print (match-beginning 1))

  (push-mark (match-end 0) t t)

  (if (member (string (following-char)) '(".") )
      (goto-char (+ 0 (match-beginning 0)) );; dont forward one if it's a .something
    (goto-char (+ 1 (match-beginning 0)) )
    )

  (ty-temp-mark-thing)
)

(global-set-key (kbd "C-3") 'ty-backward-symbol)
(global-set-key (kbd "C-4") 'ty-forward-symbol)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; thing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ty-mark-thing (thing-type)
  "Marks a line, symbol, parens, etc."
  (when (eq thing-type 'line)
    ;;(smart-line-beginning)
    (move-beginning-of-line nil)
    (push-mark (point) t t)
    (move-end-of-line nil)
    )

  (when (eq thing-type 'symbol)
    ()
    )

  (when (eq thing-type 'word)
    (er/mark-word))

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

(defun ty-temp-mark-thing ()
  (set-transient-map
   ;; the keymap
   ;; todo:
   (let ((map (make-sparse-keymap)))
     ;;(define-key map [switch-frame] #'ignore)
     ;;(define-key map (kbd "C-<left>") 'ty-exit-region-left)
     ;;(define-key map (kbd "C-<right>") 'ty-exit-region-right)
     ;;(define-key "<left>" ty-exit-region-left)
     ;; r = replace
     ;; k = kill
     ;; n = next
     ;; p = prev
     map)

   ;; nil means dont stay active as long as a key they press is in our map (can be t)
   ;; the lambda is the exit
   t (lambda ()
       ;;  (message "exiting tmp mark")
       (deactivate-mark)
       (pop-mark)))

  )




(setq verb-calls '(
                   ("u" undo)

                   ;; noun related ;;
                   ("k" kill-region)
                   ("c" comment-region)
                   ("r" (progn () )) ;; todo: copy region, replace in file, look for others other files
                   ("r" eval-last-sexp)
                   ("k" kill-region)
                   ("g" rgrep)
                   ;;("v" ) duplicate
                   ("<up>" rgrep)

                   ;; requires specific implementations ;;
                   ;;("o" ) ("s" );; open/save the thing
                   ;;("m" ) mark the thing

                   ))


(global-set-key (kbd "C-`") 'ryo-modal-mode)
(ryo-modal-keys

 ;; Number row
 ("`" ryo-nothing)
 ("1" ryo-nothing)
 ("2" ryo-nothing)
 ("3" ryo-nothing)
 ("4" ryo-nothing)
 ("5" ryo-nothing)
 ("6" ryo-nothing)
 ("7" ryo-nothing)
 ("8" ryo-nothing)
 ("9" ryo-nothing)
 ("0" ryo-nothing)
 ("-" ryo-nothing)
 ("=" ryo-nothing)

 ;;;;; Navigation ;;;;;;;;;;;;;;;
 ("q" ryo-nothing)
 ("w" ryo-nothing)
 ("e" ryo-nothing)
 ("r" ryo-nothing)

 ("a" ryo-nothing)

 ;; ("s" ryo-nothing)
 ;; ("d" ryo-nothing)
 ;; ("f" ryo-nothing)

 ;; ("z" ryo-nothing)
 ;; ("x" ryo-nothing)
 ;; ("c" ryo-nothing)
 ;; ("v" ryo-nothing)


 ("t" ryo-nothing)
 ("y" ryo-nothing)
 ("u" ryo-nothing)
 ("i" ryo-nothing)
 ("o" ryo-nothing)
 ("p" ryo-nothing)
 ("[" ryo-nothing)
 ("]" ryo-nothing)
 ("\\" ryo-nothing)

;;;;;;;;;;;;;; home row ;;;;;;;;;;;;;;;;;;

 ;; Grid, IE, windows
 ("g" (("0" ryo-nothing)
       ("1" ryo-nothing)
       ("2" ryo-nothing)
       ("3" ryo-nothing)))

 ("h" ryo-nothing)
 ("j" ryo-nothing)

 ;; Killing
 ("k" (("a" ryo-nothing)
       ("b" ryo-nothing)
       ("k" ryo-nothing)


                                        ; (("a" kill-word)
       ("b" ryo-nothing)
       ("k" ryo-nothing)
       ("r" ryo-nothing)))
 ;;kill within quotes
 ;; kill bewteen space and )}

 ;; "Locate"
 ("l" ryo-nothing)
 (";" ryo-nothing)
 ("'" ryo-nothing)


;;;;;;;;;;;;; bottom row ;;;;;;;;;;;;;;;;;;;;;

 ;; Buffers
 ("b" ryo-nothing)

 ;; Notes (Comments)
 ("n" ryo-nothing)

 ;;Macros
 ("m" ryo-nothing)

 ("," ryo-nothing)
 ("." ryo-nothing)
 ("/" ryo-nothing)

 ("SPC" ryo-nothing)

 )
