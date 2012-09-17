;; Marmalade repository
(package-initialize)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
