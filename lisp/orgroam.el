(map!
 "\C-c n f" 'org-roam-node-find
 "s-k" 'org-roam-node-find
 "s-l" 'org-roam-buffer-toggle
 "\C-c n i" 'org-roam-node-insert
 "\C-c n t" 'org-roam-dailies-goto-today
 "\C-c n ["    ' org-roam-dailies-goto-previous-note
 "\C-c n ]"    ' org-roam-dailies-goto-next-note
 "\C-c n j" 'org-roam-dailies-capture-today
 "\C-c n c" 'org-roam-capture
 "\C-c n s" 'jab/search-roam
 "\C-c n l" 'org-roam-buffer-toggle)

(after! org-roam
  (org-link-set-parameters "id"
                         :face '(:foreground "orange" :underline t)))

(setq org-roam-directory "~/org/kb")

(setq org-roam-capture-templates
  '(("d"                                              ;; Key
     "default"                                        ;; Description
     plain                                            ;; Type
     (file "~/org/templates/DefaultRoamTemplate.org") ;; Template
    :target (file "kb/%<%Y%m%d%H%M%S>-${slug}.org")   ;; Target
    :unnarrowed t)
    ("P"                                              ;; Key
     "Public (published in /public)"                  ;; Description
     plain                                            ;; Type
     (file "~/org/templates/PublicTemplate.org")      ;; Template
    :target (file "kb/public/${slug}.org")               ;; Target
    :unnarrowed t)
    ("c"                                         ;; Key
     "Contact (Person)"                          ;; Description
     plain                                       ;; Type
     (file "~/org/templates/PersonTemplate.org") ;; Template
     :target (file "kb/contacts/${slug}.org")        ;; Target
     :unnarrowed t)
    ("m"                                              ;; Key
     "Movie"                                          ;; Description
     plain                                            ;; Type
     (file "~/org/templates/MovieTemplate.org")       ;; Template
    :target (file "kb/public/${slug}.org")               ;; Target
    :unnarrowed t)
    ("p"                                              ;; Key
     "project"                                        ;; Description
     plain                                            ;; Type
     (file "~/org/templates/ProjectTemplate.org")     ;; Template
    :target (file "projects/%<%Y%m%d>-${slug}.org")   ;; Target
    :unnarrowed t)))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))



;; (setq org-roam-dailies-capture-templates
;;       '(("d" "default" entry "* %?\n%U" :target
;;          (file+head "%<%Y-%m>.org" "#+title: Lab Notebook %<%Y-%m>\n"))))


(defun jab/search-roam ()
 "Run consult-ripgrep on the org roam directory"
 (interactive)
(consult-ripgrep org-roam-directory nil))


;; Publishing
(defun roam-sitemap (title list)
  (concat "#+OPTIONS: ^:nil author:nil html-postamble:t\n"
          "#+TITLE: " title "\n\n"
          (org-list-to-org list)))




;; Handle org-roam links when exported for Hugo
;; https://github.com/jeremyf/dotemacs/blob/main/emacs.d/takeonrules.org#extending-the-ox

(defun jf/org-tor-link (fn link desc &rest rest)
   "Conditional LINK and DESC rendering for ID-based links.

   Otherwise `apply' the FN with the REST of the parameters."
   (if (string= "id" (org-element-property :type link))
     (jf/org-md-link-by-id link desc)
     (apply fn link desc rest)))

 (advice-add #'org-md-link :around #'jf/org-tor-link '((name . "wrapper")))
 (advice-add #'org-hugo-link :around #'jf/org-tor-link '((name . "wrapper")))


 (defun jf/org-md-link-by-id (link desc)
     "With an \"id\" type LINK render the markdown.

   If the node for the given \"id\" has a ROAM_REF, use that as a markdown URL.
   Otherwise render a span with DESC.

   This prevents links to non-world accessible files."
     (let* ((filepath (org-id-find-id-file (org-element-property :path link)))
            (url (jf/org-file-get-roam-refs filepath)))
        (if url (format "[%s](%s)" desc url)
          (format "<span class=\"ref\">%s</span>" desc))))


(cl-defun jf/org-file-get-roam-refs (filepath)
  "Return first ROAM_REFS property in the FILEPATH."
  (with-current-buffer (find-file-noselect filepath)
    (car (org-property-values "ROAM_REFS"))))

;; Load after denote
(after! org-roam
(setq consult-notes-sources
       `(("Roam"      ?r ,org-roam-directory))))
