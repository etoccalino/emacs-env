;; JS+React config. Supposed to be used with ~/.emacs.d.react directory as home.
;;

;; Load the common configs
(load "~/.emacs.base.el")

;; Original guide in https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/

(use-package lsp-mode
  :hook ((js-mode js-jsx-mode js-ts-mode js-json-mode js-base-mode) . lsp)
  :bind (:map lsp-mode-map
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c C-n" . flycheck-next-error)
              ("C-c C-c C-p" . flycheck-previous-error))
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c h" . lsp-ui-doc-glance))
  :config
  (add-hook lsp-enable-which-key-integration)
  :custom
  (js-indent-level 2)
  ;; See: https://emacs-lsp.github.io/lsp-mode/page/performance/
  (read-process-output-max 8192)
  (gc-cons-threshold 100000000)
  (create-lockfiles nil)) ;; lock files will kill `npm start'

(use-package lsp-treemacs)

(use-package helm)

(use-package helm-lsp)

(use-package helm-xref)

(use-package projectile)

(use-package company
  :bind (([remap find-file] . #'helm-find-files)
         ([remap execute-extended-command] . #'helm-M-x)
         ([switch-to-buffer] . #'helm-mini))
  :custom
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1))

(use-package flycheck)

(use-package json-mode)

(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))
