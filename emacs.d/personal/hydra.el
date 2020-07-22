
;;(customize-set-variable 'browse-kill-ring-separator "")



(defun hydra-enter ()
  (setq cursor-type "block"))

(defun hydra-exit ()
  (setq cursor-type 'bar))

;; (call-interactively 'hydra-tymode/body)

(defhydra hydra-tymode (:color teal
                               ;;:columns 3
                               :exit t
                               :pre (hydra-enter)
                               :post (hydra-exit))

  "Tyler's mode."
  ("c" hydra-clojure/body "Clojure")
  ("b" hydra-buffer/body "Buffer")

  ("f" hydra-file/body "File")
  ("e" hydra-edit/body "Edit")

  ("j" goto-last-change "goto-last-change" :exit nil)
  ("m" hydra-mark/body "Mark")
  ("k" hydra-macro/body "Macro")

  ("p" hydra-paredit/body "Parens")
  ("o" hydra-origami/body "Origami")

  ;;("r" hydra-register/body "Registers")
  ("w" hydra-window/body "Window")
  ("z" ds-undo "undo")
  ("s" helm-occur "search") 
  ("g" (progn
	       (call-interactively 'helm-git-grep-at-point)) "grep")
  
  ("n" bm-toggle "BM" :exit nil)
  ("/" bm-toggle "BM toggle" :exit nil)
  ("<down>" bm-next "BM Next" :exit nil)
  ("<up>" bm-previous "BM Prev" :exit nil)

  ("SPC" (progn (call-interactively 'er/expand-region)
                (hydra-mark/body)
                ) "Expand Region")
  ("C-SPC" er/contract-region "Shrink Region")


  ("1" ty-eval-buffer "eval-buffer" :exit t)
  ("2" ty-eval-defun "eval-defn" :exit t)
  ("3" ty-eval-last-sexp "eval-last-expr" :exit t)
  ("4" ty-eval-region "eval-region" :exit t)
  ;; same for ergodox
  ("!" ty-eval-buffer "eval-buffer" :exit t)
  ("@" ty-eval-defun "eval-defn" :exit t)
  ("#" ty-eval-last-sexp "eval-last-expr" :exit t)
  ("$" ty-eval-region "eval-region" :exit t)
  
  ("`" nil "exit" :exit :t)
  ("<return>" hydra-keyboard-quit "exit")
  ("<home>" nil "exit" :exit t))

(global-set-key (kbd "<home>") 'hydra-tymode/body)
(global-set-key (kbd "<end>") 'smex)


(defhydra hydra-file (:exit t
		                        ;;:columns 4
                            :pre (hydra-enter)
                            :post (hydra-exit))

  "File"
  ;;("<home>" hydra-tymode/body "TYMODE")
  ("o" helm-projectile "Open")
  ("f" find-name-dired "Find")
  ("s" save-buffer "Save")
  ("g" rgrep "rgrep")
  ("n" rename-file-and-buffer "reNAME file")
  ("r" helm-recentf "recent"))

;; TODO: Fix going to main hyra
;; use ty-next line prev line using arrows.
(defhydra hydra-mark (:exit nil
                            :columns 4
                                        ;:pre (hydra-enter)
                            ;;:post (hydra-exit)
                            ;;:post (hydra-move/body)
                            )
  "Mark"
  ("l" (progn
         (move-beginning-of-line nil)
	       (push-mark (point) t t)
         (move-end-of-line nil) ) "mark-line")

  ("s" helm-occur "search" :exit t)
  ("e" mark-sexp "mark-sexp")
  ("d" duplicate-current-line-or-region "Duplicate")
  ("p" er/mark-paragraph "mark-paragraph")
  ;;("q" er/mark-outside-quotes "mark-quotes")
  (";" comment-or-uncomment-region-or-line "Comment")
  ("#" comment-or-uncomment-region-or-line "Comment")

  ("r" replace-string "Replace String")
  ("g" (progn
	       (call-interactively 'helm-git-grep-at-point)) "grep")
  ("q" keyboard-quit "quit" :exit t)
  ("w" kill-ring-save "Kill-Ring-Save" :exit t)
  ("y" yank "Yank" :exit t)
  ("k" kill-region "Kill-Region" :exit t)
  ("n" mc/mark-next-like-this "Next")
  ("j" goto-last-change "goto-last-change" :exit nil)
  
  ("SPC" er/expand-region "expand" :exit nil)
  ("C-SPC" er/contract-region "contract" :exit nil)
  ;;("<down>" ds-forward-symbol "Next")
  ;;("<up>" ds-backward-symbol "Prev")
  ;; ("<right>" (progn (ds-exit-region-right)
  ;;                   (keyboard-quit)) "exit-right" :exit t)
  ;; ("<left>" (progn (ds-exit-region-left)
  ;;                  (keyboard-quit)) "exit-left" :exit t)

  ("M-<left>" ds-right-joy-left "Drag Back")
  ("M-<right>" ds-right-joy-right "Drag Foward")
  ("<return>" hydra-keyboard-quit "exit")
  )


(global-set-key (kbd "<H-f14>") 'hydra-mark/body)


(defhydra hydra-origami (:exit t
                               ;;:columns 4
                               :pre (hydra-enter)
                               :post (hydra-exit))

  "Origami"
  ("t" origami-toggle-node "toggle")
  ("o" origami-open-node "open-node")
  ("c" origami-close-node "close-node")
  
  ("r" origami-reset "reset")
  ("b"  origami-close-all-nodes "close-all")
  ("n"  origami-open-all-nodes "open-all")
  
  ("<return>" hydra-keyboard-quit "exit")
  )

(defhydra hydra-macro (:exit t
		                   ;;:columns 4
                       :pre (hydra-enter)
                       :post (hydra-exit))

  "Macro"
  ("s" kmacro-start-macro "Start")
  ("e" kmacro-end-macro "End")
  ("c" kmacro-call-macro "Call")
  ("n" name-last-kbd-macro "Name Last")
  ("i" insert-kbd-macro "Insert")
  ("r" kmacro-to-register "Registry")
  ("a" apply-macro-to-region-lines "ApplyRegion"))



;; (defhydra hydra-register (:exit t
;;                           :pre (hydra-enter)
;;                           :post (hydra-exit))

;;   "(s Save) (i Insert)  (n  Name Point) (m  Move to)  (k kmacro-save)"

;;   ("s" copy-to-register "Save")
;;   ("i" insert-register "Insert")
;;   ("n" point-to-register "Name Point")
;;   ("m" jump-to-register "Move to")
  
;;   ("k" kmacro-to-register "Kmacro save")
;;   ("e" jump-to-register "Kmacro run")
;;   )

(global-set-key (kbd "<H-f17>") 'hydra-register/body)



;;;;; Navigation ;;;;;;;;;;;;;;;
(defhydra hydra-nav (:exit nil
                            ;;:columns 3
                      :pre (hydra-enter)
                      :post (hydra-exit))

   "move"
   ("<home>" hydra-tymode/body "TYMODE" :exit t)

   ("\\" isearch-backward "search bwd")
   ("/" isearch-forward "search fwd")
   
   ;; UP / DOWN PAGES
   ("q" scroll-down-command  "scroll-down-command " :exit nil)
   ("z" scroll-up-command "scroll-up-command" :exit nil)

   ;; FWD / BWD PARAGRAPHS
   ("w" backward-paragraph "backward-paragraph"  :exit nil)
   ("x" forward-paragraph "forward-paragraph" :exit nil)

   ;; UP / DOWN LINES
   ("r" previous-line "previous-line" :exit nil)
   ("v" next-line "next-line" :exit nil)

   ;; FWD / BACK SYMBOL
   ("d" (progn (forward-symbol -1)) "backward-symbol"  :exit nil)
   ("f" forward-symbol "forward-symbol" :exit nil)

   ("a" smart-line-beginning "smart-line-beginning" :exit nil)
   ("g" move-end-of-line "end line" :exit nil)

   ;; S is free still...
   ("h" bm-toggle "bm-toggle" :exit nil)
   ("u" bm-previous "bm-prev" :exit nil)
   ("j" bm-next "bookmark" :exit nil)

   
   ;; todo, delete line
   ("i" (progn (kill-whitespace) (just-one-space)) "kill-window" :exit nil)
   ("k" kill-this-thing "kill-this" :exit nil)

   ;;("j" (progn (er/mark-symbol) (kill-region)) "" :exit nil)
   ;;("j" (progn (er/mark-symbol) (kill-region)) "" :exit nil)
   ;;("l" kill-word "kill-word" :exit nil)
   ;;("k" kill-region "del-char-fwd"  :exit nil);; kill what ever i am on
   ;;("h" backward-delete-char "del-char-bwd"  :exit nil)
   ;;(";" (progn ()) "kill"  :exit nil)

   ;; MARK location
   ;; er/mark-inside-quotes
   ;;               delete
   ;; er/mark-outside-quotes
   ;;               delete, move, copy
   ;; er/mark-outside-pairs
   ;;               delete, move, copy
   ;; er/mark-symbol
   ;;               delete, move, copy
   ;; line


   ;;("u" undo "undo" :exit nil)
   ;;("<up>" er/expand-region "mark" :exit nil)
   ("b" hydra-buffer/body "hydra-buffer" :exit t)
   ("<return>" hydra-keyboard-quit "exit")
   )


;; TODO:
;; mark
;;    comment
;;    quoted string
;;    symbol
;;    whole parens
;; rename symbol, replace
;; current symbol, search forward/backward
;; kill whole line
;; new argument.. JS mode, add comma then space
;; duplicate line
;; comment/uncomment line
;; delete all whitespace fwd/backward
;;
;;  Expanding:
;;    1. this thing
;;    2. whole, inside (can be used to clear params for JS/Ruby)
;;    3. whole, outside
;;    4. container, inside
;;    5. container, outside
;;  Better way:
;;    set level: this/whole, container, extended
;;    set inside/outside

;; ("d" (progn (kill-whole-line)
;;             (yank)
;;             (yank)
;;             (previous-line)
;;             (smart-line-beginning)) "Duplicate line")

(defhydra hydra-edit (:exit nil
                            ;;:columns 3
                            :pre (hydra-enter)
                            :post (hydra-exit))
  "EDIT"
  ("<home>" hydra-tymode/body "" :exit t)

  (";" comment-or-uncomment-region-or-line "Comment region" :exit t)
  
  ;; ("g" right-char "Right")
  ;; ("h" left-char "Left")
  
  ("<left>" ds-left-joy-left "Back")
  ("<right>" ds-left-joy-right "Foward")
  
  ("M-<left>" ds-right-joy-left "Drag Back")
  ("M-<right>" ds-right-joy-right "Drag Foward")
  
  ;; ("u" ds-right-joy-up "Drag Up")
  ;; ("n" ds-right-joy-down "Drag Down")

  ;; ("x" ds-ex "Cut")
  ;; ("v" ds-circle "Paste")
  
  ("SPC" er/expand-region "Expand Region")
  ("S-SPC" er/contract-region "Shrink Region")

  ("r" replace-string "Replace String")
  ("w" kill-ring-save "Kill-Ring-Save")
  
  
  ("z" ds-undo "undo")
                                        ;("Y" (dropdown-list ('yank-menu)) "Yank Next")
                                        ;("Y" yank-pop "yank-pop")
  ;;("Y" (progn (dropdown-list (subseq (delq nil (delete-duplicates kill-ring)) 0 15) )) "yank-menu")
  )


(defhydra hydra-buffer (:exit t
                        ;;:columns 3
                        :pre (hydra-enter)
                        :post (hydra-exit))
  "BUFFER"
  ("<home>" hydra-keyboard-quit "" :exit t)
  ("<return>" hydra-keyboard-quit "exit")
  ("b" (progn (switch-to-buffer (other-buffer (current-buffer) 1)) ) "switch-buffer" :exit t)
  ;("o" switch-to-prev-buffer "other")
  ;;("s" save-buffer "save")
  ;;("f" next-buffer "next")
  ;;("d" previous-buffer "previous ")
  ;; ("l" buffer-menu "menu")
  ;;("l" buffer-menu "menu" :exit t)
  ("l" helm-buffers-list "list")
  ("p" projectile-ibuffer "project")

  ("<up>" tabbar-forward-group "group-fwd" :exit nil) 
  ("<down>" tabbar-backward-group "group-back" :exit nil)
  ("<left>" tabbar-backward "tab-back" :exit nil)
  ("<right>" tabbar-forward "tab-fwd" :exit nil)
  ("k" kill-this-buffer "kill" :exit nil))


(defhydra hydra-window (:exit t
                        ;;:columns 3
                        ;;:post (hydra-tymode/body)
                        :pre (hydra-enter)
                        :post (hydra-exit))
  "Window"
  ("<home>" hydra-tymode/body "" :exit t)
  ("<return>" hydra-keyboard-quit "exit")
  ("o" other-window "Other" :exit nil)
  ("1" delete-other-windows "Kill-others")
  ("!" delete-other-windows "Kill-others")
  ("k" delete-window "Kill-Window")
  ("v" split-window-right "Vertical" :exit nil)
  ("h" split-window-below "Horiz" :exit nil)

  ("+" text-scale-increase "text-scale-up" :exit nil) 
  ("=" text-scale-increase "text-scale-up" :exit nil) 
  ("<kp-subtract>" text-scale-decrease "text-scale-down" :exit nil)
  ("_" text-scale-decrease "text-scale-down" :exit nil)
  
  ("<up>" enlarge-window "enlarge-window" :exit nil) 
  ("<down>" shrink-window "shrink window" :exit nil) 
  ("<return>" hydra-keyboard-quit "exit") 
  )



(defun comment-sexp ()
  "Comment out the sexp at point."
  (interactive)
  (save-excursion
    (mark-sexp)
    (paredit-comment-dwim)))

(defhydra hydra-clojure (:exit t
                         ;;:columns 3
                         :pre (hydra-enter)
                         :post (hydra-exit))

  "Clojure"
  ;; http://cider.readthedocs.io/en/latest/interactive_programming/
  ("n" cider-repl-set-ns "Set NS")
  ("?" cider-doc "Doc")
  ("b" cider-load-buffer "Exec Buffer")
  ("q" cider-quit "Quit REPL")
  ("j" cider-jack-in "JackIn")
  ("s" cider-show-repl)
  ("r" cider-eval-region "eval region")
  ("e" cider-eval-sexp-at-point "Eval S-exp")
  ("d" cider-eval-defun-at-point "Eval defn")

  ;; barage/slurpage
  ;; ("r" paredit-forward-slurp-sexp "slurp fwd")
  ;; ("e" paredit-forward-barf-sexp "barf fwd")
  ;; ("w" paredit-backward-slurp-sexp "slurp bwd")
  ;; ("q" paredit-backward-barf-sexp "barf bwd")
  ;;cider-eval-last-sexp
  )


(defhydra hydra-paredit (:color blue
                         :columns 3
                         :exit nil)
  
  ;("A" cider-apropos-documentation "Apropos documentation")
  ;("E" cider-jump-to-compilation-error "Jump to compilation error")
  ;("R" cider-jump-to-resource "Jump to resource")



  ;; ("<right>" (progn (sp-forward-sexp) (sp-mark-sexp)) "sp-forward-sexp" :exit nil) ;
  ;; ("<left>" (progn (sp-backward-sexp) (sp-mark-sexp)) "sp-backward-sexp" :exit nil)
  
  ;; ("<down>" (progn (sp-down-sexp) (sp-mark-sexp)) "sp-down-sexp" :exit nil)
  ;; ("<up>" (progn (sp-up-sexp) (sp-mark-sexp)) "sp-up-sexp" :exit nil)

  ;; todo, should be up
  ("SPC" er/expand-region "mark" :exit nil)


  ("<right>"  sp-forward-sexp "sp-forward-sexp" :exit nil)
  ("<left>"  sp-backward-sexp "sp-backward-sexp" :exit nil)
  ("<down>"  sp-down-sexp "sp-down-sexp" :exit nil)
  ("<up>"  sp-up-sexp "sp-up-sexp" :exit nil)
  ("m" sp-mark-sexp "sp-mark-sexp" :exit nil)
  ("x" eval-last-sexp "eval-last-sexp" :exit nil)

  ;;("" sp-backward-down-sexp "sp-backward-down-sexp" :exit nil)
  ("a" sp-beginning-of-sexp "sp-beginning-of-sexp" :exit nil)
  ("e" sp-end-of-sexp "sp-end-of-sexp" :exit nil)

  ;;("" sp-backward-up-sexp "sp-backward-up-sexp" :exit nil)
  ("t" sp-transpose-sexp "sp-transpose-sexp" :exit nil)

  ("n" sp-next-sexp "sp-next-sexp" :exit nil)
  ("p" sp-previous-sexp "sp-previous-sexp" :exit nil)

  ("k" sp-kill-sexp "sp-kill-sexp" :exit nil)
  ("c" sp-copy-sexp "sp-copy-sexp" :exit nil)

  ;;("" sp-unwrap-sexp "sp-unwrap-sexp" :exit nil)
  ;;("" sp-backward-unwrap-sexp "sp-backward-unwrap-sexp" :exit nil)

  ("s" sp-forward-slurp-sexp "sp-forward-slurp-sexp" :exit nil)
  ("b" sp-forward-barf-sexp "sp-forward-barf-sexp" :exit nil)
  
  ;;("" sp-backward-slurp-sexp "sp-backward-slurp-sexp" :exit nil)
  ;;("" sp-backward-barf-sexp "sp-backward-barf-sexp" :exit nil)
  ;;("" sp-splice-sexp "sp-splice-sexp" :exit nil)


)
