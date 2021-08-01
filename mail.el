(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e/")

;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
(set-email-account! "Baty.net"
  '((mu4e-sent-folder       . "/Baty.net/Sent Items")
    (mu4e-drafts-folder     . "/Baty.net/Drafts")
    (mu4e-trash-folder      . "/Baty.net/Trash")
    (mu4e-refile-folder     . "/Baty.net/Archive")
    (smtpmail-smtp-user     . "mrjackbaty@fastmail.fm"))
  t)


;; override Doom's default, which uses macOS keychain
;; I get errors about that being unsupported
;;(after! auth-source
;;(setq auth-sources '("~/.authinfo")))

;; this setting allows to re-sync and re-index mail
;; by pressing U
(setq mu4e-get-mail-command  "mbsync -a")
