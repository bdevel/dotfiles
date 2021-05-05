;;;;
;; Cider
;;;;

(defun find-buffer (name-str)
    ""
    (first (seq-filter (lambda (b)
                         (and
                          (string-match name-str (buffer-name b))))
                       (buffer-list))))

;;(find-buffer "*cider-error*")

(defun kill-cider-error ()
  "Quits the cider error pop up and kills the error buffer."
    (let* ((b (find-buffer "*cider-error*") ))
      (if b
          (let* ((w (get-buffer-window b) ))
            (if w
                (progn
                  (select-window w)
                  (cider-popup-buffer-quit-function)
                  ;;(kill-buffer b);; this leaves the window open
                  ))))))

(defun cider-keyboard-quit ()
  "Same as C-g but also exits any error pop ups."
  (interactive "*")
  (kill-cider-error)
  (keyboard-quit))

(defun cider-repl-buffer ()
  "Finds a the repl buffer based on project name. "
  (first (seq-filter (lambda (b)
                       (and
                        (string-match (projectile-project-name) (buffer-name b))
                        (string-match "cider-repl" (buffer-name b))))
                     (buffer-list))))

(defun cider-switch-to-repl-buffer ()
  ""
  (interactive "*")
  (let* ((b (cider-repl-buffer)))
    (if b (switch-to-buffer b))))

(defun cider-switch-to-repl-window ()
  ""
  (interactive "*")
  
  (let* ((b (cider-repl-buffer)))
    (if b
        (let* ((w (get-buffer-window b) ))
          (if w
              (progn
                (select-window w)))))))

