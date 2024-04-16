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

(use-package emacs
  :init
  (setq tab-always-indent 'complete))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode))

(use-package org
  :ensure nil
  :custom
  (org-latex-packages-alist '(("" "booktabs")("" "array")("" "minted")))
  (org-latex-listings 'minted)
  (org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                           "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

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

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :init
  (global-corfu-mode))

(use-package vertico
  :init (vertico-mode))

(use-package savehist
  :init (savehist-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package which-key
  :custom (which-key-mode t))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-latex-src-block-backend 'minted nil nil "Customized with use-package org")
 '(package-selected-packages
   '(vertico orderless corfu which-key yasnippet-snippets treemacs terraform-mode solarized-theme poly-ansible markdown-mode magit helm gruvbox-theme flycheck eglot-java company auto-package-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
