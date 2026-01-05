;;; Author: Gemini
;;; Date: January 5, 2026
;;; Modified by etoccalino.
;;;
;;; External Dependencies:
;;; - pandoc (for markdown preview, but see comments below)
;;; - fzf (Command-line fuzzy finder):
;;;    - Installation: https://github.com/junegunn/fzf#installation

;;;; ----------------------------------------------------------------------------
;;; # 1. Bootstrap `use-package`
;;;; ----------------------------------------------------------------------------
;;; `use-package` is an Emacs package that simplifies package management and
;;; configuration. The following code ensures that `use-package` is installed
;;; and available.

(require 'package)
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;;; ----------------------------------------------------------------------------
;;; Theme and Basic UI
;;;; ----------------------------------------------------------------------------

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t)) ; Load the theme, `t` suppresses the confirmation prompt

(setq-default
 inhibit-startup-message t   ; Disable the startup screen
 initial-scratch-message nil ; Clean up the scratch buffer
 cursor-type 'bar            ; Use a bar cursor instead of a block
 )
(tool-bar-mode -1)            ; Disable the toolbar
(menu-bar-mode -1)            ; Disable the menu bar
(scroll-bar-mode -1)          ; Disable the scroll bar
(set-face-attribute 'default nil :font "Inconsolata" :height 120) ; Set a clean font
(global-display-line-numbers-mode 1) ; Line numbers on the left hand side of the window

;;; --- Cycle through line display modes ---
;;; Custom function to cycle between normal, truncate, and visual-line modes
(defvar line-display-state 'normal
  "Current line display state: 'normal, 'truncate, or 'visual-line.")

(defun cycle-line-display-mode ()
  "Cycle through three line display modes: normal, truncate, and visual-line.
  - normal: truncate-lines off, visual-line-mode off
  - truncate: truncate-lines on, visual-line-mode off
  - visual-line: truncate-lines off, visual-line-mode on"
  (interactive)
  (cond
   ((eq line-display-state 'normal)
    ;; Switch to truncate mode
    (visual-line-mode -1)
    (setq-local truncate-lines t)
    (setq line-display-state 'truncate)
    (message "Line display: truncate"))

   ((eq line-display-state 'truncate)
    ;; Switch to visual-line mode
    (setq-local truncate-lines nil)
    (visual-line-mode 1)
    (setq line-display-state 'visual-line)
    (message "Line display: visual-line"))

   ((eq line-display-state 'visual-line)
    ;; Switch back to normal mode
    (visual-line-mode -1)
    (setq-local truncate-lines nil)
    (setq line-display-state 'normal)
    (message "Line display: normal"))

   (t
    ;; Default case if state is somehow corrupted
    (visual-line-mode -1)
    (setq-local truncate-lines nil)
    (setq line-display-state 'normal)
    (message "Line display: normal (reset)"))))

(global-set-key [f12] 'cycle-line-display-mode)

;; PEP8 (and good taste) indicate 4-space tabs.
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Use "y or n" insteas of "yes or no + ENTER".
(fset 'yes-or-no-p 'y-or-n-p)

;; Resize windows using the arrow keys
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Move the other window fast
(global-set-key (kbd "M-1") 'other-window)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(xclip-mode 1)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)) ; Enable beacon globally

;;;; ----------------------------------------------------------------------------
;;; # 3. Core Editing Enhancements
;;;; ----------------------------------------------------------------------------

;; Remove whitespace when saving prog files
(add-hook 'before-save-hook 'delete-prog-whitespace)
(defun delete-prog-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

;;; Highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0.1) ; Set a small delay for responsiveness
(set-face-attribute 'show-paren-match nil :background "#585858" :weight 'bold)

(use-package fzf
  :ensure t
  :bind (("C-x M-f" . fzf-find-file)) ; Bind as requested
  )

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

(use-package move-text
  :init (move-text-default-bindings))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

;;;; ----------------------------------------------------------------------------
;;; # 8. Markdown Mode
;;;; ----------------------------------------------------------------------------
;;; Provides a good base for editing Markdown files, like README.md.
;;; Markdown Mode Documentation: https://jblevins.org/projects/markdown-mode/

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init (setq markdown-command "multimarkdown")) ; Or "pandoc", "markdown", etc.

;;;; ----------------------------------------------------------------------------
;;; End of configuration
;;;; ----------------------------------------------------------------------------
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

;;;; ----------------------------------------------------------------------------
;;; Treesitter config
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

        (make "https://github.com/alemuller/tree-sitter-make")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
