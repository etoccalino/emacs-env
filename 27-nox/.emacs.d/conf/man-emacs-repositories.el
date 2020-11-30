(package-initialize)

;; Marmalade repository
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; MELPA repository
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
