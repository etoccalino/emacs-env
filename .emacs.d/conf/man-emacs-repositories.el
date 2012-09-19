(package-initialize)

;; Marmalade repository
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; MELPA repository
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
