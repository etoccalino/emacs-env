;; JS+React config. Supposed to be used with ~/.emacs.d.react directory as home.
;;
;; First time use:
;; * Install the "all-the-icons" set for neo-tree: `M-x all-the-icons-install-fonts` and then run `fc-cache -f -v` in the system.

;; Load the common configs
(load "~/.emacs.base.el")

;; Original guide in https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/

(use-package lsp-mode
  :hook ((js-mode js-jsx-mode js-ts-mode js-json-mode js-base-mode) . lsp)
  :bind (:map lsp-mode-map
              ("M-?" . (lambda() (interactive) (lsp-treemacs-references t)))
              ("C-M-?" . lsp-treemacs-references)
              ("C-c C-c L" . lsp-treemacs-errors-list)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c C-n" . flycheck-next-error)
              ("C-c C-c C-p" . flycheck-previous-error)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c h" . lsp-ui-doc-glance))
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  :custom
  ;; See: https://emacs-lsp.github.io/lsp-mode/page/performance/
  (read-process-output-max 8192)
  (gc-cons-threshold 100000000)
  (create-lockfiles nil)) ;; lock files will kill `npm start'

(use-package treemacs
  :defer
  :bind ([f8] . treemacs))

(use-package lsp-treemacs
  :after lsp)

(use-package helm)

(use-package helm-lsp)

(use-package helm-xref)

(use-package company
  :bind (([remap list-buffers] . #'helm-buffers-list)
         ([remap execute-extended-command] . #'helm-M-x)
         ([switch-to-buffer] . #'helm-mini))
  :custom
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1))

(use-package flycheck)

(use-package dockerfile-mode)

(use-package json-mode)

(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))
