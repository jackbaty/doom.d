
(use-package! org-roam
  :after org
  :commands
  (org-roam-buffer
   org-roam-setup
   org-roam-capture
   org-roam-node-find)
  :config
  (setq org-roam-directory "~/org/roam")
  (org-roam-setup))



(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %?" :if-new
         (file+head "%(concat org-roam-dailies-directory \"/%<%Y-%m-%d>.org\")"
                    "#+title: Daily Notes - %<%A, %B %e %Y>\n#+date:  %<%Y-%m-%d>"))))
