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
   '(gcmh dashboard markdown-mode lua-mode python-mode vterm toc-org helm-rdefs org-bullets good-scroll beacon beacon-mode general evil-tutor evil-collection evil counsel doom-modeline doom-themes which-key all-the-icons rainbow-delimiters ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
