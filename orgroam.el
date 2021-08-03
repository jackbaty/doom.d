
;; (use-package! org-roam
;;   :after org
;;   :commands
;;   (org-roam-buffer
;;    org-roam-setup
;;    org-roam-capture
;;    org-roam-node-find)
;;   :init
;;   (setq org-roam-v2-ack t)
;;   :config
;;   (setq org-roam-directory "~/org/roam")
;;   (org-roam-setup))

(map!
 "\C-c n f" 'org-roam-node-find
 "s-u" 'org-roam-node-find
 "\C-c n i" 'org-roam-node-insert
 "\C-c n d" 'org-roam-dailies-goto-today
 "\C-c n c" 'org-roam-dailies-capture-today
 "\C-c n l" 'org-roam-buffer-toggle)


;; ;; Use a window on the right
;; (add-to-list 'display-buffer-alist
;;              '("\\*org-roam\\*"
;;                (display-buffer-in-direction)
;;                (direction . right)
;;                (window-width . 0.33)
;;                (window-height . fit-window-to-buffer)))

(setq org-roam-directory "~/org/roam")


;; (setq org-roam-dailies-capture-templates
;;   '(("d" "default" entry "* %?" :if-new
;;     (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d> - Daily Notes\n"))))
