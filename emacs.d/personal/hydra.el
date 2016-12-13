;; (global-set-key
;;  (kbd "C-n")
;;  )

;; (defmacro  ()
;;     (list 'defhydra ()  ))

;; Change cursor on in and out

;; :after-exit => start caps mode again

;;(vendor 'thing-cmds)
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

(defhydra hydra-tymode (:color teal
                        :columns 3
                        :exit t
                        :pre (hydra-enter)
                        :post (hydra-exit))

  "Tyler's mode."
  ("b" hydra-buffer/body "Buffer")

  ("f" hydra-file/body "File")
  ("e" hydra-edit/body "Edit")

  ("n" hydra-move/body "Nav")

  ("p" (progn
         (hydra-paredit/body)
         (hydra-push '(hydra-tymode/body)))
       "PAREDIT")

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
   ("s" save-buffer "Save")
   ("g" rgrep "rgrep")
   ("r" recentf-open-files "recent"))


;;;;; Navigation ;;;;;;;;;;;;;;;
(defhydra hydra-move (:exit nil
                      :columns 3
                      :pre (hydra-enter)
                      :post (hydra-exit))

   "move"
   ("<home>" hydra-tymode/body "TYMODE" :exit t)

   ("\\" isearch-backward "search bwd")
   ("/" isearch-forward "search fwd")

   ("q" scroll-down-command  "scroll-down-command " :exit nil)
   ("w" backward-paragraph "backward-paragraph"  :exit nil)
   ("e" previous-line "previous-line" :exit nil)
   ("r" previous-line "previous-line" :exit nil)
   ;("r" backward-sexp "backward-sexp" :exit nil)

   ("a" backward-word "backward-word" :exit nil)
   ("s" backward-char "backward-char"  :exit nil)
   ("d" forward-char "forward-char" :exit nil)
   ("f" forward-word "forward-word" :exit nil)
   ("v" next-line "previous-line" :exit nil)

   ("z" scroll-up-command "scroll-up-command" :exit nil)
   ("x" forward-paragraph "forward-paragraph" :exit nil)
   ("b" switch-to-prev-buffer "switch"))



;; TODO:
;;  delete comment
;; rename symbol, replace
;; current symbol, search forward/backward
;; kill whole line
;; new argument.. JS mode, add comma then space
(defhydra hydra-edit (:exit nil
                      :columns 3
                      :pre (hydra-enter)
                      :post (hydra-exit))
  "EDIT"
  ("<home>" hydra-tymode/body "" :exit t)
  ("e" expand-region "Expand Region")
  ("w" kill-ring-save "Kill-Ring-Save")
  ("x" kill-region "Kill-Region")
  ("c" comment-region "Comment region")
  ("y" yank "Yank")
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
  ("l" delete-other-windows "Kill-others")
  ("k" delete-window "Kill-Window")
  ("v" split-window-right "Vertical")
  ("h" split-window-below "Horiz"))


(defhydra hydra-paredit (:color blue
                         :columns 3
                        :pre (hydra-enter)
                        :post (hydra-exit))
  ("A" cider-apropos-documentation "Apropos documentation")
  ("E" cider-jump-to-compilation-error "Jump to compilation error")
  ("R" cider-jump-to-resource "Jump to resource"))
