
(setq org-attach-preferred-new-method 'dir)
(setq org-attach-id-dir  "img/")
(setq org-attach-dir-relative t)
;;   (setq org-attach-auto-tag nil)
(setq org-attach-store-link-p t)
(setq org-id-method 'ts)
;; for sane attachment paths/names
(setq org-attach-id-to-path-function-list
        '(org-attach-id-ts-folder-format
        org-attach-id-uuid-folder-format))

;; Org Download and Attachments
(setq org-download-image-dir  "img/")
(setq org-download-image-org-width 800)
(setq org-download-image-html-width 800)
(setq org-download-heading-lvl 0)
(setq org-download-timestamp "%Y%m%d-")
(setq org-download-method 'attach)

(setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))

(setq org-agenda-files (list
                   (concat org-directory "projects.org")
                   (concat org-directory "tasks.org")
                   (concat org-directory "inbox.org")
                   (concat org-directory "notes.org")
                   (concat org-directory "events.org")
                   (concat org-directory "food.org")
                   (concat org-directory "doing.org")
                   (concat org-directory "daybook.org")
                   (concat org-directory "roam/daily/")
                   (concat org-directory "roam/projects/")
                   "~/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents/voicenotes.org"))

(setq org-refile-targets '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")
                           ("tasks.org" :maxlevel . 1)))



