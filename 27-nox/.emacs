;; Take a look at this:
;; http://ergoemacs.org/emacs/organize_your_dot_emacs.html

;;
;; Utility function to keep byte-compiled files updated after edits.
;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)  // commented out for emacs 27 (emacs-snapshot-nox)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands notifications readonly ring scrolltobottom stamp track)))
 '(fill-column 79)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (zenburn-theme yasnippet rfringe pyflakes pep8 iedit flymake-cursor auto-complete ace-jump-mode)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rst-level-1-face ((t (:background "dim gray" :foreground "light sky blue"))) t)
 '(rst-level-2-face ((t (:background "dim gray" :foreground "light goldenrod"))) t)
 '(rst-level-3-face ((t (:background "dim gray" :foreground "LightCyan1"))) t)
 '(rst-level-4-face ((t (:background "dim gray" :foreground "chocolate1"))) t)
 '(rst-level-5-face ((t (:background "dim gray" :foreground "pale green"))) t)
 '(rst-level-6-face ((t (:background "dim gray" :foreground "aquamarine"))) t))
