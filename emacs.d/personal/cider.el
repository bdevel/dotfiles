;;;;
;; Cider
;;;;



(use-package cider
  :ensure t
  :commands (cider-connect cider-jack-in) ;;cider 
  
  :init;; runs before package is enabled
  (setq cider-repl-wrap-history t
        cider-repl-history-size 1000
        ;;cider-repl-history-file (f-expand ".cider-history" user-emacs-directory)
	cider-repl-history-file (concat user-emacs-directory ".cider-history")
	
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

        ;; Change how CIDER starts a cljs-lein-repl
        ;; https://github.com/bhauman/lein-figwheel/wiki/Using-the-Figwheel-REPL-within-NRepl
        cider-default-cljs-repl
        "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))"
        
        )

  ;; provides minibuffer documentation for the code you're typing into the repl
  ;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  ;; enable paredit in your REPL
  ;;(add-hook 'cider-repl-mode-hook 'paredit-mode)

  
  :bind (:map clojure-mode-map
              ("C-c C-r" . cider-namespace-refresh)

              :map cider-repl-mode-map
              ("<up>" . cider-repl-previous-input)
              ("C-p" . cider-repl-previous-input)
              ("<down>" . cider-repl-next-input)
              ("C-n" . cider-repl-next-input)
              ("C-l" . cider-repl-clear-buffer)
              )

  :config ;;runs after package is loaded
  (progn
    (add-to-list 'company-backends 'cider-complete-at-point)
    ;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
    (add-hook 'cider-repl-mode-hook
              (lambda ()
                (define-key cider-repl-mode-map (kbd "<up>") 'cider-repl-previous-input)
                (define-key cider-repl-mode-map (kbd "C-p") 'cider-repl-previous-input)
                (define-key cider-repl-mode-map (kbd "<down>") 'cider-repl-next-input)
                (define-key cider-repl-mode-map (kbd "C-n") 'cider-repl-next-input)
                (define-key cider-repl-mode-map (kbd "C-l") 'cider-repl-clear-buffer)
                )))

  
  )

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

 
(defun cider-repl-buffer ()
    ""
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

(defun cider-show-repl ()
  ""
  (interactive "*")
  (let* ((b (cider-repl-buffer) ))
    (if b 
        (progn
          (split-window-below)
          (call-interactively 'other-window)
          (switch-to-buffer b)
          (call-interactively 'other-window)
          ))))




