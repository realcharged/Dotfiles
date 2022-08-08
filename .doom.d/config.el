(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-one)

(beacon-mode 1)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(setq user-full-name "Charged"
      user-mail-address "someonesomething800@gmail.com")

(setq display-line-numbers-type t)

(setq minimap-window-location 'right)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

(set-face-attribute 'mode-line nil :font "Ubuntu Mono-13")
(setq doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

(xterm-mouse-mode 1)

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree" "d n" #'neotree-dir)

(setq org-publish-use-timestamps-flag nil)
(setq org-export-with-broken-links t)
(setq org-publish-project-alist
      '(("website"
         :base-directory "~/GL-repos/website/"
         :base-extension "org"
         :publishing-directory "~/GL-repos/website/html/"
         :recursive t
         :exclude "org-html-themes/.*"
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t)
         ("org-static"
         :base-directory "~/Org/website"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/"
         :recursive t
         :exclude ".*/org-html-themes/.*"
         :publishing-function org-publish-attachment)
         ))

(require 'org-auto-tangle)
(add-hook 'org-mode-hook 'org-auto-tangle-mode)

(setq org-directory "~/org/")

(custom-set-faces!
  '(org-table   :foregorund "#vfafdf" :height 1.0 :weight normal)
  '(org-level-1 :height 1.5 :weight ultra-bold)
  '(org-level-2 :height 1.4 :weight extra-bold)
  '(org-level-3 :height 1.3 :weight bold)
  '(org-level-4 :height 1.25 :weight semi-bold)
  '(org-level-5 :height 1.2 :weight normal)
  '(org-level-6 :height 1.15 :weight normal)
  '(org-level-7 :height 1.1 :weight normal)
  '(org-level-8 :height 1.05 :weight normal))

(add-hook 'org-mode-hook #'mixed-pitch-mode)

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )
