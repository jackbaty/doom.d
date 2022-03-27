(map!
 "\C-c n f" 'org-roam-node-find
 "s-u" 'org-roam-node-find
 "\C-c n i" 'org-roam-node-insert
 "\C-c n t" 'org-roam-dailies-goto-today
 "\C-c n d" 'org-roam-dailies-capture-today
 "\C-c n c" 'org-roam-capture
 "\C-c n l" 'org-roam-buffer-toggle)

(after! org-roam
  (org-link-set-parameters "id"
                         :face '(:foreground "orange" :underline t)))

(setq org-roam-directory "~/org/roam")

(setq org-roam-capture-templates
  '(("d" "default" plain "%?"
    :target (file+head "%<%Y%m%d>-${slug}.org"
                       "#+title: ${title}\n#+index: \n#+setupfile: ~/org/_SETUP/EXPORT\n#+setupfile: ~/org/_SETUP/org-roam-publish-fancy.setup")
    :unnarrowed t)
    ("P"                                               ;; Key
     "Public (published in /public)"                   ;; Description
     plain                                             ;; Type
     (file "~/org/roam/templates/PublicTemplate.org")  ;; Template
    :target (file "public/${slug}.org")                ;; Target
    :unnarrowed t)
    ("p"                                               ;; Key
     "project"                                         ;; Description
     plain                                             ;; Type
     (file "~/org/roam/templates/ProjectTemplate.org") ;; Template
    :target (file "projects/%<%Y%m%d>-${slug}.org")    ;; Target
    :unnarrowed t)))



(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+datetree "journal.org" day))))

;; Publishing
(defun roam-sitemap (title list)
  (concat "#+OPTIONS: ^:nil author:nil html-postamble:t\n"
          "#+TITLE: " title "\n\n"
          (org-list-to-org list)))


