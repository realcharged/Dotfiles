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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" default))
 '(package-selected-packages
   '(company netease-cloud-music transient quelpa-use-package ement visual-fill-column gcmh dashboard markdown-mode lua-mode python-mode vterm toc-org helm-rdefs org-bullets good-scroll beacon beacon-mode general evil-tutor evil-collection evil counsel doom-modeline doom-themes which-key all-the-icons rainbow-delimiters ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:family "Ubuntu Mono" :height 0.95))))
 '(mode-line-inactive ((t (:family "Ubuntu Mono" :height 0.9))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.25))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.2)))))