(after! org
  (setq org-return-follows-link t)
   (setq org-agenda-include-diary t
       ;;org-agenda-start-on-weekday nil
       ;;org-agenda-span 'week
       org-agenda-log-mode-items (quote (closed))
       org-agenda-persistent-filter t
       org-agenda-skip-scheduled-if-deadline-is-shown (quote not-today)
       org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
       org-agenda-skip-scheduled-if-done t
       org-agenda-skip-deadline-if-done t
       org-agenda-todo-ignore-scheduled 'future
       org-deadline-warning-days 3
       org-agenda-start-with-clockreport-mode nil
       org-agenda-clockreport-parameter-plist '(:link t :maxlevel 6 :fileskip0 t :compact t :narrow 80 :score 0)
       org-pretty-entities t
       org-tags-column 0
       org-log-done 'time
       org-log-into-drawer t
       org-image-actual-width nil
       ;;org-startup-with-inline-images "inlineimages"
       org-log-redeadline 'note
      ;; org-habit-show-all-today t
       org-agenda-text-search-extra-files (quote (agenda-archives))
       org-agenda-window-setup (quote current-window))


  (add-to-list 'org-tags-exclude-from-inheritance "project")
  ;;(add-to-list 'org-modules 'org-habit)
  (setq org-stuck-projects
      '("+project/-MAYBE-DONE" ("NEXT" "TODO")))

 (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "CANC(c)")))


  (setq org-capture-templates
        `(("t" "Todo to Inbox" entry
           (file+headline ,(concat org-directory "inbox.org") "Inbox")
           "* TODO %?\n"
           :empty-lines 1)
          ("T" "Todo to Inbox with Clipboard" entry
           (file+headline ,(concat org-directory "inbox.org") "Inbox")
           "* TODO %?\nSCHEDULED: %t\n%c\n\n%i\n"
           :empty-lines 1)
          ("l" "Current file log entry" entry
           (file+olp+datetree buffer-file-name)
           "* %u %? \n" :tree-type month)
          ("D" "Daybook" entry
           (file+olp+datetree ,(concat org-directory "daybook.org"))
           "* %?\n%t\n" :time-prompt nil)
          ("e" "Event" entry
           (file+olp+datetree ,(concat org-directory "events.org"))
           "* %?\n%T\n" :time-prompt t)
          ("F" "Food Log" entry
           (file+datetree+prompt "~/org/food.org")
            "* %?\n%t\n%^{category}p%^{Type}p")
          ("s" "Add to Spark File" entry
           (file+headline ,(concat org-directory "sparkfile.org") "2022")
           "* %?\n%U" :prepend t)
          ("d" "Doing now" entry
           (file+headline ,(concat org-directory "doing.org") "Currently")
           "* %U %?" :prepend t)
         ("m" "Email Workflow")
           ("mf" "Follow Up" entry (file+olp "~/org/inbox.org" "Inbox")
            "* TODO Follow up with %:from on %a\nSCHEDULED:%t\n\n%i")
           ("mr" "Read Later" entry (file+olp "~/org/inbox.org" "Inbox")
            "* TODO Process %:subject\nSCHEDULED:%t\n%a\n\n%i")
          ("n" "Add a Note" entry
           (file+headline ,(concat org-directory "notes.org") "Notes")
           "* %?\n%U" :prepend t))))


(setq org-agenda-custom-commands
      '(("%" "Appointments" agenda* "Today's appointments"
         ((org-agenda-span 1)
          (org-agenda-max-entries 3)))
        ("D" "Daily Action List" agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-sorting-strategy
                    (quote
                     ((agenda time-up category-up tag-up))))
                   (org-deadline-warning-days 7))
                  nil)
        ("X" agenda "" nil "~/tmp/agenda.ics")))
(setq org-agenda-custom-commands
      '(("%" "Appointments" agenda* "Today's appointments"
         ((org-agenda-span 1)
          (org-agenda-max-entries 3)))
        ("D" "Daily Action List" agenda ""
                  ((org-agenda-span 1)
                   (org-agenda-sorting-strategy
                    (quote
                     ((agenda time-up category-up tag-up))))
                   (org-deadline-warning-days 7))
                  nil)
        ("g" "Get Things Done (GTD)"
         ((agenda ""
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-deadline-warning-days 0)))
          (todo "NEXT"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks\n")))
          (agenda nil
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-format-date "")
                   (org-deadline-warning-days 7)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                   (org-agenda-overriding-header "\nDeadlines")))
          (tags-todo "inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "\nInbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n")))))))





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


(setq org-export-with-broken-links t)

;; Create ICS calendar


;; Setting variables for the ics file path
(setq org-agenda-private-local-path "~/tmp/agenda.ics")
(setq org-agenda-private-remote-path "/sshx:jbaty@server01.baty.net:apps/daily.baty.net/public_html/agenda.ics")


(defun jab/org-agenda-export-to-ics ()
    (interactive)
  ;;(set-org-agenda-files)
  ;; Run all custom agenda commands that have a file argument.
  (org-batch-store-agenda-views)

  ;; Org mode correctly exports TODO keywords as VTODO events in ICS.
  ;; However, some proprietary calendars do not really work with
  ;; standards (looking at you Google), so VTODO is ignored and only
  ;; VEVENT is read.
  (with-current-buffer (find-file-noselect org-agenda-private-local-path)
    (goto-char (point-min))
    (while (re-search-forward "VTODO" nil t)
      (replace-match "VEVENT"))
    (save-buffer))

;; Copy the ICS file to a remote server (Tramp paths work).
  (copy-file org-agenda-private-local-path org-agenda-private-remote-path t))


(setq org-html-postamble t)
(setq org-html-postamble-format
        '(("en" "<hr>\n<p>Author: <strong><a href=\"https://baty.net\">Jack Baty</a></strong> <a href='mailto:%e' rel='author'>💌</a> | Last updated: %C</p>")))

(setq org-publish-project-alist
  '(("roam-notes"
     :base-directory "~/org/roam/public"
     :html-html5-fancy t
     :auto-sitemap t
     :org-publish-sitemap-sort-files "anti-chronologically" ;; or "alphabetically"
     :base-extension "org"
     :sitemap-title ""
     ;; :org-html-home/up-format "<div class=\"top-nav\"><a href=\"/index.html\">Home</a></div>"
     :makeindex t
     :recursive t
     :publishing-function org-html-publish-to-html
     :publishing-directory "~/sites/roam/public_html"
     :section-number nil
     :table-of-contents nil)
    ("notes"
     :base-directory "~/Documents/notes"
     :html-html5-fancy t
     :auto-sitemap t
     :org-publish-sitemap-sort-files "anti-chronologically" ;; or "alphabetically"
     :base-extension "org"
     :sitemap-title ""
     ;; :org-html-home/up-format "<div class=\"top-nav\"><a href=\"/index.html\">Home</a></div>"
     :makeindex t
     :recursive t
     :publishing-function org-html-publish-to-html
     :publishing-directory "~/sites/notes/public_html"
     :section-number nil
     :table-of-contents nil)
    ("roam-static"
     :base-directory "~/org/roam/public"
     :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
     :publishing-directory "~/sites/roam/public_html"
     :recursive t
     :publishing-function org-publish-attachment)
    ("notes-static"
     :base-directory "~/Documents/notes"
     :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
     :publishing-directory "~/sites/notes/public_html"
     :recursive t
     :publishing-function org-publish-attachment)
    ("notes.baty.net" :components ("roam-notes" "roam-static"))))

(after! org
;; custom link types
(org-link-set-parameters "brain"
  :follow (lambda (path) (shell-command (concat "open brain:" path))))
(org-link-set-parameters "x-devonthink-item"
  :follow (lambda (path) (shell-command (concat "open x-devonthink-item:" path))))
(org-link-set-parameters "x-eaglefiler"
  :follow (lambda (path) (shell-command (concat "open \"x-eaglefiler:" path "\""))))
(org-link-set-parameters "message"
  :follow (lambda (path) (shell-command (concat "open \"message:" path "\"")))))

;;(load "org-maillink")

;; Elfeed
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread")
  (setq elfeed-search-remain-on-entry t)
  (setq elfeed-goodies/entry-pane-position 'bottom))

;; See https://github.com/hlissner/doom-emacs/issues/5714
(defalias '+org--restart-mode-h #'ignore)

(with-eval-after-load 'ox-hugo
  (add-to-list 'org-hugo-special-block-type-properties '("sidenote" . (:trim-pre t :trim-post t))))

;; Temporary fix. See https://notes.baty.net/notes/possible-workaround-for-ox-hugo-error-during-exports/
;;(with-eval-after-load 'ox-hugo
;;  (setq org-hugo--preprocess-buffer nil))

(setq org-id-extra-files (directory-files-recursively org-roam-directory "\.org$"))

(after! org
  (setq org-wild-notifier-alert-time '(5 10 15 30 60))
  (setq org-wild-notifier-keyword-whitelist nil)
  (setq org-wild-notifier-notification-title "*reminder*")
  (org-wild-notifier-mode 1))
