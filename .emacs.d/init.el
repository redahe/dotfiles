;MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;Evil mode config
(setq evil-want-C-i-jump nil)
(setq evil-want-integration nil)
(require 'evil)
(evil-mode 1)
(add-to-list 'load-path "/home/reda/.emacs.d/evil-collection/")
(require 'evil-collection)
(evil-collection-init)


;Common settings
(setq make-backup-files nil)
(setq auto-save-default nil)
(menu-bar-mode -1) 
;;; Fix junk characters in shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq explicit-shell-file-name "/bin/bash")

;Org mode
(require 'org-evil)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t))
)
;Org-bullets works only in GUI
(if (display-graphic-p) 
  (progn (require 'org-bullets)
         (add-hook 'org-mode-hook
		   (lambda () (org-bullets-mode 1)))
))

;Theme
(if (display-graphic-p) 
(progn   (load-theme 'cobalt t t)
    (enable-theme 'cobalt) 
    (set-default-font "Monospace 14")
    (tool-bar-mode -1)
)
(progn
    (load-theme 'hober t t)
    (enable-theme 'hober)
;Transparency in terminal
    (set-face-background 'default "unspecified-bg")
  )
)


;Custom settings
(custom-set-variables
 '(inhibit-startup-screen t))
(custom-set-faces
 '(org-table ((t (:foreground "cyan"))))
 )
