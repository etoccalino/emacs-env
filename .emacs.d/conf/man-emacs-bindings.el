;; Toggle truncate with F12
(global-set-key [f12] 'toggle-truncate-lines)

;; Move the other window fast
(global-set-key (kbd "M-1") 'other-window)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
