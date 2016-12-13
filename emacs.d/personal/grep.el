;;; Grep is wicked

;; Grep/Find.  This needs some cleanup
(setq grep-command "grep -Irine ")



(eval-after-load 'grep
  '(progn
     (add-to-list 'grep-find-ignored-files "*.log")
     (add-to-list 'grep-find-ignored-directories "auto")
     (add-to-list 'grep-find-ignored-directories "elpa")
     (add-to-list 'grep-find-ignored-directories "node_modules")
     (add-to-list 'grep-find-ignored-directories "bower_components")
     (add-to-list 'grep-find-ignored-directories "tmp")
     (add-to-list 'grep-find-ignored-directories "log")
     (add-to-list 'grep-find-ignored-directories "dist")
     (add-to-list 'grep-find-ignored-directories "releases")))

  ;; '(progn

  ;;    (add-to-list 'grep-find-ignored-directories "log")
  ;;    (add-to-list 'grep-find-ignored-directories "vendor")
  ;;    (add-to-list 'grep-find-ignored-directories "build")
  ;;    ))
