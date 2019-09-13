;; Toggle truncate with F12
(global-set-key [f12] 'toggle-truncate-lines)

;; Move the other window fast
(global-set-key (kbd "M-1") 'other-window)

;; Comment or uncomment region.
(global-set-key (kbd "C-c C-j") 'comment-or-uncomment-region)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
