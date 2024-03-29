;; Pakethantering
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Lokala paket
(let ((default-directory (concat user-emacs-directory "local/")))
  (normal-top-level-add-subdirs-to-load-path))

;; Alla fönster
(add-to-list 'default-frame-alist '(font . "Monospace-9"))

;; Visa inte toolbar
(tool-bar-mode 0)

;; Highlight line
(global-hl-line-mode t)

;; Inga ~-filer
(setq make-backup-files nil)

;; Visa matchande parentes
(show-paren-mode t)

;; Visa aktuell kolumn
(column-number-mode t)

;; Idiotändring i Emacs 21.x
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

;; Håll käft och låt mig jobba
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)

;; Windmove (flytta med S-piltangent)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(setq windmove-wrap-around t)

;; Visa buffer-menu isf list-buffers
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; M-<left>/<right> för previous-/next-buffer
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)

;; Dired-x
(load "dired-x")
(setq dired-listing-switches "-alh")
;; Dölj filer per default
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))
;; Växla med "h"
(define-key dired-mode-map "h" 'dired-omit-mode)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

;; Utskrifter
(setq ps-print-header nil)
(setq ps-paper-type 'a4)

;; Ta bort mallen med "Summary:" ur loggmeddelandet (för versionshantering)
(eval-after-load 'log-edit
  '(remove-hook 'log-edit-hook 'log-edit-insert-message-template))

;; Custom-grejer
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(indent-guide jinja2-mode ini-mode php-mode apache-mode markdown-toc yaml-mode markdown-mode dockerfile-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Installera valda paket
(package-install-selected-packages)

;; Tramp med Openshift/OKD
;; FIXA: Autocompletion (med projekt?)
(require 'tramp)
(add-to-list 'tramp-methods '("oc"
			      (tramp-login-program "oc")
			      (tramp-login-args
			       (("rsh")
				("%h")))
			      (tramp-remote-shell "/bin/sh")
			      (tramp-remote-shell-args
			       (("-i")
				("-c")))
			      ))

;; Markdown
(setq markdown-command "toolbox run pandoc -t html4 -V lang=sv")
(setq markdown-command-needs-filename t)

;; YAML
(add-hook 'yaml-mode-hook (lambda () (indent-guide-mode)))

;; Plantuml
(require 'plantuml-mode)
(setq plantuml-server-url "http://localhost:6742")

;; Window Resize
(global-set-key (kbd "M-S-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
(global-set-key (kbd "M-S-<up>") 'enlarge-window)
