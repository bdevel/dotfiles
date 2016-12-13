(defun ryo-nothing (*args)
  "Display a buffer of all bindings in `ryo-modal-mode'."
  ()
)

;; Change the finge color
;; (add-hook 'ryo-modal-mode-hook
;;             (lambda ()
;;               (if ryo-modal-mode
;;                   (set-face-background 'fringe "red")
;;                 (set-face-background 'fringe "black");; todo: make 'default
;;                   )))

(setq ryo-modal-cursor-type 'block)

(ryo-modal-mode 1)

;;(ryo-modal-bindings-list)

(global-set-key (kbd "<home>") 'ryo-modal-mode)
(ryo-modal-keys

 ;; Number row
 ("`" er/expand-region)
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
 ;; ("q" scroll-down-command)
 ;; ("w" backward-paragraph)
 ;; ("e" previous-line)
 ;; ("r" backward-sexp)

 ("a" hydra-move/body)

 ;; ("s" backward-char)
 ;; ("d" forward-char)
 ;; ("f" forward-word)

 ;; ("z" scroll-up-command)
 ;; ("x" forward-paragraph)
 ;; ("c" next-line)
 ;; ("v" forward-sexp)


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
("g" (("0" delete-window)
      ("1" delete-other-windows)
      ("2" split-window-below)
      ("3" split-window-right)
      ("o" other-window);;alias for gg
      ("g" other-window)))

("h" ryo-nothing)
("j" ryo-nothing)

;; Killing
("k" (("a" kill-word)
      ("b" kill-buffer)
      ("k" kill-line)


; (("a" kill-word)
      ("b" kill-buffer)
      ("k" kill-line)
      ("r" kill-region)))
;;kill within quotes
;; kill bewteen space and )}

;; "Locate"
("l" (("f" find-file)
      ("g" rgrep)
      ("q" isearch-backward)
      ("z" isearch-forward)
      ("r" recentf-open-files)
      ))
(";" ryo-nothing)
("'" ryo-nothing)


;;;;;;;;;;;;; bottom row ;;;;;;;;;;;;;;;;;;;;;

;; Buffers
("b" (("n" next-buffer )
      ("b" switch-to-prev-buffer )
      ("s" save-buffer )
      ("v" previous-buffer )
      ("l" buffer-menu)
      ("k" kill-buffer)))

;; Notes (Comments)
("n" (("n" comment-line)
      ("r" comment-region)))

;;Macros
("m" (("b" kmacro-start-macro);; begin
      ("e" kmacro-end-macro);;end
      ("m" kmacro-end-and-call-macro);;end
      ))

("," ryo-nothing)
("." ryo-nothing)
("/" isearch-forward)

("SPC" ryo-modal-mode)

)

; (ryo-modal-keys
;;  ("b" (("n" next-buffer )
;;        ("v" previous-buffer ) ))
;;  ()
;;  )

;; (ryo-modal-key
;;  "SPC" '(("s" save-buffer)
;;    ))
