;; JS+React config. Supposed to be used with ~/.emacs.d.react directory as home.
;;

;; Load the common configs
(load "~/.emacs.base.el")

;; Original guide in https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/

;; (setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode json-mode))
;; (when (cl-find-if-not #'package-installed-p package-selected-packages)
;;   (package-refresh-contents)
;;   (mapc #'package-install package-selected-packages))

(use-package lsp-mode
  :ensure
  :hook ((js-mode js-jsx-mode js-ts-mode js-json-mode js-base-mode) . lsp)
  :bind (:map lsp-mode-map
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c C-n" . flycheck-next-error)
              ("C-c C-c C-p" . flycheck-previous-error))
  :config
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
(use-package lsp-treemacs :ensure)
(use-package helm :ensure)
(use-package helm-lsp :ensure)
(use-package helm-xref :ensure)
(use-package projectile :ensure)
(use-package hydra :ensure)
(use-package company
  :ensure
  :bind
  (
    ([remap find-file] . #'helm-find-files)
    ([remap execute-extended-command] . #'helm-M-x)
    ([switch-to-buffer] . #'helm-mini))
  :custom
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1))
(use-package flycheck :ensure)
(use-package avy :ensure)
(use-package dap-mode :ensure)
(use-package json-mode :ensure)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      create-lockfiles nil) ;; lock files will kill `npm start'

;; (with-eval-after-load 'js
;;   (define-key js-mode-map (kbd "M-.") nil))
