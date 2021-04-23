

(defun jab/insert-weather ()
  "Use wttr to insert the current weather at point"
  (interactive)
  (let ((w (shell-command-to-string "curl -s 'wttr.in/49301?0q&format=%c+%C+%t' | head -n6")))
  (insert (concat w "\n"))))
