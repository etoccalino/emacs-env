;; DEPENDENCY WARNINGS:
;; * pep8, system
;; * pyflakes, system

;; Auto Complete mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/ac-dict")
(ac-config-default)

;; Ace Jump!
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Find Things Fast
(add-to-list 'load-path "~/.emacs.d/plugins/find-things-fast")
(require 'find-things-fast)
(global-set-key (kbd "C-x M-f") 'ftf-find-file)
(global-set-key (kbd "C-x M-s") 'ftf-grepsource)
(add-to-list 'ftf-filetypes "*.jsx")                                                                                                                 ;; add Django templates to the searched file types
(add-hook 'python-mode-hook (lambda () (ftf-add-filetypes '("*.html"))))

;; RJSX-mode
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode))

;; PEP8 command. It will complain if white space is left about.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'pep8)

;; Simple refactory through Iedit
(require 'iedit)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
