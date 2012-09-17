;; DEPENDENCY WARNINGS:
;; * ~/.authinfo file in the $HOME
;; * ispell, with "castellano" dictionary

;; Writter mode :)
(defun my-write-mode ()
  (interactive)
  (text-mode)
  (toggle-word-wrap)
  (ispell-change-dictionary "castellano")
  (flyspell-mode)
  (auto-complete-mode)
  (message "Go nuts, man..."))

;; Sending mail. Compose with "C-x m" and send with "C-c C-c"
;; Uses the "~/.authinfo" file scheme, with content: "machine ${smtpserver} login ${username}@${domain} password ${pass}"
(setq send-mail-function 'smtpmail-send-it
     message-send-mail-function 'smtpmail-send-it
     smtpmail-starttls-credentials
     '(("smtp.gmail.com" 587 nil nil))
     smtpmail-auth-credentials
     (expand-file-name "~/.authinfo")
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-smtp-service 587
     smtpmail-debug-info t)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
