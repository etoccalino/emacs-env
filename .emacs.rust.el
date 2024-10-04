;; Rust config. Supposed to be used with ~/.emacs.d.rust directory as home.
;;
;; First time use:
;; * Install the "all-the-icons" set for neo-tree: `M-x all-the-icons-install-fonts` and then run `fc-cache -f -v` in the system.

;; Load the common configs
(load "~/.emacs.base.el")

;; Original guide in https://robert.kra.hn/posts/2021-02-07_rust-with-emacs/
;;
;; Configs modified from https://github.com/rksm/emacs-rust-config/blob/master/init.el

;; -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;; rustic = basic rust-mode + additions
(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c C-n" . flycheck-next-error)
              ("C-c C-c C-p" . flycheck-previous-error)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status)
              ("C-c C-c e" . lsp-rust-analyzer-expand-macro)
              ("C-c C-c h" . lsp-ui-doc-glance))
  :custom
  (rustic-format-on-save t))

(use-package lsp-mode
  :hook lsp-ui-mode
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse nil)
  ;; See: https://emacs-lsp.github.io/lsp-mode/page/performance/
  (read-process-output-max 8192)
  (gc-cons-threshold 100000000))

(use-package lsp-ui
  :defer t
  :custom
  (lsp-ui-sideline-show-hover nil))

(use-package lsp-treemacs)

(use-package neotree
  :bind ([f8] . neotree-toggle))

(use-package all-the-icons
  :if (display-graphic-p)
  :custom (neo-theme 'icons))

(use-package flycheck)

(use-package toml-mode)

(use-package company
  :bind
  (:map company-active-map
              ("C-n". company-select-next)
              ("C-p". company-select-previous)
              ("M-<". company-select-first)
              ("M->". company-select-last)))
