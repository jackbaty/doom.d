
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
