;; Pakethantering
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Startfönster
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

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
(global-set-key (kbd "<M-left>") 'previous-buffer)
(global-set-key (kbd "<M-right>") 'next-buffer)

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
   (quote
    (markdown-toc yaml-mode markdown-mode dockerfile-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Installera valda paket
(package-install-selected-packages)
