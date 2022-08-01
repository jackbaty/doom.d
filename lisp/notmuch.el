
(setq +notmuch-sync-backend 'mbsync)

(setq notmuch-hello-auto-refresh t)
(setq notmuch-show-all-tags-list t)
(setq notmuch-search-oldest-first nil)

(setq notmuch-archive-tags '("-inbox" "-unread"))
(setq notmuch-message-replied-tags '("+replied"))
(setq notmuch-message-forwarded-tags '("+forwarded"))
(setq notmuch-show-mark-read-tags '("-unread"))
(setq notmuch-draft-tags '("+draft"))
(setq notmuch-draft-folder "drafts")
