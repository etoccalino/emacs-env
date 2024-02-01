(use-package lsp-mode
  :ensure
  :hook (python-mode . lsp)
  :bind (:map lsp-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c C-n" . flycheck-next-error)
              ("C-c C-c C-p" . flycheck-previous-error)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c h" . lsp-ui-doc-glance))
  :config (lsp-headerline-breadcrumb-mode)
    (setq read-process-output-max 8192)
    (setq lsp-eldoc-enable-hover nil))

(use-package lsp-ui
  :ensure
  :defer t)
