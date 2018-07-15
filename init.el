;;; Package --- summary
;;; Code:
;;; Commentary:
;;; package-- - Summary  Automically add elpa packages

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.

;; Allow Packages from ELPA and MELPA

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa". "http://melpa.org/packages/")))
;; You may delete these explanatory comments.
(package-initialize)

(require 'use-package)

;; Evil Mode Settings
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
;; Move config
  )

(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t))


;; Allow key pauses.Dependancy for key - chord
(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))
                                        ; ; let jj exit insert                      ; disable auto-save and auto-backup
(use-package magit
  :ensure t) 

(use-package evil-magit
  :ensure t)

(setq auto-save-default nil)
(setq make-backup-files nil)

;; Enable Basic Syntax Highlighting

(global-font-lock-mode 1)

;; Yasnnipet
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet))

;; Line Numbers
(global-linum-mode t)

;; Stock stae variables
(which-function-mode 1)

;; Emacs frame size
(setq initial-frame-alist
      '(
        (width. 160) ; character
        (height. 47); lines
        ))

(use-package linum-relative
  :ensure t
  :config
  (linum-relative-mode 1))

;; Emacs required for hlem
(use-package helm
  :ensure t
  :config
  (helm-mode 1))

;; Kotlin Mode
(use-package kotlin-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.kt\\'".kotlin-mode)))

(show-paren-mode 1)

;; Highlight piars of parenthesis
(electric-pair-mode 1)

;; Emacs uses tabs by default sets it to spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Disable Emacs start up screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; IDO improved searching for files
(use-package ido
  :ensure t
  :config
  (ido-mode t))

;; Emacs make space meta - x
;; (define - key evil - normal - state - map(kbd "SPC") 'evil-ex)

;; Set Shortcut to compile with makefile
(global-set-key(kbd "M-m")'compile)

;; Disable Bell Noise
(setq visible-bell 1)

;; Hiding GUI Menus
(menu-bar-mode 0)
(toggle-scroll-bar 0)
(tool-bar-mode 0)

;; CC mode for C, C++ and Java
(setq-default c-basic-offset 2)
;; Set CC mode brace style
(setq c-default-style "bsd")
(setq c-basic-offset 4)
(setq electric-layout-rules '((?\{ . around) (?\} . around)))


;; Color them
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;; Setting Up Org mode
(use-package org
  :ensure t
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-to-list 'auto-mode-alist '("\\.txt\\'".org-mode)))
;; Mode for writing documentation

;; Emacs set font
(set-frame-font "DejaVu Sans Mono Book 14")

(use-package flycheck
  :ensure t
  :config
;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web - mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; -* - mode: elisp -* -

;; Disable the splash screen(to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

    ;;;; Org mode configuration
;; Enable Org mode
;;(require 'org)
;; Make Org mode work with files ending in .org
;; (add - to - list 'auto-mode-alist '("\\.org$".org - mode))
;; The above is the default in recent emacsen

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck"))

;; Company - mode
(use-package company
  :ensure t
  :config
  (company-mode 1))

;; Give mode the ability to clear the buffer correctly with Ctrl - l
(defun eshell-clear-buffer()
  "Clear terminal"
  (interactiv)
  (let((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
          '(lambda()
             (local-set-key(kbd "C-l") 'eshell-clear-buffer)))

(use-package company-tern
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern))

(use-package js2-mode
  :ensure t
  :config
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override nil)
  (add-hook 'js2-mode-hook#'js2-imenu-extras-mode)
  (add-hook 'js2-mode-hook (lambda ()
                             (tern-mode)
                             (company-mode)))
  (add-to-list 'auto-mode-alist '("\\.js\\'".js2 - mode)))

;; Keybindings
;; TODO Group keybindings
(global-set-key (kbd "C-x C-\\") 'next-line)

;; Tide setup
(defun setup-tide-mode()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency.You have to
  ;; install it separately via package - install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-frmat-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (yasnippet tide web-mode kotlin-mode linum-relative key-chord indium  flycheck evil company-tern))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(find-file "~/.emacs.d/init.el")

