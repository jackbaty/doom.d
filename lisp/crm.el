;;; lisp/crm.el -*- lexical-binding: t; -*-

(defun org-set-contacted-today ()
  "Set the CONTACTED property of the current item to today's date."
  (interactive)
  (org-set-property "CONTACTED" (format-time-string "%Y-%m-%d")))

(defun org-set-contacted-date ()
  "Set the CONTACTED property of the current item to a chosen date."
  (interactive)
  (let ((date (org-read-date nil t nil "Enter the date: ")))
    (org-set-property "CONTACTED" (format-time-string "%Y-%m-%d" date))))

(map! :mode org-mode
      :localleader
      :desc "Set CONTACTED property to today"
      "C t" #'org-set-contacted-today
      "C d" #'org-set-contacted-date
      "C z" #'my/org-remove-todo)

(defun org-contacted-days-between (min-days max-days)
  (let ((contacted-date (org-entry-get (point) "CONTACTED"))
        (today (current-time)))
    (when contacted-date
      (let ((days-ago (time-to-number-of-days
                      (time-subtract today (org-time-string-to-time contacted-date)))))
        (and (>= days-ago min-days) (< days-ago max-days))))))

(defun org-contacted-more-than-days-ago (days)
  (let ((contacted-date (org-entry-get (point) "CONTACTED"))
        (today (current-time)))
    (when contacted-date
      (> (time-to-number-of-days
          (time-subtract today (org-time-string-to-time contacted-date)))
         days))))

(defun org-contacted-never-p ()
  (not (org-entry-get (point) "CONTACTED")))

(defun my/org-set-heading-state-and-time (state days &optional time-type)
  "Sets the TODO state and deadline or scheduled date of the current heading.
   STATE is the new TODO state to set, and DAYS is the number
   of days from the current date to set the new time. If TIME-TYPE
   is 'd', sets a deadline; if 's', sets a scheduled date; otherwise,
   prompts the user for the time type. Removes any existing schedules
   or deadlines before setting the new time."
  (interactive (list "WRITE" 7 nil))
  (org-entry-put nil "TODO" state)
  (when (org-entry-get nil "DEADLINE")
    (org-entry-delete nil "DEADLINE"))
  (when (org-entry-get nil "SCHEDULED")
    (org-entry-delete nil "SCHEDULED"))
  (let ((new-time (format-time-string "<%Y-%m-%d %a>"
                                      (time-add (current-time) (days-to-time days)))))
    (cond ((equal time-type 'd)
           (org-deadline nil new-time))
          ((equal time-type 's)
           (org-schedule nil new-time))
          (t
           (setq time-type (completing-read "Set time type (d/s): "))
           (my/org-set-heading-state-and-time state days (if (string= time-type "d") 'd 's))))))

(global-set-key (kbd "C-c t") (lambda () (interactive) (my/org-set-heading-state-and-time "WRITE" 7 'd)))

(map! :mode org-mode
      :localleader
      :desc "Remember to write"
      "C w" #'(lambda () (interactive)
        (my/org-set-heading-state-and-time "WRITE" 7 'd))
      :desc "Remember to followup"
      "C f" #'(lambda () (interactive)
        (my/org-set-heading-state-and-time "FOLLOWUP" 3 's))
      :desc "Remember to invite"
      "C i" #'(lambda () (interactive)
        (my/org-set-heading-state-and-time "INVITE" 3 'd))
      "C F" #'(lambda () (interactive)
        (my/org-set-heading-state-and-time "" 30 's)))


(add-to-list 'org-agenda-custom-commands
             '("c" "Contacts TODOs"
               ((tags-todo "CATEGORY=\"contacts\"&-PINGED&-SCHEDULED"
                           ((org-agenda-files '("~/org/contacts.org"))
                            (org-agenda-overriding-header "Contacts TODOs")
                            (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("PINGED" "SCHEDULED")))
                            (org-agenda-sorting-strategy '(tag-up))))))
               nil
               nil)

                (add-to-list 'org-agenda-custom-commands
             '("N" "Network last contacted > 90 days ago"
               ((tags "network"
                      ((org-agenda-overriding-header "Network contacts, not contacted in the past 90 days")
                       (org-tags-match-list-sublevels t)
                       (org-agenda-skip-function
                        (lambda ()
                          (unless (org-contacted-more-than-days-ago 90)
                            (or (outline-next-heading)
                                (goto-char (point-max))))))))
                )))
(add-to-list 'org-agenda-custom-commands
             '("F" "Close people last contacted > 30 days ago"
               ((tags "close|fam"
                      ((org-agenda-overriding-header "Close friends and family, not contacted in the past 30 days")
                       (org-tags-match-list-sublevels t)
                       (org-agenda-skip-function
                        (lambda ()
                          (unless (org-contacted-more-than-days-ago 30)
                            (or (outline-next-heading)
                                (goto-char (point-max)))))))) )))


(defun my/org-update-priorities-based-on-contacted ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^\\*+ " nil t)
      (let ((contacted-date (org-entry-get (point) "CONTACTED"))
            (today (format-time-string "%Y-%m-%d")))
        (when contacted-date
          (let ((days-ago (- (time-to-days (current-time))
                             (time-to-days (org-time-string-to-time contacted-date))))) ; calculate days since CONTACTED date
            (org-set-property "PRIORITY"
                               (cond
                                ((< days-ago 45) "C")
                                ((< days-ago 90) "B")
                                (t "A")))))))))


(add-hook 'org-mode-hook
          (lambda ()
            (when (string-equal (buffer-file-name) "~/org/roam/people/contacts.org")
              (add-hook 'after-save-hook 'my/org-update-priorities-based-on-contacted nil 'make-it-local))))
