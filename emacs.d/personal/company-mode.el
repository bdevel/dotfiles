

;; make global
;;(company-my-backend 'prefix "foo")
;; (company-etags 'prefix "foo")
(load "~/.emacs.d/vendor/company-tabnine/company-tabnine.el")
(global-company-mode)
;;(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 0)
(setq company-show-numbers t)

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;;(add-to-list 'company-backends 'company-yasnippet)
;;(add-to-list 'company-backends #'company-tabnine)
(setq company-backends '(company-tabnine))
;; Make number select work
;; Credit: https://oremacs.com/2017/12/27/company-numbers/
(defun ora-company-number ()
  "Forward to `company-complete-number'.

Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
      (company-complete-number (string-to-number k)))))


;; See https://github.com/company-mode/company-mode/blob/master/company.el#L661
;; for default key map
(let ((map company-active-map))
  (mapc
   (lambda (x)
     (define-key map (format "%d" x) 'ora-company-number))
   (number-sequence 0 9))
  (define-key map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  ;;(define-key map (kbd "<return>") 'company-complete-selection)
  ;;(define-key map (kbd "<tab>") 'company-complete)
  (define-key map (kbd "<return>") 'newline)
  (define-key map (kbd "<tab>") 'company-complete-selection)
  )

;; (defun company-my-backend (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))
;;   (case command
;;     (interactive (company-begin-backend 'company-my-backend))
;;     (prefix (when (looking-back "foo\\>")
;;               (match-string 0)))
;;     (candidates (when (equal arg "foo")
;;                   (list "foobar" "foobaz" "foobarbaz")))
;;     (meta (format "This value is named %s" arg))))


;; (set 'company-backends '(cider-complete-at-point
;;                          ;;company-robe ; not very smart
;;                          company-yasnippet
;;                          company-semantic
;;                         ;; company-my-backend
;;                          ;;company-etags
;;                          ;;company-css
;;                          ;;company-dabbrev-code
;;                          ;;company-dabbrev

;;                          ))

;;(company-semantic 'prefix "c")

;; company-backends


;; thanks! https://www.emacswiki.org/emacs/TabCompletion
(defun indent-or-complete ()
      "Complete if point is at end of a word, otherwise indent line."
      (interactive)
      (if (looking-at "\\>")
          ;;(dabbrev-expand nil)
          (company-complete)
        (indent-for-tab-command)
        ))

;; To disable automatic expand, do this:
(setq company-idle-delay nil) ; never start completions automatically
(global-set-key (kbd "TAB") #'indent-or-complete)


;; ruby/rails. must to robe-start

;;(add-to-list 'company-backends 'company-sample-backend)

;; original list
;; '(company-robe
;;   company-bbdb ;; Big Brother Database (email)
;;   company-eclim
;;   company-semantic
;;   company-clang
;;   company-xcode
;;   company-cmake
;;   company-capf
;;   company-files
;;   company-oddmuse
;;   company-dabbrev
;;   (company-dabbrev-code
;;    company-gtags
;;    company-etags
;;    company-keywords))


;; To customize other aspects of its behavior, type M-x customize-group RET company.

;;(global-set-key "\t" 'indent-for-tab-command)
