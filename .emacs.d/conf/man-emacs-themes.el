;; Themes repository
(setq custom-theme-directory "~/.emacs.d/themes")

;; DEPENDENCY WARNING: zenburn!

;; Default theme: zenburn, for emacs24
(load-theme 'zenburn t)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
