;; (global-set-key
;;  (kbd "C-n")
;;  )

;; (defmacro  ()
;;     (list 'defhydra ()  ))

;; Change cursor on in and out

;; :after-exit => start caps mode again


(personal 'hydra-buffers)

;;(customize-set-variable 'browse-kill-ring-separator "")

;; https://github.com/abo-abo/hydra/wiki/Nesting-Hydras
(defvar hydra-stack nil)

(defun hydra-push (expr)
  (push `(lambda () ,expr) hydra-stack))

(defun hydra-pop ()
  (interactive)
  (let ((x (pop hydra-stack)))
    (when x
      (funcall x))))


(defun hydra-enter ()
  (setq cursor-type "block"))

(defun hydra-exit ()
  (setq cursor-type 'bar))



;; (defun my-next-symbol ()
;;   "mark next symbol"
;;   (interactive)
;;   (forward-thing 'symbol)
;;   (beginning-of-thing 'symbol)
;;   (push-mark (point) t t)
;;   (end-of-thing 'symbol)
;;   ;;(next-visible-thing 'symbol)
;;   ;;  (mark-thing 'symbol)
;;   (temp-mark-thing)
;;   )

;; (global-set-key (kbd "C-3") 'my-next-symbol)
;; (global-set-key (kbd "C-4") 'my-next-line)





(defhydra hydra-tymode (:color teal
                        :columns 3
                        :exit t
                        :pre (hydra-enter)
                        :post (hydra-exit))

  "Tyler's mode."
  ("c" hydra-clojure/body "Clojure")
  ("b" hydra-buffer/body "Buffer")

  ("f" hydra-file/body "File")
  ("e" hydra-edit/body "Edit")

  ("n" hydra-move/body "Nav")

  ("p" (progn
         (hydra-paredit/body)
         (hydra-push '(hydra-tymode/body)))
       "PAREDIT")

  ("s" eshell "Shell")
  ("w" hydra-window/body "Window")

  ("/" isearch-forward "search fwd")
  ("/" isearch-forward "search fwd")
  ("\\" isearch-forward "search bwd")

  ;; ("c" (progn
  ;;        (hydra-c/body)
  ;;        (hydra-push '(hydra-a/body)))
  ;;      "visit hydra-c")
  ;;("i" (message "I am a") :exit nil)
  ("`" nil "exit" :exit t)
  ("<home>" nil "exit" :exit t))

(global-set-key (kbd "<home>") 'hydra-tymode/body)


(defhydra hydra-file (:exit t
                      :columns 3
                      :pre (hydra-enter)
                      :post (hydra-exit))

   "File"
   ;;("<home>" hydra-tymode/body "TYMODE")
   ("o" find-file "Open")
   ("f" find-name-dired "Find")
   ("s" save-buffer "Save")
   ("g" rgrep "rgrep")
   ("r" recentf-open-files "recent"))



(defhydra hydra-mark (:exit nil
                      :columns 3
                      :pre (hydra-enter)
                      ;;:post (hydra-exit)
                      :post (hydra-move/body)
                      )
  "Mark"
  ("SPC" er/expand-region "mark" :exit nil)
  ("l" (progn
         (move-beginning-of-line)
         (set-mark-command)
         (move-end-of-line) ) "mark-line")

  ("s" er/mark-symbol "mark-symbol")
  ("e" mark-sexp "mark-sexp")
  ("p" er/mark-paragraph "mark-paragraph")
  ("q" er/mark-outside-quotes "mark-quotes")
  ("c" er/mark-comment "mark-comment")

  ("r" replace-string "Replace String")
  ("w" kill-ring-save "Kill-Ring-Save")
  ;;("y" yank "Yank")
  ("x" kill-region "Kill-Region")
)


;;;;; Navigation ;;;;;;;;;;;;;;;
(defhydra hydra-move (:exit nil
                      :columns 3
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


   ;; todo, delete line
   ("i" (progn (kill-whitespace) (just-one-space)) "kill-window" :exit nil)
   ("k" kill-this-thing "kill-this" :exit nil)

   ;;("j" (progn (er/mark-symbol) (kill-region)) "" :exit nil)
   ;;("j" (progn (er/mark-symbol) (kill-region)) "" :exit nil)
   ;;("l" kill-word "kill-word" :exit nil)
   ;;("k" kill-region "del-char-fwd"  :exit nil);; kill what ever i am on
   ;;("h" backward-delete-char "del-char-bwd"  :exit nil)
   ;;(";" (progn ()) "kill"  :exit nil)


   ;; REGISTER location
   ("n" point-to-register "point-to-register":exit t)
   ("m" jump-to-register "jump-to-register" :exit t)


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


   ("u" undo "undo" :exit nil)
   ("SPC" er/expand-region "mark" :exit nil)
   ("b" switch-to-buffer "switch-buffer" :exit t)
   ("b" switch-to-buffer "switch-buffer" :exit t)
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
(defhydra hydra-edit (:exit nil
                      :columns 3
                      :pre (hydra-enter)
                      :post (hydra-exit))
  "EDIT"
  ("<home>" hydra-tymode/body "" :exit t)
  ("c" comment-region "Comment region")
  ("d" (progn (kill-whole-line)
              (yank)
              (yank)
              (previous-line)
              (smart-line-beginning)) "Duplicate line")
  ("SPC" er/expand-region "Expand Region")

  ("n" hydra-move/body "Nav" :exit t)
  ("r" replace-string "Replace String")
  ("w" kill-ring-save "Kill-Ring-Save")
  ("y" yank "Yank")
  ("x" kill-region "Kill-Region")
  ("u" undo "undo")
  ;("Y" (dropdown-list ('yank-menu)) "Yank Next")
  ;("Y" yank-pop "yank-pop")
  ("Y" (progn (dropdown-list (subseq (delq nil (delete-duplicates kill-ring)) 0 15) )) "yank-menu")  )


(defhydra hydra-buffer (:exit t
                        :columns 3
                        :pre (hydra-enter)
                        :post (hydra-exit))
  "BUFFER"
  ;("<home>" hydra-tymode/body "" :exit t)
  ("b" switch-to-prev-buffer "switch")
  ("o" switch-to-prev-buffer "other")
  ("s" save-buffer "save")
  ("p" previous-buffer "previous ")
  ("n" next-buffer "next")
  ("l" buffer-menu "menu")
  ("k" kill-this-buffer "kill"))


(defhydra hydra-window (:exit t
                        :columns 3
                        ;;:post (hydra-tymode/body)
                        :pre (hydra-enter)
                        :post (hydra-exit))
  "Window"
  ("<home>" hydra-tymode/body "" :exit t)
  ("o" other-window "Other")
  ("1" delete-other-windows "Kill-others")
  ("l" delete-other-windows "Kill-others")
  ("k" delete-window "Kill-Window")
  ("v" split-window-right "Vertical")
  ("h" split-window-below "Horiz"))




(defun comment-sexp ()
  "Comment out the sexp at point."
  (interactive)
  (save-excursion
    (mark-sexp)
    (paredit-comment-dwim)))

(defhydra hydra-clojure (:exit nil
                         :columns 3
                         :pre (hydra-enter)
                         :post (hydra-exit))

  "Clojure"
  ;; http://cider.readthedocs.io/en/latest/interactive_programming/
  ("n" cider-repl-set-ns "Set NS")
  ("d" cider-doc "Doc")
  ("b" cider-load-buffer "Exec Buffer")
  ("q" cider-quit "Quit REPL")
  ("e" cider-eval-last-sexp-to-repl "Eval S-exp")

  ;; barage/slurpage
  ("r" paredit-forward-slurp-sexp "slurp fwd")
  ("e" paredit-forward-barf-sexp "barf fwd")
  ("w" paredit-backward-slurp-sexp "slurp bwd")
  ("q" paredit-backward-barf-sexp "barf bwd")

  );;cider-eval-last-sexp


(defhydra hydra-paredit (:color blue
                         :columns 3
                        :pre (hydra-enter)
                        :post (hydra-exit))
  ("A" cider-apropos-documentation "Apropos documentation")
  ("E" cider-jump-to-compilation-error "Jump to compilation error")
  ("R" cider-jump-to-resource "Jump to resource"))
