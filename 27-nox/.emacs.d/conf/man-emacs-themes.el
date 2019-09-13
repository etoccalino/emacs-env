;; Default theme: zenburn
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-1.5")
(load-theme 'zenburn t)

;; ReStructuredText to go along with zenburn
(custom-set-faces
 '(rst-level-1-face ((t (:background "dim gray" :foreground "light sky blue"))) t)
 '(rst-level-2-face ((t (:background "dim gray" :foreground "light goldenrod"))) t)
 '(rst-level-3-face ((t (:background "dim gray" :foreground "LightCyan1"))) t)
 '(rst-level-4-face ((t (:background "dim gray" :foreground "chocolate1"))) t)
 '(rst-level-5-face ((t (:background "dim gray" :foreground "pale green"))) t)
 '(rst-level-6-face ((t (:background "dim gray" :foreground "aquamarine"))) t))

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
