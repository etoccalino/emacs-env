;;; Date: January 5, 2026
;;;
;;; External Dependencies:
;;; - pandoc (for markdown preview)
;;; - fzf (Command-line fuzzy finder): https://github.com/junegunn/fzf#installation

;;;; ----------------------------------------------------------------------------
;;; Package Management
;;;; ----------------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;;;; ----------------------------------------------------------------------------
;;; Theme and UI
;;;; ----------------------------------------------------------------------------

;; Low-contrast dark theme designed to reduce eye strain
(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

;; Visual beacon that highlights cursor after jumps
(use-package beacon
  :config
  (beacon-mode 1))

;; Basic UI settings
(setq-default
 inhibit-startup-message t
 initial-scratch-message nil
 cursor-type 'bar
 tab-width 4
 indent-tabs-mode nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :font "Inconsolata" :height 120)
(global-display-line-numbers-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Parenthesis highlighting
(show-paren-mode 1)
(setq show-paren-delay 0.1)
(set-face-attribute 'show-paren-match nil :background "#585858" :weight 'bold)

;; Clipboard integration
(xclip-mode 1)

;;;; ----------------------------------------------------------------------------
;;; Navigation and Discovery
;;;; ----------------------------------------------------------------------------

;; Enhanced M-x with history and completion
(use-package smex
  :bind ("M-x" . smex)
  :config (smex-initialize))

;; Displays available key bindings in popup
(use-package which-key
  :init (which-key-mode))

;; Fuzzy file finder integration
(use-package fzf
  :bind ("C-x M-f" . fzf-find-file))

;; Rapid cursor navigation using character labels
(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

;;;; ----------------------------------------------------------------------------
;;; Editing Enhancements
;;;; ----------------------------------------------------------------------------

;; Move lines/regions up and down
(use-package move-text
  :init (move-text-default-bindings))

;; Markdown editing mode
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :init (setq markdown-command "multimarkdown"))

;; Remove trailing whitespace in prog-mode
(add-hook 'before-save-hook 'delete-prog-whitespace)
(defun delete-prog-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

;;;; ----------------------------------------------------------------------------
;;; Keybindings
;;;; ----------------------------------------------------------------------------

;; Use "y or n" instead of "yes or no + ENTER"
(fset 'yes-or-no-p 'y-or-n-p)

;; Window resizing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Quick window switching
(global-set-key (kbd "M-1") 'other-window)

;; Line display mode cycling (F12)
(defvar line-display-state 'normal
  "Current line display state: 'normal, 'truncate, or 'visual-line.")

(defun cycle-line-display-mode ()
  "Cycle through three line display modes: normal, truncate, and visual-line."
  (interactive)
  (cond
   ((eq line-display-state 'normal)
    (visual-line-mode -1)
    (setq-local truncate-lines t)
    (setq line-display-state 'truncate)
    (message "Line display: truncate"))
   ((eq line-display-state 'truncate)
    (setq-local truncate-lines nil)
    (visual-line-mode 1)
    (setq line-display-state 'visual-line)
    (message "Line display: visual-line"))
   ((eq line-display-state 'visual-line)
    (visual-line-mode -1)
    (setq-local truncate-lines nil)
    (setq line-display-state 'normal)
    (message "Line display: normal"))
   (t
    (visual-line-mode -1)
    (setq-local truncate-lines nil)
    (setq line-display-state 'normal)
    (message "Line display: normal (reset)"))))

(global-set-key [f12] 'cycle-line-display-mode)

;; Enable disabled commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

;;;; ----------------------------------------------------------------------------
;;; Tree-sitter Configuration
;;;; ----------------------------------------------------------------------------

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
        (make       "https://github.com/alemuller/tree-sitter-make")
        (cmake      "https://github.com/uyha/tree-sitter-cmake")
        (elisp      "https://github.com/Wilfred/tree-sitter-elisp")
        (markdown   "https://github.com/ikatyang/tree-sitter-markdown")
        (yaml       "https://github.com/ikatyang/tree-sitter-yaml")))
