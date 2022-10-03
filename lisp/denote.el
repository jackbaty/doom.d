;; Denote
;;

(require 'denote)

;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/org/notes/"))
(setq denote-known-keywords '("emacs" "photography" "software" "person"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil) ; Org is the default, set others here
(setq denote-prompts '(title keywords))

(setq denote-date-prompt-use-org-read-date t) ; fancy date picker

;; We allow multi-word keywords by default.  The author's personal
;; preference is for single-word keywords for a more rigid workflow.
(setq denote-allow-multi-word-keywords nil)

(setq denote-date-format nil) ; read doc string


;; By default, we fontify backlinks in their bespoke buffer.
(setq denote-link-fontify-backlinks t)

;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; advanced.

;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
;;(add-hook 'find-file-hook #'denote-link-buttonize-buffer)

;; Hide file permissions by default
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq denote-dired-rename-expert nil)

(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Desktop/Beyond the Infinite")))

;; Generic (great if you rename files Denote-style in lots of places):
(add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
;;(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

;; Journaling (stolen from Denote's manual)
(defun jab/denote-journal ()
  "Create an entry tagged 'journal' with the date as its title."
  (interactive)
  (denote
   (format-time-string "%A %e %B %Y") ; format like Tuesday 14 June 2022
   '("journal")
   nil
   (concat denote-directory "journal"))) ; multiple keywords are a list of strings: '("one" "two")

(defun jab/search-denote ()
 "Run consult-ripgrep on the denote directory"
 (interactive)
 (consult-ripgrep denote-directory nil))

(defun jab/find-denote-file-find ()
 "Run consult-find on the denote directory"
 (interactive)
 (consult-find denote-directory nil))

(defun jab/find-denote-file ()
 "Run consult-notes on the denote directory"
 (interactive)
 (consult-notes))

;; Denote does not define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n S") #'denote-subdirectory)
  (define-key map (kbd "C-c n j") #'jab/denote-journal) ; our custom command
  (define-key map (kbd "C-c n s") #'jab/search-denote)
  (define-key map (kbd "C-c n f") #'jab/find-denote-file)
  (define-key map (kbd "s-k")     #'jab/find-denote-file)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link-or-create) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-link-add-links)
  (define-key map (kbd "C-c n l") #'denote-link-find-file) ; "list" links
  (define-key map (kbd "C-c n b") #'denote-link-backlinks)
  (define-key map (kbd "s-l") #'denote-link-backlinks)
  ;; Note that `denote-dired-rename-file' can work from any context, not
  ;; just Dired bufffers.  That is why we bind it here to the
  ;; `global-map'.
  (define-key map (kbd "C-c n r") #'denote-rename-file))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("N" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

