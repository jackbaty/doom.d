
(map!
 "\C-cl" 'org-store-link
 "\C-cc" 'org-capture
 "\C-cj" 'org-journal-new-entry)

(map!
 "\C-c n f" 'org-roam-node-find
 "\C-c n n" 'org-roam-node-insert
 "\C-c n d" 'org-roam-dailies-find-today
 "\C-c n r" 'org-roam-buffer-toggle)
