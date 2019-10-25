;; If snippets fail to load, try removing the .yas-compiled-snippets.el
;; file in the snippet mode directory.

(yas-global-mode 1)

;; (yas-load-directory "~/.emacs.d/vendor/yasnippets-rails/rails-snippets")
;;(yas-load-directory (concat user-emacs-directory "snippets"))



;; Writing snippets:
;; http://joaotavora.github.io/yasnippet/snippet-development.html#org185b594

(package 'clojure-snippets)


;; (require 'popup)
;; (popup-menu* (list (popup-make-item "Yes" :value t)
;;                    (popup-make-item "No" :value nil)))
;; (popup-cascade-menu '(("Top1" "Sub1" "Sub2") "Top2"))
;; (popup-cascade-menu '(("Top1" "Sub1" "Sub2") "Top2"))

(add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)
(add-hook 'clojure-mode-hook 'yas-minor-mode)


;; Completing point by some yasnippet key
(defun yas-ido-expand ()
  "Lets you select (and expand) a yasnippet key"
  (interactive)
    (let ((original-point (point)))
      (while (and
              (not (= (point) (point-min) ))
              (not
               (string-match "[[:space:]\n]" (char-to-string (char-before)))))
        (backward-word 1))
    (let* ((init-word (point))
           (word (buffer-substring init-word original-point))
           (list (yas-active-keys)))
      (goto-char original-point)
      (let ((key (remove-if-not
                  (lambda (s) (string-match (concat "^" word) s)) list)))
        (if (= (length key) 1)
            (setq key (pop key))
          (setq key (ido-completing-read "key: " list nil nil word)))
        (delete-char (- init-word original-point))
        (insert key)
        (yas-expand)))))

