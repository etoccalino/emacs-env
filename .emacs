;;
;; Dependencies:
;; * xsel (system) - tool to manage the clipboard
;; * inconsolata font (system)
;; * use-package repo (.emacs.d) - https://github.com/jwiegley/use-package
;; * fzf (system) - file fuzzy finder - https://github.com/junegunn/fzf

;; TODO:
;; * use ensure-system-package to verify system dependencies? https://github.com/jwiegley/use-package#use-package-ensure-system-package

(require 'package)
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;          Utilities            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ref: https://gist.github.com/ktabata/4362498
;; Copy/paste from emacs-nox to/from the clipboard
(defun x-paste ()  ;; not bound... can used "C-V" (pre-existent "xterm-paste")
  "insert text on X11's clipboard to current buffer."
  (interactive)
  (insert-string (shell-command-to-string "xsel -b"))
  (message "Pasted from clipboard"))
(defun x-copy ()
  "copy text on local kill-ring to X11's clipboard."
  (interactive)
  (copy-region-as-kill (point) (mark t))
  (let ((process-connection-type nil))
      (let ((proc (start-process "xsel" "*Messages*" "xsel" "-i" "-b")))
        (process-send-string proc (car kill-ring))
        (process-send-eof proc)))
  (message "Copied to clipboard"))

;; Set ":ensure" for all packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      GUI configuration        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(mouse-yank-at-point t)
 '(erc-modules
   '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands notifications readonly ring scrolltobottom stamp track))
 '(fill-column 99)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(package-selected-packages
   '(exec-path-from-shell toml-mode rust-playground company yasnippet flycheck lsp-ui lsp-mode rustic iedit ace-jump-mode auto-complete find-things-fast zenburn-theme use-package smex))
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(show-paren-mode t)
 '(x-select-enable-clipboard t)
 '(truncate-lines t))
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

;; Use "y or n" insteas of "yes or no + ENTER".
(fset 'yes-or-no-p 'y-or-n-p)

;; Depends on the inconsolata font being installed in the system. It's worth it.
(set-frame-font "inconsolata-13")
;; Set the face in all frames, so emacs can run as daemon.
(setq default-frame-alist '((font . "inconsolata-13")))

;; PEP8 (and good taste) indicate 4-space tabs.
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Remove whitespace when saving prog files
(add-hook 'before-save-hook 'delete-prog-whitespace)
(defun delete-prog-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

(use-package zenburn-theme
  :config (load-theme 'zenburn t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       Special bindings        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Resize windows using the arrow keys
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Toggle truncate with F12
(global-set-key [f12] 'toggle-truncate-lines)

;; Move the other window fast
(global-set-key (kbd "M-1") 'other-window)

;; Comment or uncomment region.
(global-set-key (kbd "C-c C-j") 'comment-or-uncomment-region)

;; Copy/Paste to clipboard (see defun's at .emacs)
(global-set-key (kbd "C-M-c") #'x-copy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package smex
  :bind ("M-x" . smex)
  :config (smex-initialize))

(use-package which-key
  :init (which-key-mode))

(use-package yaml-mode)

(use-package dockerfile-mode)

(use-package auto-complete
  :config
  (ac-config-default)
  ;; set auto-complet-mode for every buffer but the minibuffer
  (defun auto-complete-mode-maybe ()
    (unless (minibufferp (current-buffer))
      (auto-complete-mode 1))))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

(use-package iedit)
  ;; DISABLING below configs: I can't make it work right for both NOX and GUI, so I'm choosing GUI.
  ;;
  ;; :bind (("C-\\" . iedit-mode) ;; gnome-terminal doesn't let "C-;" nor "C-'", so rebind iedit-mode
  ;;        ("\\" . #'iedit-show/hide-context-lines))
  ;; :config
  ;; (define-key isearch-mode-map (kbd "C-\\") #'iedit-mode-from-isearch))

(use-package beacon
  :init (beacon-mode))

(use-package org-superstar
  :config (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package fzf
  :bind (("C-x M-f" . fzf-git-files)))

;; For Rust: load rustic with rust-analyzer & a bunch of goodies
(load "~/.emacs.d/rust-ide.el")

;; For python, expecting to have python-lsp-server installed
;; (use `pip install python-lsp-server[all]` in your venv)
(load "~/.emacs.d/python-ide.el")
