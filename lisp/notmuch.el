(after! notmuch
(setq +notmuch-sync-backend 'mbsync)
(setq +notmuch-delete-tags '("+deleted" "-inbox" "-unread")) ;; override doom's default

;; UI
(setq notmuch-hello-auto-refresh t)
(setq notmuch-show-all-tags-list t)
(setq notmuch-show-logo nil)
(setq notmuch-search-oldest-first nil)
(setq notmuch-show-empty-saved-searches t)
(setq notmuch-hello-thousands-separator ",")
(setq notmuch-search-result-format
        '(("date" . "%12s  ")
          ("count" . "%-7s  ")
          ("authors" . "%-15s  ")
          ("subject" . "%-50s ")
          ("tags" . "(%s)")))

;; Composing
(setq notmuch-mua-cite-function 'message-cite-original-without-signature)

;; Tagging
(setq notmuch-archive-tags '("-inbox" "-unread" "+archived"))
(setq notmuch-message-replied-tags '("+replied"))
(setq notmuch-message-forwarded-tags '("+forwarded"))
(setq notmuch-show-mark-read-tags '("-unread"))
(setq notmuch-draft-tags '("+draft"))
(setq notmuch-draft-folder "drafts")
;;(setq notmuch-fcc-dirs "sent +sent -unread -inbox") ;; sent mail (and set tags)

;; Reading
(setq notmuch-wash-citation-lines-prefix 6)
(setq notmuch-wash-citation-lines-suffix 6)

;; Bindings

;; Unbind K first
(unbind-key "K" evil-normal-state-map)
(unbind-key "K" evil-visual-state-map)

;; Bind your key
(map! :map notmuch-search-mode-map
        :n "K" #'notmuch-tag-jump)


(add-hook 'notmuch-mua-send-hook #'notmuch-mua-attachment-check)

(setq notmuch-tagging-keys
        `((,(kbd "a") notmuch-archive-tags "Archive (remove from inbox)")
          (,(kbd "d") ("+deleted" "-unread" "-inbox") "Mark for deletion")
          (,(kbd "f") ("+flag") "Flag as important")
          (,(kbd "s") ("+spam" "-inbox" "-unread") "Mark as spam")
          (,(kbd "t") ("+todo" "-unread" "-archived") "To-do")
          (,(kbd "T") ("-unread" "+archived") "To-do")
          (,(kbd "R") ("+readlater" "-unread" "-inbox") "Read later")
          (,(kbd "r") ("-unread") "Mark as read")
          (,(kbd "u") ("+unread") "Mark as unread")))


(setq notmuch-saved-searches
        `(( :name "inbox"
            :query "tag:inbox"
            :sort-order oldest-first
            :key ,(kbd "i"))
          ( :name "unread (inbox)"
            :query "tag:unread and tag:inbox"
            :sort-order oldest-first
            :key ,(kbd "u"))
          ( :name "unread all"
            :query "tag:unread not tag:archived"
            :sort-order newest-first
            :key ,(kbd "U"))
          ( :name "sent"
            :query "tag:sent"
            :key ,(kbd "s"))
          ( :name "references"
            :query "tag:ref not tag:archived"
            :sort-order newest-first
            :key ,(kbd "r"))
          ( :name "todo"
            :query "tag:todo not tag:archived"
            :sort-order newest-first
            :key ,(kbd "t"))
          ( :name "today"
            :query "date:today"
            :sort-order newest-first
            :key ,(kbd "T"))
          ( :name "mailing lists"
            :query "tag:list not tag:archived"
            :sort-order newest-first
            :key ,(kbd "m"))
          ( :name "sourcehut"
            :query "(from:~jbaty/public-inbox@lists.sr.ht or to:~jbaty/public-inbox@lists.sr.ht) not tag:archived"
            :sort-order newest-first
            :key ,(kbd "os"))))

(setq auth-sources '("~/.authinfo"))
(setq
   message-send-mail-function   'smtpmail-send-it
   smtpmail-default-smtp-server "smtp.fastmail.com"
   smtpmail-smtp-server         "smtp.fastmail.com"
   send-mail-function    'smtpmail-send-it
   smtpmail-smtp-server  "smtp.fastmail.com"
   smtpmail-stream-type  'ssl
   smtpmail-smtp-service 465)


(defun jab/snip-region (beg end)
  "Kill the region BEG to END and replace with <snip> tag."
  (interactive (list (point) (mark)))
  (kill-region beg end)
  (when (string-prefix-p ">" (car kill-ring))
    (insert "[snip]\n")))


(map! :map notmuch-hello-mode-map ;; Mu4e muscle memory
      "U" #'+notmuch/update)

(map! :map message-mode-map
      "C-w" #'jab/snip-region))
