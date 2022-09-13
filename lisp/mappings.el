
(map!
 "\C-cl" 'org-store-link
 "\C-cc" 'org-capture
 "\C-cj" 'org-journal-new-entry)


(map!
 "\C-c w m" 'copy-as-format-markdown)

(map!
 "s-t" 'tab-new)


(map! :leader :desc "Open Elfeed" :n "o r" #'=rss)

(map! :map dired-mode-map "\C-c \C-n" #'dired-narrow)
(map! :map dired-mode-map "\C-c +" #'dired-create-empty-file)
