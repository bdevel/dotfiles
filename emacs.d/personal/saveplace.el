;; Purpose: When you visit a file, point goes to the last place where it was when you previously visited the same file.

(require 'saveplace)

(save-place-mode 1)
(setq save-place-file (concat user-emacs-directory "places"))
