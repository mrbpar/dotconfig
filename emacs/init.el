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
  (use-package solarized-theme)
  (use-package gruvbox-theme
    :config (load-theme 'gruvbox t)))

(use-package display-line-numbers
 :ensure nil
 :hook (prog-mode))

(use-package eglot
  :ensure nil ; use built-in eglot package for now
  :hook ((terraform-mode . eglot-ensure)
         (python-mode . eglot-ensure)
         (ansible-mode . eglot-ensure))
  :config (add-to-list 'eglot-server-programs
                       '((terraform-mode . ("terraform-ls" "serve"))
                         (ansible-mode . ("ansible-language-server" "--stdio")))))

(use-package eglot-java
  :hook (java-mode)
  :bind (:map eglot-java-mode-map
         ("C-c l n" . eglot-java-file-new)))

(use-package treemacs
  :custom ((treemacs-no-png-images t)
	   (treemacs-width 25))
  :bind ("C-c t" . treemacs))

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

(use-package polymode)

(use-package ansible)

(use-package jinja2-mode)

(use-package poly-ansible)

(use-package markdown-mode)

(use-package magit)

;;; init.el ends here
