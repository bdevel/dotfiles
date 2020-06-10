;;; Personal functions

(package-initialize)
(require 'package)
;; For loading personal configurations
(defun personal (library)
  (load (concat "~/.emacs.d/personal/" (symbol-name library)) 'noerror))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; For loading packages from the Emacs Lisp Package Archive (ELPA)
(defun package (package)
  (when (not (package-installed-p package))
    (package-install package))
  (personal package))

(package 'use-package)

;; (require 'use-package)

;; For loading libraries from the vendor directory
;; Modified from defunkt's original version to support autoloading.
;; http://github.com/defunkt/emacs/blob/master/defunkt/defuns.el
;; (defun vendor (library &rest autoload-functions)
;;   (let* ((file (symbol-name library))
;;          (normal (concat "~/.emacs.d/vendor/" file))
;;          (suffix (concat normal ".el"))
;;          (found nil))
;;     (cond
;;      ((file-directory-p normal) (add-to-list 'load-path normal) (set 'found t))
;;      ((file-directory-p suffix) (add-to-list 'load-path suffix) (set 'found t))
;;      ((file-exists-p suffix)  (set 'found t)))
;;     (when found
;;       (if autoload-functions
;;           (dolist (autoload-function autoload-functions)
;;             (autoload autoload-function (symbol-name library) nil t))
;;         (require library)))
;;     (personal library)))

(defun ty-eval-buffer ()
  ""
  (interactive "*")
  (progn
    (save-buffer)
    (if (equal 'clojure-mode major-mode)
        (call-interactively 'cider-eval-buffer)
      (call-interactively 'eval-buffer))
    (message "Buffer saved, eval!")))

(defun ty-eval-defun ()
    ""
  (interactive "*")
    (progn
      (if (equal 'clojure-mode major-mode)
          (call-interactively 'cider-eval-defun-at-point)
        (call-interactively 'eval-defun))))


(defun ty-eval-last-sexp ()
    ""
    (interactive "*")
    (progn
      (if (equal 'clojure-mode major-mode)
          (call-interactively 'cider-eval-last-sexp)
        (call-interactively 'eval-last-sexp)) ))

(defun ty-eval-region ()
    ""
    (interactive "*")
    (progn
      (if (equal 'clojure-mode major-mode)
          (call-interactively 'cider-eval-region)
        (call-interactively 'eval-region))
      (message "eval region!")))


;; https://www.emacswiki.org/emacs/DeletingWhitespace
(defun kill-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
        (progn
          (re-search-backward "[^ \t\r\n]" nil t)
          (re-search-forward "[ \t\r\n]+" nil t)
          (replace-match "" nil nil))))))



(defun copy-region-dont-deactivate (beg end &optional region)
  "Save the region to kill-ring, don't kill it, keep region active."
  (interactive (list (mark) (point)
		                 (prefix-numeric-value current-prefix-arg)))
  (let ((str (if region
                 (funcall region-extract-function nil)
               (filter-buffer-substring beg end))))
    (if (eq last-command 'kill-region)
        (kill-append str (< end beg))
      (kill-new str)))
  nil)


;; query-replace current word
(defun qrc (replace-str)
   (interactive "sDo query-replace current word with: ")
   (forward-word)
   (let ((end (point)))
      (backward-word)
      (kill-ring-save (point) end)
      (query-replace (current-kill 0) replace-str) ))

(defun duplicate-region ()
  (interactive)
  ""
  )

;; http://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun comment-or-uncomment-region-or-line (arg)
    "Comments or uncomments the region or the current line if there's no active region."
  (interactive "p")
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; Things that were in here already ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Arrows are common, especially in ruby
(defun insert-arrow ()
  (interactive)
  (delete-horizontal-space)
  (insert " => "))

(defun insert-file-name ()
  "Insert the full path file name into the current buffer."
  (interactive)
  (insert (buffer-file-name (window-buffer (minibuffer-selected-window)))))

;; Quickly jump back and forth between matching parens/brackets
(defun match-paren (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))

;; Make the whole buffer pretty and consistent
(defun iwb()
  "Indent Whole Buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun delete-window-replacement (&optional p)
  "Kill current window.  If called with PREFIX, kill the buffer too."
  (interactive "P")
  (if p
      (kill-buffer nil))
  (delete-window))

(defun delete-other-windows-replacement (&optional p)
  "Make the selected window fill its frame.  If called with PREFIX,
kill all other visible buffers."
  (interactive "P")
  (if p
      (dolist (window (window-list))
        (unless (equal (window-buffer window) (current-buffer))
          (kill-buffer (window-buffer window)))))
  (delete-other-windows))

;; ;; Use the text around point as a cue what it is that we want from the
;; ;; editor. Allowance has to be made for the case that point is at the
;; ;; edge of a buffer.
;; (defun indent-or-expand (arg)
;;   "Either indent according to mode, or expand the word preceding
;; point."
;;   (interactive "*P")
;;   (if (and
;;        (or (bobp) (= ?w (char-syntax (char-before))))
;;        (or (eobp) (not (= ?w (char-syntax (char-after))))))
;;       (dabbrev-expand arg)
;;     (indent-according-to-mode)))

;; This override for transpose-words fixes what I consider to be a flaw with the
;; default implementation in simple.el. To traspose chars or lines, you always
;; put the point on the second char or line to transpose with the previous char
;; or line.  The default transpose-words implementation does the opposite by
;; flipping the current word with the next word instead of the previous word.
;; The new implementation below instead makes transpose-words more consistent
;; with how transpose-chars and trasponse-lines behave.
(defun transpose-words (arg)
  "[Override for default transpose-words in simple.el]
Interchange words around point, leaving point at end of
them. With prefix arg ARG, effect is to take word before or
around point and drag it backward past ARG other words (forward
if ARG negative).  If ARG is zero, the words around or after
point and around or after mark are interchanged."
  (interactive "*p")
  (if (eolp) (forward-char -1))
  (transpose-subr 'backward-word arg)
  (forward-word (+ arg 1)))

;; Borrowed from https://gist.github.com/1415844
;; Also see http://emacsworld.blogspot.com/2011/12/moving-buffers-between-windows.html
(require 'cl)
(defun rotate-left (l)
  (append  (cdr l) (list (car l))))
(defun rotate-windows ()
  (interactive)
  (let ((start-positions (rotate-left (mapcar 'window-start (window-list))))
        (buffers (rotate-left (mapcar 'window-buffer (window-list)))))
    (mapcar* (lambda (window  buffer pos)
               (set-window-buffer window buffer)
               (set-window-start window pos))
             (window-list)
             buffers
             start-positions)))

;; Borrowed from http://whattheemacsd.com/key-bindings.el-01.html
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

;; Borrowed from http://superuser.com/q/603421/8424
;;(defun replace-smart-quotes (beg end)
;;  "Replace 'smart quotes' in buffer or region with ascii quotes."
;;  (interactive "r")
;;  (format-replace-strings '(("\x201C" . "\"")
;;                            ("\x201D" . "\"")
;;                            ("\x2018" . "'")
;;                            ("\x2019" . "'"))
;;                          nil beg end))

(defun yank-and-replace-smart-quotes ()
  "Yank (paste) and replace smart quotes from the source with ascii quotes."
  (interactive)
  (yank)
  (replace-smart-quotes (mark) (point)))
