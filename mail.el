(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e/")

;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
(set-email-account! "Baty.net"
  '((mu4e-sent-folder       . "/Baty.net/Sent Items")
    (mu4e-drafts-folder     . "/Baty.net/Drafts")
    (mu4e-trash-folder      . "/Baty.net/Trash")
    (mu4e-refile-folder     . "/Baty.net/Archive")
    (smtpmail-smtp-user     . "mrjackbaty@fastmail.fm"))
  t)


(after! mu4e
(setq
 mu4e-attachment-dir "~/tmp"
   message-send-mail-function   'smtpmail-send-it
   smtpmail-default-smtp-server "smtp.fastmail.com"
   smtpmail-smtp-server         "smtp.fastmail.com"
   send-mail-function    'smtpmail-send-it
   smtpmail-smtp-server  "smtp.fastmail.com"
   smtpmail-stream-type  'ssl
   smtpmail-smtp-service 465
   mu4e-split-view 'horizontal
   +org-capture-emails-file "~/org/todo.org"
 mu4e-headers-fields
        '((:human-date . 12)
          (:flags . 4)
          (:from . 25)
          (:subject)))

(setq mu4e-maildir-shortcuts
  '( (:maildir "/Baty.net/INBOX"       :key  ?i)
     (:maildir "/Baty.net/Archive"     :key  ?a)
     (:maildir "/Baty.net/Set Aside"   :key  ?t)
     (:maildir "/Baty.net/Reply Later" :key  ?l)
     (:maildir "/Baty.net/Screened"    :key  ?r)
     (:maildir "/Baty.net/Sent Items"  :key  ?s)))

(add-to-list 'mu4e-bookmarks
  ;; add bookmark for showing inbox without "trashed" messages
  '( :name "Inbox clean"
     :key  ?i
     :query "maildir:/Baty.net/INBOX NOT flag:trashed")))



;; override Doom's default, which uses macOS keychain
;; I get errors about that being unsupported
(after! auth-source
 (setq auth-sources '("~/.authinfo")))


;; this setting allows to re-sync and re-index mail
;; by pressing U
(setq mu4e-get-mail-command  "mbsync -a")
