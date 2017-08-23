;;;;
;; Cider
;;;;


(use-package cider
  :ensure t
  :commands (cider-connect cider-jack-in) ;;cider 
  
  :init;; runs before package is enabled
  (setq cider-repl-wrap-history t
        cider-repl-history-size 1000
        cider-repl-history-file (f-expand ".cider-history" user-emacs-directory)
        ;; Don't know what these do yet
        ;; cider-auto-select-error-buffer t
        ;; cider-repl-pop-to-buffer-on-connect nil
        ;; cider-repl-use-clojure-font-lock t
        ;; cider-show-error-buffer t
        ;; nrepl-hide-special-buffers t
        ;; nrepl-popup-stacktraces nil
        
        ;; go right to the REPL buffer when it's finished connecting
        cider-repl-pop-to-buffer-on-connect t

        ;; When there's a cider error, show its buffer and switch to it
        cider-show-error-buffer t
        cider-auto-select-error-buffer t

        
        ;; don't hyjack frames and buffers on startup
        cider-repl-pop-to-buffer-on-connect nil
        ;;cider-repl-pop-to-buffer-on-connect 'display-only
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


  ;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook
            (lambda ()
              (define-key cider-repl-mode-map (kbd "<up>") 'cider-repl-previous-input)
              (define-key cider-repl-mode-map (kbd "C-p") 'cider-repl-previous-input)
              (define-key cider-repl-mode-map (kbd "<down>") 'cider-repl-next-input)
              (define-key cider-repl-mode-map (kbd "C-n") 'cider-repl-next-input)
              (define-key cider-repl-mode-map (kbd "C-l") 'cider-repl-clear-buffer)
            ))

  
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
