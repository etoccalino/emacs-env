;; DEPENDENCY WARNINGS:
;; * pep8, system
;; * pyflakes, system

;; Auto Complete mode
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-1.4/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/ac-dict")
(ac-config-default)

;; Ace Jump!
(add-to-list 'load-path "~/.emacs.d/elpa/ace-jump-mode-1.0")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Find Things Fast
(add-to-list 'load-path "~/.emacs.d/plugins/find-things-fast")
(require 'find-things-fast)
(global-set-key (kbd "C-x M-f") 'ftf-find-file)
(global-set-key (kbd "C-x M-s") 'ftf-grepsource)

;; PyFlakes integration
(add-to-list 'load-path "~/.emacs/elpa/pyflakes-1.0")
(add-to-list 'load-path "~/.emacs/elpa/flymake-cursor-1.0.2")
(add-to-list 'load-path "~/.emacs/elpa/rfringe-1.0.1")
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))

  (require 'rfringe)
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init))

  ;; bindings!
  (global-set-key [f10] 'flymake-goto-prev-error)
  (global-set-key [f11] 'flymake-goto-next-error)
  )
(load-library "flymake-cursor")
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; PEP8 command. It will complain if white space is left about.
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'pep8)

;;
;; byte-compile init files.
(add-hook 'after-save-hook 'byte-compile-current-buffer)
