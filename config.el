;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jack Baty"
      user-mail-address "jack@baty.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-flatwhite)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(add-load-path! "~/Dropbox/emacs/lisp")
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 120))

;; looky-feely

(global-visual-line-mode)




;; Org Mode



(setq org-agenda-files (list
                   (concat org-directory "timesheet.org")
                   (concat org-directory "fusionary.org")
                   (concat org-directory "tasks.org")))



(after! org
  (setq org-return-follows-link t)
   (setq org-agenda-include-diary t
       org-agenda-start-on-weekday nil
       org-agenda-start-day nil
       org-agenda-log-mode-items (quote (closed))
       org-agenda-persistent-filter t
       org-agenda-skip-scheduled-if-deadline-is-shown (quote not-today)
       org-agenda-skip-deadline-prewarning-if-scheduled t
       org-agenda-skip-scheduled-if-done t
       org-agenda-skip-deadline-if-done t
       org-deadline-warning-days 7
       org-tags-column 0
       org-log-done 'time
       org-log-into-drawer t
       org-log-redeadline 'note
       org-agenda-text-search-extra-files (quote (agenda-archives))
       org-agenda-window-setup (quote current-window))
  (setq org-capture-templates
        `(("t" "Todo to Inbox" entry
           (file+headline ,(concat org-directory "tasks.org") "Inbox")
           "* TODO %?\nSCHEDULED: %t\n\n%i\n"
           :empty-lines 1)
          ("T" "Todo to Inbox with Clipboard" entry
           (file+headline ,(concat org-directory "tasks.org") "Inbox")
           "* TODO %?\nSCHEDULED: %t\n%c\n\n%i\n"
           :empty-lines 1)
          ("l" "Current file log entry" entry
           (file+olp+datetree buffer-file-name)
           "* %? \n")
          ("d" "Daybook" entry
           (file+olp+datetree ,(concat org-directory "daybook.org"))
           "* %?\n\n" :time-prompt t)
          ("n" "Take a note" plain
           (file+headline ,(concat org-directory "notes.org") "Notes")
           "%U\n%?" :empty-lines 1 :prepend t)))

  (setq org-attach-id-dir  "data/"))


(setq org-journal-dir "~/Dropbox/notes/journal"
    org-journal-file-type 'monthly
    org-journal-file-format "%Y-%m-%d.org"
    org-journal-find-file #'find-file
    org-journal-time-prefix ""
    org-journal-time-format ""
    org-journal-enable-agenda-integration nil
    org-journal-enable-encryption nil
    org-journal-date-format "%A, %B %d %Y")

(defun org-journal-file-header-func (time)
  "Custom function to create journal header."
  (concat
    (pcase org-journal-file-type
      (`daily "")
      (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
      (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
      (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))

(setq org-journal-file-header 'org-journal-file-header-func)

(add-hook 'org-journal-mode-hook 'turn-on-auto-fill)
(add-hook 'org-journal-mode-hook #'+zen/toggle)


;; LaTeX ---------------------------------------------------------------------

;; My default LaTeX class

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("scrartcl"
                 "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
             '("org-plain-latex"
               "\\documentclass{article}
           [NO-DEFAULT-PACKAGES]
           [PACKAGES]
           [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq org-latex-caption-above nil)
(setq org-latex-pdf-process
       (quote
          ("xelatex -interaction nonstopmode  %f" "xelatex -interaction nonstopmode %f")))

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
(setq TeX-source-correlate-method 'synctex)

;; /LaTeX --------------------------------------------------------------------

(add-hook 'markdown-mode-hook 'pandoc-mode)
(setq pandoc-data-dir "~/.pandoc/pandoc-mode/")

(setq yas-snippet-dirs
      '("~/Dropbox/emacs/yasnippets"))                 ;; personal snippets

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

(setq +zen-text-scale 0.8)  ;; Not quite so large, there Doom

(setq bookmark-default-file "~/Dropbox/emacs/bookmarks")

(setq deft-directory "~/Dropbox/notes/org-roam")

(defun jab/insert-weather ()
  "Use wttr to insert the current weather at point"
  (interactive)
  (let ((w (shell-command-to-string "curl -s 'wttr.in/49301?0q&format=%c+%C+%t' | head -n6")))
  (insert (mapconcat (function (lambda (x) (format ": %s" x)))
           (split-string w "\n")
           "\n"))))

(map!
 "\C-cl" 'org-store-link
 "\C-cc" 'org-capture
 "\C-cj" 'org-journal-new-entry)
