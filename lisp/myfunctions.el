

(defun jab/insert-weather ()
  "Use wttr to insert the current weather at point"
  (interactive)
  (let ((w (shell-command-to-string "curl -s 'wttr.in/49301?0q&format=%c+%C+%t' | head -n6")))
  (insert (concat w "\n"))))

(defun jab/deploy-daily-blog ()
  "Deploy website to daily.baty.net"
  (interactive)
  (shell-command "~/Library/Scripts/Applications/Emacs/Deploy-daily.baty.net.sh"))

(defun jab/deploy-blog ()
  "Deploy website to baty.net"
  (interactive)
  (shell-command "cd ~/sites/blog & make deploy"))

(defun jab/markregion ()
  "Add a 'mark' macro to the current region (for Hugo)"
  (interactive)
  (if (region-active-p)
      (progn
        (goto-char (region-end))
        (insert ")}}}")
        (goto-char (region-beginning))
        (insert "{{{mark("))))


(defun jab/openfriends ()
  "Open daily haunt websites"
    (interactive)
    (progn
      (browse-url "https://fondoftea.com")
      (browse-url "https://youneedastereo.com/#")
      (browse-url "https://alexjj.com")
      (browse-url "https://nice-marmot.net/")))

;; From https://christiantietze.de/posts/2021/07/open-finder-window-in-dired/
(defun jab/finder-path ()
  "Return path of the frontmost Finder window, or the empty string.

Asks Finder for the path using AppleScript via `osascript', so
this can take a second or two to execute."
  (let ($applescript)
    (setq $applescript "tell application \"Finder\" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)")
    (with-temp-buffer
      ;; Produce a list of process exit code and process output (from the temp buffer)
      (call-process "/usr/bin/osascript" nil (current-buffer) nil "-e" $applescript)
      (string-trim (buffer-string)))))

(defun jab/dired-finder-path ()
  "Open the frontmost finder window's path in dired"
  (interactive)
  (let (($path (jab/finder-path)))
    (if (string-equal "" $path)
        (message "No Finder window found.")
      (dired $path))))

(defun jab/generate-agenda-weekly-review ()
  "Generate the agenda for the weekly review"
  (interactive)
  (let ((span-days 24)
        (offset-past-days 10))
    (message "Generating agenda for %s days starting %s days ago"
             span-days offset-past-days)
    (org-agenda-list nil (- (time-to-days (date-to-time
                                           (current-time-string)))
                            offset-past-days)
                     span-days)
    (org-agenda-log-mode)
    (goto-char (point-min))))

;; Align comments in marked region
;; Via https://stackoverflow.com/a/20278032
(defun jab/align-comments (beginning end)
  "Align comments within marked region."
  (interactive "*r")
  (let (indent-tabs-mode align-to-tab-stop)
    (align-regexp beginning end (concat "\\(\\s-*\\)"
                                        (regexp-quote comment-start)))))


;; recenter frame
(defun jab/frame-center (&optional frame)
  "Center FRAME on the screen.
FRAME can be a frame name, a terminal name, or a frame.
If FRAME is omitted or nil, use currently selected frame."
  (interactive)
  (unless (eq 'maximised (frame-parameter nil 'fullscreen))
    (modify-frame-parameters
     frame '((user-position . t) (top . 0.5) (left . 0.5)))))
