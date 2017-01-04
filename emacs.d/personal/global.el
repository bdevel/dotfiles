;;; Generic emacs settings I cannot live without

;; don't use desktop mode for terminal
(when (display-graphic-p)
  (desktop-save-mode 1); is x window
  ())


;; Don't show the startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)
(pending-delete-mode t)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  nil)

;; Modeline info
;(display-time-mode 1)
;; (display-battery-mode 1)

;; Emacs gurus don't need no stinking scroll bars
;; (when (fboundp 'toggle-scroll-bar)
;;   (toggle-scroll-bar -1))
(toggle-scroll-bar nil)

;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)

;; Line-wrapping
(set-default 'fill-column 78)


;; Make identifiers with hyphens to be one word
;;(modify-syntax-entry ?_ "w" (standard-syntax-table))
;;(modify-syntax-entry ?- "w" (standard-syntax-table))
;(modify-syntax-entry ?- "w")
;(modify-syntax-entry ?_ "w"); same for underscores

;; Prevent the annoying beep on errors
;; (setq visible-bell t)

;; Make sure all backup files only live in one place
;;(setq backup-directory-alist (concat user-emacs-directory ".backups"))
;;(setq backup-directory-alist "~/.emacs.d/.backups")

;; disable auto save
(setq auto-save-default nil)

;; No need for ~ files when editing
(setq create-lockfiles nil)

;; Gotta see matching parens
(show-paren-mode t)

;; Don't truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; For emacsclient
;;(server-start)

;; Trailing whitespace is unnecessary
(defvar whitespace-cleanup-on-save t)
;; (setq whitespace-cleanup-on-save nil)
(add-hook 'before-save-hook
    (lambda ()
      (if whitespace-cleanup-on-save (whitespace-cleanup))))

;; Trash can support
(setq delete-by-moving-to-trash t)

;; `brew install aspell --lang=en` (instead of ispell)
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; "When several buffers visit identically-named files,
;; Emacs must give the buffers distinct names. The usual method
;; for making buffer names unique adds ‘<2>’, ‘<3>’, etc. to the end
;; of the buffer names (all but one of them).
;; The forward naming method includes part of the file's directory
;; name at the beginning of the buffer name
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


;; fix weird os x kill error
;; (defun ns-get-pasteboard ()
;;   "Returns the value of the pasteboard, or nil for unsupported formats."
;;   (condition-case nil
;;       (ns-get-selection-internal 'CLIPBOARD)
;;   (quit nil)))


;; annoying
(setq electric-indent-mode nil)

;; zap-up-to-char, forward-to-word, backward-to-word, etc
;(require 'misc)
