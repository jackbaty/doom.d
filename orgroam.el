
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
 "\C-c n c" 'org-roam-capture
 "\C-c n l" 'org-roam-buffer-toggle)

(after! org-roam
  (org-link-set-parameters "id"
                         :face '(:foreground "orange" :underline t)))

(setq org-roam-directory "~/org/roam")

(setq org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
   ("p" "person" plain
      (file "~/org/roam/templates/PersonTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Person")
      :unnarrowed t)))

(setq org-roam-dailies-capture-templates
  '(("d" "default" entry "* %?" :if-new
    (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d> - Daily Notes\n"))))
