;; Default theme: zenburn
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-1.5")
(load-theme 'zenburn t)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
