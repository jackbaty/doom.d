(setq elfeed-db-directory "~/.elfeed")
(setq elfeed-enclosure-default-dir (expand-file-name "~/Downloads"))


(defun jab/elfeed-item-to-notmuch ()
  "Convert the current Elfeed item to a message in Notmuch."
  (interactive)
  (let ((entry (elfeed-search-selected :single)))
    (when entry
      (let* ((content (elfeed-deref (elfeed-entry-content entry)))
             (content-str (if (stringp content) content (buffer-string))))
        (notmuch-mua-new-mail)
        (message-goto-to)
        (insert "jack+elfeed@baty.net")
        (message-goto-subject)
        (insert (elfeed-entry-title entry))
        (message-goto-body)
        (insert content)))))





(defun my/elfeed-entry-to-email (entry &optional recipient)
  "Convert an Elfeed ENTRY to an email and send it to RECIPIENT (optional)."
  (let ((title (elfeed-entry-title entry))
        (url (elfeed-entry-link entry))
        (date (elfeed-entry-date entry))
        (tags (elfeed-entry-tags entry))
        (content (elfeed-deref (elfeed-entry-content entry)))
        (to "jack@baty.net"))
    ;; Prompt for recipient if not specified
    (unless to
      (setq to (read-string "To: ")))
    ;; Create the email message
    (message "To: %s\nSubject: %s\n\n%s\n\n%s\n\n%s\n\n%s"
             to
             title
             url
             (format-time-string "%Y-%m-%d %H:%M:%S" date)
             (mapconcat 'symbol-name tags ", ")
             content)
    ;; Send the email
    (message-send-and-exit)))

(defun my/elfeed-entry-to-email-interactive ()
  "Convert the selected Elfeed entry to an email and send it."
  (interactive)
  (my/elfeed-entry-to-email (elfeed-search-selected :single)))
