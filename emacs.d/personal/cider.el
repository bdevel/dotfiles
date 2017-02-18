;;;;
;; Cider
;;;;

;; provides minibuffer documentation for the code you're typing into the repl
;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file (concat user-emacs-directory "cider-history"))

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)


;; don't hyjack frames and buffers on startup
(setq cider-repl-pop-to-buffer-on-connect nil)
;;(setq cider-repl-pop-to-buffer-on-connect 'display-only)

;; enable paredit in your REPL
;;(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


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

;(eval-after-load 'cider
(add-hook 'nrepl-connected-hook
  '(progn
     ;; Use pure up down for history
     (define-key nrepl-mode-map (kbd "<up>") 'nrepl-previous-input)
     (define-key nrepl-mode-map (kbd "<down>") 'nrepl-next-input)

     (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
     (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
     (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
          (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))
