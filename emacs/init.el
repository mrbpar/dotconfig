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

(use-package display-line-numbers
  :ensure nil
  :custom ((display-line-numbers t)))

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
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package treemacs
  :defer t
  :custom
  (treemacs-no-png-images t)
  (treemacs-width 25)
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

(use-package terraform-mode
  :hook (terraform-format-on-save-mode))

(use-package yaml-mode)

(use-package magit)

(use-package eglot-java
  :hook (java-mode)
  :bind (:map eglot-java-mode-map
         ("C-c l n" . eglot-java-file-new)))

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
