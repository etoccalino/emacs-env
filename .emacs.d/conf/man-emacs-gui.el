;; DEPENDENCY WARNINGS:
;; * inconsolata font, system

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;; Truncate lines over 80 chars, by default
(set-fill-column 79)
(toggle-truncate-lines 1)

;; Depends on the inconsolata font being installed in the system. It's worth it.
(set-frame-font "inconsolata-11")

;; PEP8 (and good taste) indicate 4-space tabs.
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
