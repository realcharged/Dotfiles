;; Charged's GNU Emacs Configuration

;; ###############################################
;; #      /  /       CHARGED1                    #
;; #   /        /    --------                    #
;; #  /          /   gitlab.com/charged1         #
;; #  /          /   matrix.to/#/@XBow:envs.net  #
;; #   /        /    --------                    #
;; #      /  /       Please read before you use. #
;; ###############################################

(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

;; Extras
;; (use-package beacon)
;; (beacon-mode 1)

;; ;; Smooth scrolling
;; (use-package good-scroll)
;; (good-scroll-mode 1)

;; ;; Remove startup message
;; (setq inhibit-startup-message t)

;; ;; Remove menus
;; (scroll-bar-mode -1)
;; (tool-bar-mode -1)
;; (tooltip-mode -1)
;; (set-fringe-mode 10)

;; (menu-bar-mode -1)

;; ;; Blinking cursor
;; (blink-cursor-mode 0)

;; ;; Font
;; (set-face-attribute 'default nil :font "JetBrains Mono" :height 180)
;; (set-face-attribute 'variable-pitch nil :font "Ubuntu Bold" :height 180 :weight 'regular)

;; ;; Initialize package sources
;; (require 'package)

;; ;; MELPA
;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
;;                          ("org" . "https://orgmode.org/elpa/")
;;                          ("elpa" . "https://elpa.gnu.org/packages/")))

;; (package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))

;; ;; Initialize use-package on non-Linux platforms
;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))

;; ;; use-package
;; (require 'use-package)
;; (setq use-package-always-ensure t)

;; ;; Custom
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
;;  '(package-selected-packages
;;    '(helm-rdefs org-bullets good-scroll beacon beacon-mode general evil-tutor evil-collection evil counsel doom-modeline doom-themes which-key all-the-icons rainbow-delimiters ivy use-package)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;; ;; Ivy
;; (use-package ivy
;;   :diminish
;;   :config
;;   (ivy-mode 1))

;; ;; Icon pack
;; (use-package all-the-icons)

;; ;; Nice modeline
;; (use-package doom-modeline)
;; (doom-modeline-mode 1)
;; ;;  :custom ((doom-modeline-height 30)))

;; ;; Line numbers
;; (column-number-mode)
;; (global-display-line-numbers-mode t)

;; ;; Show bracket colours
;; (use-package rainbow-delimiters
;;   :hook (prog-mode . rainbow-delimiters-mode))

;; ;; Which-key
;; (use-package which-key
;;   :defer 0
;;   :diminish which-key-mode
;;   :config
;;   (which-key-mode)
;;   (setq which-key-idle-delay 1))

;; ;; Theme package
;; (use-package doom-themes)

;; ;; Load theme, "t" to stop asking
;; (load-theme 'doom-one t)

;; ;; Counsel
;; (use-package counsel)
;; (counsel-mode 1)

;; ;; Vim-like keybinds
;; (use-package evil
;;   :init      ;; tweak evil's configuration before loading it
;;   (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;;   (setq evil-want-keybinding nil)
;;   (setq evil-vsplit-window-right t)
;;   (setq evil-split-window-below t)
;;   (evil-mode))
;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (setq evil-collection-mode-list '(dashboard dired ibuffer))
;;   (evil-collection-init))
;; (use-package evil-tutor)

;; (global-set-key (kbd "C-=") 'text-scale-increase)
;; (global-set-key (kbd "C--") 'text-scale-decrease)
;; (global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
;; (global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; ;; Keybinds
;; (use-package general
;;   :config
;;   (general-evil-setup t))
;; (nvmap :keymaps 'override :prefix "SPC"
;;        "SPC"   '(counsel-M-x :which-key "M-x")
;;        "c c"   '(compile :which-key "Compile")
;;        "c C"   '(recompile :which-key "Recompile")
;;        "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
;;        "h t"   '(load-theme :which-key "Load theme")
;;        "t t"   '(toggle-truncate-lines :which-key "Toggle truncate lines")
;;        "b k"   '(kill-current-buffer :which-key "Kill the current buffer.")
;;        "b i"   '(ibuffer :which-key "Open iBuffer")
;;        "."     '(find-file :which-key "Find file"))
;; (nvmap :keymaps 'override :prefix "SPC"
;;        "m *"   '(org-ctrl-c-star :which-key "Org-ctrl-c-star")
;;        "m +"   '(org-ctrl-c-minus :which-key "Org-ctrl-c-minus")
;;        "m ."   '(counsel-org-goto :which-key "Counsel org goto")
;;        "m e"   '(org-export-dispatch :which-key "Org export dispatch")
;;        "m f"   '(org-footnote-new :which-key "Org footnote new")
;;        "m h"   '(org-toggle-heading :which-key "Org toggle heading")
;;        "m i"   '(org-toggle-item :which-key "Org toggle item")
;;        "m n"   '(org-store-link :which-key "Org store link")
;;        "m o"   '(org-set-property :which-key "Org set property")
;;        "m t"   '(org-todo :which-key "Org todo")
;;        "m I"   '(org-toggle-inline-images :which-key "Org toggle inline imager")
;;        "m T"   '(org-todo-list :which-key "Org todo list")
;;        "o a"   '(org-agenda :which-key "Org agenda"))


;; ;; Org bullets
;; (use-package org-bullets
;;   :hook (org-mode . org-bullets-mode)
;;   :custom
;;   (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; (custom-set-faces
;;   '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
;;   '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
;;   '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
;;   '(org-level-4 ((t (:inherit outline-4 :height 1.25))))
;;   '(org-level-5 ((t (:inherit outline-5 :height 1.2))))
;; )

;; (org-indent-mode 1)
;; (setq org-src-preserve-indentation t)

;; ;; Ensure that anything that should be fixed-pitch in Org files appears that way
;; (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
;; (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
;; (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
;; (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
;; (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)

;; ;; Close stuff
;; (electric-pair-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(package-selected-packages
   '(gcmh dashboard markdown-mode lua-mode python-mode vterm toc-org helm-rdefs org-bullets good-scroll beacon beacon-mode general evil-tutor evil-collection evil counsel doom-modeline doom-themes which-key all-the-icons rainbow-delimiters ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 3.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 2.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 0.5))))
 '(org-level-5 ((t (:inherit outline-5 :height 0.1)))))
