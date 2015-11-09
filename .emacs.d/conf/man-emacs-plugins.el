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
;; add Django templates to the searched file types
(add-hook 'python-mode-hook (lambda () (ftf-add-filetypes '("*.html"))))

;; PyFlakes integration
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init))

  ;; bindings!
  (global-set-key [f10] 'flymake-goto-prev-error)
  (global-set-key [f11] 'flymake-goto-next-error)
  )
(require 'flymake-cursor)
(require 'rfringe)
(add-hook 'find-file-hook 'flymake-find-file-hook)
;; Disable flymake when editing HTML templates
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;; PEP8 command. It will complain if white space is left about.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'pep8)

;; Simple refactory through Iedit
(require 'iedit)

;; Yasnippet basic setup.
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20151108.1505")
(require 'yasnippet)
(yas-global-mode 1)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
