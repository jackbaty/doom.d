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
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
   ("l" "log entry" entry
      "* %u %?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
   ("p" "person" plain
      (file "~/org/roam/templates/PersonTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Person")
      :unnarrowed t)
   ("P" "project" plain
      (file "~/org/roam/templates/ProjectTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
      :unnarrowed t)))

;; (setq org-roam-dailies-capture-templates
;;   '(("d" "default" entry "* %?" :if-new
;;     (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d> - Lab Notebook\n"))))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+datetree "journal.org" day))))

(defun roam-sitemap (title list)
  (concat "#+OPTIONS: ^:nil author:nil html-postamble:nil\n"
          "#+SETUPFILE: ./simple_inline.theme\n"
          "#+TITLE: " title "\n\n"
          (org-list-to-org list) "\nfile:sitemap.svg"))

;; Publishing

(setq my-publish-time 0)   ; see the next section for context
(defun roam-publication-wrapper (plist filename pubdir)
  (org-roam-graph)
  (org-html-publish-to-html plist filename pubdir)
  (setq my-publish-time (cadr (current-time))))

(setq org-publish-project-alist
  '(("roam"
     :base-directory "~/org/roam/public"
     :auto-sitemap t
     :sitemap-function roam-sitemap
     :sitemap-title "Roam notes"
     :publishing-function roam-publication-wrapper
     :publishing-directory "~/roam-export"
     :section-number nil
     :table-of-contents nil
     :style "<link rel=\"stylesheet\" href=\"../other/mystyle.cs\" type=\"text/css\">")))
