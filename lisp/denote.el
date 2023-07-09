;; Denote
;;
;;
(add-to-list 'load-path "~/Sync/emacs/lisp/denote")


(require 'denote)
(require 'denote-org-dblock)

(after! denote
  (org-link-set-parameters "denote"
                         :face '(:foreground "orange" :underline t)))


;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Denotes/"))
(setq denote-known-keywords '("emacs" "photography" "software" "person"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil) ; Org is the default, set others here
(setq denote-prompts '(title keywords))

(setq denote-date-prompt-use-org-read-date t) ; fancy date picker

;; I'm using the ID property rather than Denotes "identifier"
;; (setq denote-org-front-matter
;;       ":PROPERTIES:
;; :ID: %4$s
;; :END:
;; #+title:    %1$s
;; #+date:     %2$s
;; #+filetags: %3$s
;; \n")


;; We allow multi-word keywords by default.  The author's personal
;; preference is for single-word keywords for a more rigid workflow.
(setq denote-allow-multi-word-keywords nil)

(setq denote-date-format nil) ; read doc string

(setq denote-backlinks-show-context t)

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

(defun my-denote-journal ()
  "Create an entry tagged 'journal' with the date as its title.
If a journal for the current day exists, visit it.  If multiple
entries exist, prompt with completion for a choice between them.
Else create a new file."
  (interactive)
  (let* ((today (format-time-string "%A %B %e %Y"))
         (string (denote-sluggify today))
         (files (denote-directory-files-matching-regexp string)))
    (cond
     ((> (length files) 1)
      (find-file (completing-read "Select file: " files nil :require-match)))
     (files
      (find-file (car files)))
     (t
      (denote
       today
       '("journal")
       nil
       "~/Documents/Notes/journal")))))




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
  (define-key map (kbd "C-c n j") #'my-denote-journal) ; our custom command
  (define-key map (kbd "C-c n s") #'jab/search-denote)
  (define-key map (kbd "C-c n f") #'jab/find-denote-file)
  ;;(define-key map (kbd "s-k")     #'denote-open-or-create)
  (define-key map (kbd "s-k")     #'jab/find-denote-file)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link-or-create) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-link-add-links)
  (define-key map (kbd "C-c n l") #'denote-link-find-file) ; "list" links
  (define-key map (kbd "C-c n b") #'denote-link-find-backlink)
  (define-key map (kbd "C-c n k") #'denote-keywords-add)
  (define-key map (kbd "C-c n K") #'denote-keywords-remove)
  (define-key map (kbd "C-c n r") #'denote-rename-file-using-front-matter)
  (define-key map (kbd "s-l") #'denote-link-find-backlink)
  ;; Note that `denote-dired-rename-file' can work from any context, not
  ;; just Dired bufffers.  That is why we bind it here to the
  ;; `global-map'.
  (define-key map (kbd "C-c n R") #'denote-rename-file))

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

;; Should speed up backing buffer builds
(setq xref-search-program 'ripgrep)

(setq consult-notes-denote-display-id nil)
(consult-notes-denote-mode)

;; Add all Denote files tagged as "project" to org-agenda-files
(defun jab/denote-add-to-agenda-files (keyword)
  "Append list of files containing 'keyword' to org-agenda-files"
  (interactive)
  (jab/init-org-agenda-files) ;; start over
  (setq org-agenda-files (append org-agenda-files (directory-files denote-directory t keyword))))



;; From Prot

    (defvar my-denote-to-agenda-regexp "_wip"
      "Denote file names that are added to the agenda.
    See `my-add-denote-to-agenda'.")

    (defun my-denote-add-to-agenda ()
      "Add current file to the `org-agenda-files', if needed.
    The file's name must match the `my-denote-to-agenda-regexp'.

    Add this to the `after-save-hook' or call it interactively."
      (interactive)
      (when-let* ((file (buffer-file-name))
                  ((denote-file-is-note-p file))
                  ((string-match-p my-denote-to-agenda-regexp (buffer-file-name))))
        (add-to-list 'org-agenda-files file)))

    ;; Example to add the file automatically.  Uncomment it:

    (add-hook 'after-save-hook #'my-denote-add-to-agenda)

    (defun my-denote-remove-from-agenda ()
      "Remove current file from the `org-agenda-files'.
    See `my-denote-add-to-agenda' for how to add files to the Org
    agenda."
      (interactive)
      (when-let* ((file (buffer-file-name))
                  ((string-match-p my-denote-to-agenda-regexp (buffer-file-name))))
        (setq org-agenda-files (delete file org-agenda-files))))


;; https://lists.sr.ht/~protesilaos/denote/%3Cm0tu6q6bg0.fsf%40disroot.org%3E
;; Doesn't seem to work
;; (after! denote
;; (defun my-denote-dired-mode-hook()
;;   (denote-dired-mode-in-directories)
;;   (if denote-dired-mode
;;       (dired-hide-details-mode +1)
;;     (diredfl-mode nil))))

(defun my-denote-dired-mode-hook()
  (denote-dired-mode-in-directories)
  (if denote-dired-mode
      (dired-hide-details-mode +1)
    (diredfl-mode +1)))

(add-hook 'dired-mode-hook #'my-denote-dired-mode-hook)


(add-hook 'dired-mode-hook #'jab/setup-denote-dired-mode)
;;(jab/denote-add-to-agenda-files "_wip")
;;
(defun jab/setup-denote-dired-mode()
    (interactive)
  (if denote-dired-mode
      (dired-hide-details-mode +1)))

;; Publishing
;; Mike Hall: https://gist.github.com/pdxmph/1d17833f910dbfd86068d94cfac585f9
(setq org-html-divs
    '((preamble "header" "preamble")
      (content "main" "content")
      (postamble "footer" "postamble")))

(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-export-with-author nil
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />
                     <link rel=\"stylesheet\" href=\"/local.css\" />
                     <script src=\"https://cdn.jsdelivr.net/npm/fuse.js@6.6.2\"></script>")

(setq org-publish-project-alist
      `(("denote"
         :base-directory "~/Denotes"
         :base-extension "org"
         :publishing-directory "~/Denotes-web/"
         :publishing-function org-html-publish-to-html
         :recursive t
         :auto-sitemap t
         :with-tags t
         :html-validation-link t
         :section-numbers nil
         :sitemap-sort-files anti-chronologically
         :html-preamble "<nav><ul>
                           <li><a href=\"/\" class=\"home\">Home</a>
                           <li><a href=\"/sitemap.html\">All Notes</a>
                           </ul>
                         </nav>
                         "
         :sitemap-format-entry (lambda (entry style project)
                        (let ((title (org-publish-find-title entry project))
                              (date (format-time-string "%Y-%m-%d" (org-publish-find-date entry project))))
                          (if (not (equal entry ""))
                              (format "[[file:%s][%s]] (%s)" entry title date)
                            ""))))))

;; Set as a post-save hook
(defun mph/publish-and-update-index ()
  "Publish our projects then update the fuse index."
  (interactive)
  (progn
    (call-interactively 'org-publish-all)
    (shell-command "python3 ~/bin/fuse-index.py /Users/jbaty/Denotes-web")))
