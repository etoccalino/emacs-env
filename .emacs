;; Take a look at this:
;; http://ergoemacs.org/emacs/organize_your_dot_emacs.html

;;
;; Utility function to keep byte-compiled files updated after edits.
;;
(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))


;; GUI customizations
(load "~/.emacs.d/conf/man-emacs-gui.el")

;; General (re-)bindings
(load "~/.emacs.d/conf/man-emacs-bindings.el")

;; Repositories
(load "~/.emacs.d/conf/man-emacs-repositories.el")

;; Theme/s
(load "~/.emacs.d/conf/man-emacs-themes.el")

;; Plugins (auto-complete, ace-jump, pyflakes, etc)
(load "~/.emacs.d/conf/man-emacs-plugins.el")

;; Special modes (mail utils and my-write-mode)
(load "~/.emacs.d/conf/man-emacs-misc.el")

;; Configuration for Elfeed reader
(load "~/.emacs.d/conf/man-emacs-news.el")
