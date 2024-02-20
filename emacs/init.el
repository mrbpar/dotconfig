;;; init.el --- Emacs initialization file

;;; Commentary:
;; 

;;; Code:
;;
(provide 'init)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(when (display-graphic-p)
  (add-to-list 'default-frame-alist '(width . 130))
  (add-to-list 'default-frame-alist '(height . 60)))

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
  :custom
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  (auto-package-update-maybe))

(when (display-graphic-p)
  (use-package solarized-theme
    :config (load-theme 'solarized-dark t))
  (use-package gruvbox-theme))

(use-package display-line-numbers
 :ensure nil
 :hook (prog-mode))

(use-package eglot
  :ensure nil ; use built-in eglot package for now
  :config (add-to-list 'eglot-server-programs '(terraform-mode . ("terraform-ls" "serve")))
  :hook ((terraform-mode . eglot-ensure)
         (python-mode . eglot-ensure)))

(use-package eglot-java
  :hook (java-mode)
  :bind (:map eglot-java-mode-map
         ("C-c l n" . eglot-java-file-new)))

(use-package treemacs
  :custom ((treemacs-no-png-images t)
	   (treemacs-width 25))
  :bind ("C-c t" . treemacs))

(use-package flycheck
  :hook (prog-mode)
  :config (global-flycheck-mode))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))
(use-package yasnippet-snippets)

(use-package company
  :init
  (global-company-mode))

(use-package helm
  :bind (("C-x C-f" . helm-find-files)
	     ("M-x" . helm-M-x)
	     ("C-x b" . helm-mini))
  :config (helm-mode 1)
  :custom ((helm-M-x-fuzzy-match t)
	       (helm-buffers-fuzzy-matching t)
	       (helm-recentf-fuzzy-match t)))

(use-package terraform-mode
  :custom (terraform-format-on-save t))

(use-package yaml-mode)

(use-package magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" default))
 '(package-selected-packages
   '(gruvbox-theme helm solarized-theme auto-package-update use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
