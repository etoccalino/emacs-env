;; Common config to all configs.
;;

;;
;; Dependencies:
;; * xsel (system) - tool to manage the clipboard
;; * inconsolata font (system)
;; * use-package repo (.emacs.d) - https://github.com/jwiegley/use-package
;; * fzf (system) - file fuzzy finder - https://github.com/junegunn/fzf
;;
;; First time use:
;; * Run `M-x treesit-install-language-grammar` once to download the language support for tree-sitter.

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
 '(line-number-mode nil)
 '(column-number-mode nil)
 '(fill-column 99)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(mouse-yank-at-point t)
 '(scroll-bar-mode nil)
 '(select-enable-clipboard t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(truncate-lines t))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Use "y or n" insteas of "yes or no + ENTER".
(fset 'yes-or-no-p 'y-or-n-p)

;; ;; Depends on the inconsolata font being installed in the system. It's worth it.
(add-to-list 'default-frame-alist
             '(font . "inconsolata-13"))

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
;;       Treesitter config       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq treesit-language-source-alist
      '((bash       "https://github.com/tree-sitter/tree-sitter-bash")
        (rust       "https://github.com/tree-sitter/tree-sitter-rust")
        (css        "https://github.com/tree-sitter/tree-sitter-css")
        (go         "https://github.com/tree-sitter/tree-sitter-go")
        (html       "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json       "https://github.com/tree-sitter/tree-sitter-json")
        (python     "https://github.com/tree-sitter/tree-sitter-python")
        (toml       "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")

        (make "https://github.com/alemuller/tree-sitter-make")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package smex
  :bind ("M-x" . smex)
  :config (smex-initialize))

(use-package which-key
  :init (which-key-mode))

(use-package iedit)
  ;; :bind (("C-\\" . iedit-mode) ;; gnome-terminal doesn't let "C-;" nor "C-'", so rebind iedit-mode
  ;;        ("C-;" . #'iedit-show/hide-context-lines))
  ;; :config
  ;; (define-key isearch-mode-map (kbd "C-\\") #'iedit-mode-from-isearch))

(use-package beacon
  :init (beacon-mode))

(use-package move-text
  :init (move-text-default-bindings))

(use-package fzf
  :bind (("C-x M-f" . fzf-git-files)))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))
