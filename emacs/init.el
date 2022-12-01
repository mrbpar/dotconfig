;;; init.el --- Emacs initialization file

;;; Commentary:
;; 

;;; Code:
;;
(provide 'init)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;; backup files
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(eval-when-compile
  (require 'package))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t
      use-package-expand-minimally t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package org-mode
  :ensure nil
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)))

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :hook
  (python-mode . lsp-deferred)
  (terraform-mode . lsp))

(use-package lsp-ui
  :defer t
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-delay 2)
  :hook (lsp-mode . lsp-ui-mode)
  :bind (:map lsp-ui-mode-map
              ("C-c i" . lsp-ui-imenu)))

(use-package treemacs
  :defer t
  :config
  (setq treemacs-no-png-images t)
  (setq treemacs-width 25)
  :bind ("C-c t" . treemacs))

(use-package flycheck
  :init
  (global-flycheck-mode))

(use-package yasnippet
  :config
  (yas-global-mode))
(use-package yasnippet-snippets)

(use-package company
  :init
  (global-company-mode))

(use-package terraform-mode)

(use-package yaml-mode)

(use-package magit)

(use-package linum-mode
  :ensure nil
  :hook (prog-mode)
  :config
  (linum-format "%4d \u2502 "))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(auto-package-update use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
