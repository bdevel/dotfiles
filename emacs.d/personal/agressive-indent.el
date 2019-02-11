

(global-aggressive-indent-mode 1)

(add-hook 'js2-mode-hook #'aggressive-indent-mode)
(add-hook 'ruby-mode-hook #'aggressive-indent-mode)
(add-hook 'web-mode-hook #'aggressive-indent-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
(add-hook 'clojurescript-mode-hook #'aggressive-indent-mode)
;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

