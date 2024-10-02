;; Main config. Uses ~/.emacs.d (default dir) as home.
;;

;; Load the common configs
(load "~/.emacs.base.el")

(use-package yaml-mode)

(use-package auto-complete
  :config
  (ac-config-default)
  ;; set auto-complet-mode for every buffer but the minibuffer
  (defun auto-complete-mode-maybe ()
    (unless (minibufferp (current-buffer))
      (auto-complete-mode 1))))

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

(use-package org-superstar
  :config (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package dockerfile-mode)
