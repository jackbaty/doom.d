
(setq
 org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))


(setq org-agenda-files (list
                   (concat org-directory "todo.org")
                   (concat org-directory "projects.org")
                   (concat org-directory "notes.org")
                   "~/baty.blog/content-org/posts.org"
                   (concat org-directory "events.org")
                   (concat org-directory "food.org")
                   (concat org-directory "doing.org")
                   (concat org-directory "daybook.org")))


(after! org
  (setq org-return-follows-link t)
   (setq org-agenda-include-diary t
       ;;org-agenda-start-on-weekday nil
       ;;org-agenda-span 'week
       org-agenda-log-mode-items (quote (closed))
       org-agenda-persistent-filter t
       org-agenda-skip-scheduled-if-deadline-is-shown (quote not-today)
       org-agenda-skip-deadline-prewarning-if-scheduled t
       org-agenda-skip-scheduled-if-done t
       org-agenda-skip-deadline-if-done t
       org-deadline-warning-days 7
       org-agenda-start-with-clockreport-mode nil
       org-agenda-clockreport-parameter-plist '(:link t :maxlevel 6 :fileskip0 t :compact t :narrow 80 :score 0)
       org-pretty-entities t
       org-tags-column 0
       org-log-done 'time
       org-log-into-drawer t
       org-log-redeadline 'note
      ;; org-habit-show-all-today t
       org-agenda-text-search-extra-files (quote (agenda-archives))
       org-agenda-window-setup (quote current-window))
  (setq org-attach-id-dir  "attach/")
  (setq org-attach-auto-tag nil)
  ;;(add-to-list 'org-tags-exclude-from-inheritance "project")
  ;;(add-to-list 'org-modules 'org-habit)
  (setq org-stuck-projects
      '("+project/-MAYBE-DONE" ("NEXT" "TODO")))

  (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "CANC(k)")
 (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
 (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))


  (setq org-capture-templates
        `(("t" "Todo to Inbox" entry
           (file+headline ,(concat org-directory "todo.org") "Inbox")
           "* TODO %?\n"
           :empty-lines 1)
          ("T" "Todo to Inbox with Clipboard" entry
           (file+headline ,(concat org-directory "todo.org") "Inbox")
           "* TODO %?\nSCHEDULED: %t\n%c\n\n%i\n"
           :empty-lines 1)
          ("l" "Current file log entry" entry
           (file+olp+datetree buffer-file-name)
           "* %? \n")
          ("D" "Daybook" entry
           (file+olp+datetree ,(concat org-directory "daybook.org"))
           "* %?\n%t\n" :time-prompt t)
          ("e" "Event" entry
           (file+olp+datetree ,(concat org-directory "events.org"))
           "* %?\n%T\n" :time-prompt t)
          ("F" "Food Log" entry
           (file+datetree+prompt "~/org/food.org")
            "* %?\n%t\n%^{category}p%^{Type}p")
          ("s" "Add to Spark File" entry
           (file+headline ,(concat org-directory "sparkfile.org") "2021")
           "* %?\n%U" :prepend t)
          ("d" "Doing now" entry
           (file+headline ,(concat org-directory "doing.org") "Currently")
           "* %U %?")
          ("n" "Add a Note" entry
           (file+headline ,(concat org-directory "notes.org") "Notes")
           "* %?\n%U" :prepend t))))
 ;; (load "org-devonthink")
 ;; (load "org-maillink")


(setq org-agenda-custom-commands
      '(("%" "Appointments" agenda* "Today's appointments"
         ((org-agenda-span 1)
          (org-agenda-max-entries 3)))))

  (setq org-download-method 'attach
    org-download-image-dir "attach/"
    org-download-image-org-width 600
    org-download-heading-lvl nil)

  (setq org-journal-dir "~/org/journal"
    org-journal-file-type 'monthly
    org-journal-file-format "%Y-%m.org"
    org-journal-find-file #'find-file
    org-journal-time-prefix ""
    org-journal-time-format ""
    org-journal-enable-agenda-integration nil
    org-journal-enable-encryption nil
    org-journal-date-format "%A, %B %d %Y")


;;(setq org-id-ts-format "%Y%m%d%H%M")
;;(setq org-id-method 'ts)

;; Load appointments
;;(org-agenda-to-appt)

(add-hook 'org-journal-mode-hook 'turn-on-auto-fill)
(add-hook 'org-journal-mode-hook #'+zen/toggle)

;; Category icons
;; Odd that regexp doesn't seem to work for (Breakfast|Lunch|Dinner)
;;
(setq org-agenda-category-icon-alist
        `(("Personal" ,(list (all-the-icons-material "home" :height 1.0)) nil nil :ascent center)
          ("Repeat" ,(list (all-the-icons-material "repeat" :height 1.0)) nil nil :ascent center)
          ("Events" ,(list (all-the-icons-material "event" :height 1.0)) nil nil :ascent center)
          ("Anniv" ,(list (all-the-icons-material "perm_contact_calendar" :height 1.0)) nil nil :ascent center)
          ("Birthday" ,(list (all-the-icons-material "cake" :height 1.0)) nil nil :ascent center)
          ("Breakfast" ,(list (all-the-icons-material "restaurant_menu" :height 1.0)) nil nil :ascent center)
          ("Lunch" ,(list (all-the-icons-material "restaurant_menu" :height 1.0)) nil nil :ascent center)
          ("Dinner" ,(list (all-the-icons-material "restaurant_menu" :height 1.0)) nil nil :ascent center)
          ("Email" ,(list (all-the-icons-material "mail_outline" :height 1.0)) nil nil :ascent center)
          ("Daybook" ,(list (all-the-icons-material "info_outline" :height 1.0)) nil nil :ascent center)
          ("Task" ,(list (all-the-icons-material "check_box_outline_blank" :height 1.0)) nil nil :ascent center)
          ("Unfiled" ,(list (all-the-icons-material "move_to_inbox" :height 1.0)) nil nil :ascent center)
          ("." '(space . (:width (16)))))
        )

(setq org-agenda-category-icon-alist nil)

;; Possible fix for ox-hugo hanging on save
(setq org-element-use-cache nil)
