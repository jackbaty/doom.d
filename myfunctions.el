

(defun jab/insert-weather ()
  "Use wttr to insert the current weather at point"
  (interactive)
  (let ((w (shell-command-to-string "curl -s 'wttr.in/49301?0q&format=%c+%C+%t' | head -n6")))
  (insert (concat w "\n"))))

(defun jab/deploy-daily-blog ()
  "Deploy website to daily.baty.net"
  (interactive)
  (shell-command "~/Library/Scripts/Applications/Emacs/Deploy-daily.baty.net.sh"))

(defun jab/openfriends ()
  "Open daily haunt websites"
    (interactive)
    (progn
      (browse-url "https://alexjj.com/")
      (browse-url "https://youneedastereo.com/#")
      (browse-url "https://nice-marmot.net/")
      (browse-url "https://baty.blog")))

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
  (interactive)
  (let (($path (jab/finder-path)))
    (if (string-equal "" $path)
        (message "No Finder window found.")
      (dired $path))))
