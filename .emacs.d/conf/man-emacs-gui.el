;; DEPENDENCY WARNINGS:
;; * inconsolata font, system

(custom-set-variables
 '(column-number-mode t)
 '(fill-column 79)
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
;; No scroll bars.
(setq scroll-bar-mode -1)
;; Truncate lines over 80 chars, by default
(setq fill-column 79)
(toggle-truncate-lines 1)

;; Depends on the inconsolata font being installed in the system. It's worth it.
(set-frame-font "inconsolata-11")
;; Set the face in all frames, so I can run as daemon.
(setq default-frame-alist '((font . "inconsolata-11")))

;; PEP8 (and good taste) indicate 4-space tabs.
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Uniquify file names, using path-like style.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
