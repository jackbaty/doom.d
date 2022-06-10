(if IS-MAC (add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e/")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/"))


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
   mu4e-compose-format-flowed t
   smtpmail-smtp-service 465
   mu4e-split-view 'horizontal
   +org-capture-emails-file "~/org/todo.org"
   mu4e-headers-precise-alignment t
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
     :query "maildir:/Baty.net/INBOX NOT flag:trashed"))

(add-to-list 'mu4e-bookmarks
             '(:name "Yesterday's messages" :query "date:2d..1d" :key ?y) t))



;; override Doom's default, which uses macOS keychain
;; I get errors about that being unsupported
(after! auth-source
 (setq auth-sources '("~/.authinfo")))

;; For when I want plain-text only
;; (after! org-msg
;;   (setq +mu4e-compose-org-msg-toggle-next nil))

;; this setting allows to re-sync and re-index mail
;; by pressing U
(setq mu4e-get-mail-command  "mbsync -a")

(defun jab/mu4e-copy-message-at-point (&optional dir)
  "Copy message at point to somewhere else as <date>_<subject>.eml."
  (interactive)
  (let* ((msg (mu4e-message-at-point))
         (target (format "%s_%s.eml"
                         (format-time-string "%F" (mu4e-message-field msg :date))
                         (or (mu4e-message-field msg :subject) "No subject"))))
    (copy-file
     (mu4e-message-field msg :path)
     (format "%s/%s" (or dir (read-directory-name "Copy message to: ")) target) 1)))
