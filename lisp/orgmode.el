;; -*- lexical-binding: t; -*-
(add-hook! org-mode :append
           #'visual-line-mode)


;; Don't muck with this or existing links may break
(setq org-attach-preferred-new-method 'dir)
(setq org-attach-id-dir  "~/org/attach/")
(setq org-attach-auto-tag "attach")
(setq org-attach-store-link-p t)
;;
;; Org Download for drag-n-drop
;; from: https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/
(defun jab/org-download-paste-clipboard (&optional use-default-filename)
  (interactive "P")
  (require 'org-download)
  (let ((file
         (if (not use-default-filename)
             (read-string (format "Filename [%s]: "
                                  org-download-screenshot-basename)
                          nil nil org-download-screenshot-basename)
           nil)))
    (org-download-clipboard file)))

;; Fix for "Invalid Base64 data" when displaying attachments
;; See https://github.com/doomemacs/doomemacs/issues/3185#issue-621758002
(defadvice! no-errors/+org-inline-image-data-fn (_protocol link _description)
  :override #'+org-inline-image-data-fn
  "Interpret LINK as base64-encoded image data. Ignore all errors."
  (ignore-errors
    (base64-decode-string link)))

(after! org
  (require 'org-download)
  (setq org-download-method 'attach)
  (setq org-download-image-dir "files")
  (setq org-download-heading-lvl nil)
  ;;(setq org-download-timestamp "%Y%m%d-")
  (setq org-download-timestamp "")
  (setq org-image-actual-width 300))


(after! org
(setq org-agenda-files (list
                   (concat org-directory "todo.org")
                   (concat org-directory "inbox.org")
                   (concat org-directory "events.org")
                   (concat org-directory "food.org")
                   (concat org-directory "daybook.org"))))


;; (setq org-refile-targets '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")
;;                            ("todo.org" :maxlevel . 1)
;;                            (org-agenda-files :tag . "refile")))

(after! org
(setq org-refile-targets '((nil :maxlevel . 3)
                           (org-agenda-files :maxlevel . 1)
                           ("notes.org" :level . 2)
                           (org-agenda-files :tag . "refile"))))


(after! org
 ;; (setq org-return-follows-link t)
   (setq org-agenda-include-diary t
       ;;org-agenda-start-on-weekday nil
       org-agenda-span 'day
       org-agenda-tags-column 'auto
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
       org-ellipsis "…"
       org-tags-column 0
       org-log-done 'time
       org-log-into-drawer t
       org-image-actual-width '(600)
       org-startup-with-inline-images t
       org-startup-folded 'content
       org-log-redeadline 'note
       org-habit-show-all-today t
       org-agenda-text-search-extra-files (quote (agenda-archives))
       org-agenda-window-setup (quote current-window))


  (add-to-list 'org-tags-exclude-from-inheritance "project")
  (add-to-list 'org-modules 'org-habit)
  (setq org-stuck-projects
      '("+project/-MAYBE-DONE" ("NEXT" "TODO")))

 (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "CNCL(c)")))


  (setq org-capture-templates
        `(("t" "Todo to Inbox" entry
           (file+headline ,(concat org-directory "inbox.org") "Inbox")
           "* TODO %?\n"
           :empty-lines 1)
          ("T" "Todo to Inbox with Clipboard" entry
           (file+headline ,(concat org-directory "inbox.org") "Inbox")
           "* TODO %?\n%c\n\n%i\n"
           :empty-lines 1)
          ("l" "Log to current buffer (Datetree)" entry
           (file+olp+datetree buffer-file-name)
           "* %u %? \n" :tree-type month)
          ("d" "Daybook entry" entry
           (file+olp+datetree ,(concat org-directory "daybook.org"))
           "* %? %^g\n%t\n" :time-prompt nil)
          ("e" "Create an event" entry
           (file+olp+datetree ,(concat org-directory "events.org"))
           "* %?\n%T\n" :time-prompt t)
          ("s" "Add to Spark File" entry
           (file+headline ,(concat org-directory "sparkfile.org") "2023")
           "* %?\n%U" :prepend t)
          ("c" "Add to Commonplace book" entry
           (file ,(concat org-directory "commonplace.org"))
           "* %?\n%U\n\n#+begin_quote\n\n#+end_quote" :prepend t)
          ("m" "Capture email" entry (file+headline "inbox.org" "Inbox")
           "* TODO Follow up w/%:fromname: %a :email: %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))")
          ("W" "Weight" table-line
           (file+olp "~/org/roam/20230514075008-my_weight_tracking.org" "Weight Tracking" "Data")
           "| %U | %? | | |"
           :unnarrowed t)
          ("n" "Add a Note to Inbox.org" entry
           (file+headline ,(concat org-directory "inbox.org") "Notes")
           "* %? %^g\n%U" :prepend t))))




  (setq org-journal-dir "~/org/journal"
    org-journal-file-type 'monthly
    org-journal-file-format "%Y-%m.org"
    org-journal-find-file #'find-file
    org-journal-time-prefix ""
    org-journal-time-format ""
    org-journal-enable-agenda-integration nil
    org-journal-enable-encryption nil
    org-journal-date-format "%A, %B %d %Y")

;; I don't need completion or syntax checking in org files
(add-hook 'org-mode-hook (lambda () (company-mode -1)))
(add-hook 'org-mode-hook (lambda () (flycheck-mode -1)))


;; Load appointments
;;(org-agenda-to-appt)

;; Fix incorrect indenting in (esp. org-journal) buffers
(defun jab/disable-adaptive-wrap()
    (adaptive-wrap-prefix-mode -1))

(add-hook 'visual-line-mode-hook #'jab/disable-adaptive-wrap)


;;(add-hook 'org-journal-mode-hook #'+zen/toggle)
;;

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
     :base-directory "~/org/kb/public"
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
     :base-directory "~/org/kb/public"
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
(org-link-set-parameters "evernote"
  :follow (lambda (path) (shell-command (concat "open \"evernote:" path "\""))))
(org-link-set-parameters "curio"
  :follow (lambda (path) (shell-command (concat "open \"curio:" path "\""))))
(org-link-set-parameters "message"
  :follow (lambda (path) (shell-command (concat "open \"message:" path "\"")))))




(load "org-mac-link")

;; So org-attach-reveal opens the folder in Finder
;; Needed to change the directory entry
(after! org
  (setq org-file-apps
        '((remote . emacs)
          (auto-mode . emacs)
          (directory . "open %s")
          ("\\.mm\\'" . default)
          ("\\.x?html?\\'" . default)
          ("\\.pdf\\'" . default))))

;; Elfeed
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread")
  (setq elfeed-search-remain-on-entry t)
  (setq elfeed-goodies/entry-pane-position 'bottom))

;; See https://github.com/hlissner/doom-emacs/issues/5714
(defalias '+org--restart-mode-h #'ignore)


;;(global-org-modern-mode)

(with-eval-after-load 'ox-hugo
  (add-to-list 'org-hugo-special-block-type-properties '("sidenote" . (:trim-pre t :trim-post t))))



(defun jab/md-to-org-region (start end)
  "Convert region from markdown to org, replacing selection"
  (interactive "r")
  (shell-command-on-region start end "pandoc -f markdown -t org" t t))


(defun my/show-agenda ()
  (let ((agenda-frame (make-frame-command)))
    (select-frame agenda-frame)
    (org-agenda-list)
    (x-focus-frame agenda-frame)))

(after! org
(add-hook 'org-mode-hook 'org-indent-mode))

(after! org
  (setq org-agenda-time-grid '((weekly today remove-match)
                               (800 1000 1200 1400 1600 1800 2000)
                               " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")))


;; See https://mike.puddingtime.org/posts/20230413-making-a-plaintext-personal-crm-with-org-contacts
(defun jab/org-set-contacted-today ()
  "Set the CONTACTED property of the current item to today's date."
  (interactive)
  (org-set-property "CONTACTED" (format-time-string "%Y-%m-%d")))

(defun jab/org-set-contacted-date ()
  "Set the CONTACTED property of the current item to a chosen date."
  (interactive)
  (let ((date (org-read-date nil t nil "Enter the date: ")))
    (org-set-property "CONTACTED" (format-time-string "%Y-%m-%d" date))))

(map! :mode org-mode
      :localleader
      :desc "Set CONTACTED property to today"
      "c t" #'jab/org-set-contacted-today
      "c d" #'jab/org-set-contacted-date
      "c z" #'my/org-remove-todo
                )


(setq org-gtd-update-ack "3.0.0")
(use-package! org-gtd
  :after org
  :config
  (setq org-gtd-directory "~/org/gtd/")
  (setq org-edna-use-inheritance t)
  (setq org-edna-use-inheritance t)
  (setq org-gtd-areas-of-focus '("Home" "Health" "Family" "Career" "220"))
  (org-edna-mode)
  (map! :leader
        (:prefix ("d" . "org-gtd")
         :desc "Capture"        "c"  #'org-gtd-capture
         :desc "Engage"         "e"  #'org-gtd-engage
         :desc "Process inbox"  "p"  #'org-gtd-process-inbox
         :desc "Show all next"  "n"  #'org-gtd-show-all-next
         :desc "Stuck projects" "s"  #'org-gtd-review-stuck-projects))
  (map! :map org-gtd-clarify-map
        :desc "Organize this item" "C-c c" #'org-gtd-organize))

;; Need org-contacted-more-than-days-ago code
;; (add-to-list 'org-agenda-custom-commands
;;              '("N" "Professional network last contacted > 90 days ago"
;;                ((tags "network"
;;                       ((org-agenda-overriding-header "Network contacts, not contacted in the past 90 days")
;;                        (org-tags-match-list-sublevels t)
;;                        (org-agenda-skip-function
;;                         (lambda ()
;;                           (unless (org-contacted-more-than-days-ago 90)
;;                             (or (outline-next-heading)
;;                                 (goto-char (point-max)))))))) )))
