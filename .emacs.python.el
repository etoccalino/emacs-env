;; Python config. Supposed to be used with ~/.emacs.d.python directory as home.
;;
;; First time use:
;; * Install the "all-the-icons" set for neo-tree: `M-x all-the-icons-install-fonts` and then run `fc-cache -f -v` in the system.

;; Load the common configs
(load "~/.emacs.base.el")

(use-package lsp-mode
  :hook (python-mode . lsp)
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
  :custom
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse nil)
  ;; See: https://emacs-lsp.github.io/lsp-mode/page/performance/
  (read-process-output-max 8192)
  (gc-cons-threshold 100000000))

(use-package lsp-ui
  :defer t
  :custom
  (lsp-ui-sideline-show-hover nil))

(use-package treemacs
  :defer
  :bind ([f8] . treemacs))

(use-package lsp-treemacs
  :after lsp)

(use-package flycheck)

(use-package dockerfile-mode)