(defun cider-show-repl ()
  ""
  (interactive "*")
  (let* ((b (cider-repl-buffer) ))
    (if b 
        (progn
          (call-interactively 'delete-other-windows)
          (split-window-below)
          (call-interactively 'other-window)
          ;;(tabbar-local-mode nil)
          (switch-to-buffer b)
          (call-interactively 'other-window)
          ))))


(defun cider-clear-repl-eval ()
  "evals so that printed output is at the top of repl for inspection"
  (interactive "*")
  (save-selected-window ;;save-mark-and-excursion
    (call-interactively 'cider-switch-to-repl-window)
    (call-interactively 'cider-repl-clear-buffer))
  (call-interactively 'cider-eval-last-sexp)
  (save-selected-window ;;save-mark-and-excursion
    (call-interactively 'cider-switch-to-repl-window)
    (beginning-of-buffer))
  )



(use-package cider
  :ensure t
  :commands (cider-connect cider-jack-in);;cider 
  
  :init;; runs before package is enabled
  (setq cider-repl-wrap-history t
        cider-repl-history-size 1000
        cider-repl-display-help-banner nil
        ;;cider-repl-history-file (f-expand ".cider-history" user-emacs-directory)
        cider-repl-history-file (concat user-emacs-directory ".cider-history")

        cider-auto-jump-to-error nil;; leave cursor where it's at
        
        ;; Don't know what these do yet
        ;; cider-auto-select-error-buffer t
        ;; cider-repl-pop-to-buffer-on-connect nil
        ;; cider-repl-use-clojure-font-lock t
        ;; cider-show-error-buffer t
        nrepl-hide-special-buffers t
        ;; nrepl-popup-stacktraces nil
        
        ;; When there's a cider error, show its buffer and switch to it
        cider-show-error-buffer  'except-in-repl ;;t 'only-in-repl ;; nil 'except-in-repl 'only-in-repl
        cider-auto-select-error-buffer nil
        
        ;; go right to the REPL buffer when it's finished connecting
        ;; don't hyjack frames and buffers on startup
        ;;cider-repl-pop-to-buffer-on-connect nil
        cider-repl-pop-to-buffer-on-connect 'display-only

        ;; Can inject different version of nrpl causing problems
        cider-inject-dependencies-at-jack-in t

        ;; https://github.com/clojure-emacs/cider/blob/9a4d6d9c1e2e1380e7afd762674a229ef1cd8485/cider-repl-history.el#L287
        ;; cider-repl-history-quit-action 'kill-and-delete-window
        
        ;; Change how CIDER starts a cljs-lein-repl
        ;; https://github.com/bhauman/lein-figwheel/wiki/Using-the-Figwheel-REPL-within-NRepl
        ;; cider-default-cljs-repl
        ;; "(do (require 'figwheel-sidecar.repl-api)
        ;;    (figwheel-sidecar.repl-api/start-figwheel!)
        ;;    (figwheel-sidecar.repl-api/cljs-repl))"
        
        )

  ;; provides minibuffer documentation for the code you're typing into the repl
  ;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  ;;(add-hook 'cider-mode-hook 'eldoc-mode)
  ;; enable paredit in your REPL
  ;;(add-hook 'cider-repl-mode-hook 'paredit-mode)

  
  :bind (:map clojure-mode-map
              ("C-c C-r" . cider-namespace-refresh)

              ("C-g" . cider-keyboard-quit)
              ("C-x p" . cider-clear-repl-eval)
              
              :map cider-repl-mode-map
              ("<up>" . cider-repl-previous-input)
              ("C-p" . cider-repl-previous-input)
              ("<down>" . cider-repl-next-input)
              ("C-n" . cider-repl-next-input)
              ("C-l" . cider-repl-clear-buffer)
              )

  :config ;;runs after package is loaded
  (progn
    ;;(add-to-list 'company-backends 'cider-complete-at-point)
    ;;(add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
    ;;(add-hook 'cider-mode-hook      #'cider-company-enable-fuzzy-completion)
    ;;(add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode) ;; suggest arguments at bottom ;;
    
    (add-hook 'cider-connected-hook (lambda ()
                                      (tabbar-local-mode nil)
                                      (display-line-numbers-mode -1)
                                      (linum-mode -1)))
    (add-hook 'cider-repl-mode-hook
              (lambda ()
                (define-key cider-repl-mode-map (kbd "<up>") 'cider-repl-previous-input)
                (define-key cider-repl-mode-map (kbd "C-p") 'cider-repl-previous-input)
                (define-key cider-repl-mode-map (kbd "<down>") 'cider-repl-next-input)
                (define-key cider-repl-mode-map (kbd "C-n") 'cider-repl-next-input)
                (define-key cider-repl-mode-map (kbd "C-l") 'cider-repl-clear-buffer)
                (add-hook 'kill-buffer-hook #'delete-window t t)
                ))))

;;================================================

(defun cider-namespace-refresh ()
  (interactive)
  (cider-interactive-eval
   "(require 'clojure.tools.namespace.repl)
  (clojure.tools.namespace.repl/refresh)"))

;;(define-key clojure-mode-map (kbd "C-c C-r") 'cider-namespace-refresh)



;; (add-hook 'cider-repl-mode-hook
;;           (lambda () 
;;             (define-key cider-repl-mode-map (kbd "<up>") 'cider-repl-previous-input)
;;             (define-key cider-repl-mode-map (kbd "C-p") 'cider-repl-previous-input)
;;             (define-key cider-repl-mode-map (kbd "<down>") 'cider-repl-next-input)
;;             (define-key cider-repl-mode-map (kbd "C-n") 'cider-repl-next-input)
;;             (define-key cider-repl-mode-map (kbd "C-l") 'cider-repl-clear-buffer)
;;             ))

(comment 
 ;;(add-hook 'cider-repl-mode-hook #'subword-mode)
 ;; (add-hook 'kill-buffer-hook
 ;;                        'cider-repl-history-cleanup-on-exit
 ;;                        nil t)
 )


;; key bindings
;; these help me out with the way I usually develop web apps
(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

;; ;(eval-after-load 'cider
;; (add-hook 'nrepl-connected-hook
;;   '(progn
;;      ;; Use pure up down for history
;;      (define-key nrepl-mode-map (kbd "<up>") 'nrepl-previous-input)
;;      (define-key nrepl-mode-map (kbd "<down>") 'nrepl-next-input)

;;      (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
;;      (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
;;      (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
;;           (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))
;;

 



