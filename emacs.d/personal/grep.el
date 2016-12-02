;;; Grep is wicked

;; Grep/Find.  This needs some cleanup
(setq grep-command "grep -Irine ")

;; (eval-after-load 'grep
;;   '(grep-find-ignored-directories
;;    (quote
;;     ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "node_modules" "bower_components" "tmp" "dist" "releases"))))


  ;; '(progn
  ;;    (add-to-list 'grep-find-ignored-files "*.log")
  ;;    (add-to-list 'grep-find-ignored-directories "log")
  ;;    (add-to-list 'grep-find-ignored-directories "vendor")
  ;;    (add-to-list 'grep-find-ignored-directories "build")
  ;;    ))
