;; Take a look at this:
;; http://ergoemacs.org/emacs/organize_your_dot_emacs.html

;;
;; Utility function to keep byte-compiled files updated after edits.
;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
