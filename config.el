;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; My private Doom configuration

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
;;(setq doom-font (font-spec :family "IBM Plex Mono" :size 15)
(setq doom-font (font-spec :family "iosevka Comfy" :size 16)
      doom-variable-pitch-font (font-spec :family "ETBembo" :size 15))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-palenight)

(use-package! modus-themes
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-mixed-fonts t
        modus-themes-mode-line '(borderless)
        modus-themes-region '(bg-only no-extend)))

(setq modus-themes-completions '((t background intense accented)))


;;(setq doom-theme 'modus-operandi)
(setq doom-theme 'modus-vivendi)
;;(setq doom-theme 'doom-one)
;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


(setq gc-cons-threshold 100000000)
(setq confirm-kill-emacs nil) ;; When I say quit, you quit.

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

(add-load-path! "~/Sync/emacs/lisp")
;;(add-to-list 'load-path "~/Sync/emacs/lisp/denote")


(setq fancy-splash-image (concat doom-private-dir "splash.png"))



;;(setq initial-frame-alist '((top . 30) (left . 100) (width . 120) (height . 61)))
(setq initial-frame-alist '((width . 120) (height . 61)))
(add-to-list 'after-make-frame-functions #'jab/frame-center)

(setq bookmark-default-file "~/Sync/emacs/bookmarks")
(setq bookmark-set-fringe-mark nil)
(global-visual-line-mode)
(setq +zen-text-scale 0.8)  ;; Not quite so large, there Doom

(setq tab-bar-mode t)
(setq tab-bar-new-tab-choice "*scratch*") ;; new tabs open scratch buffer
(setq tab-bar-show t)

;; More clever completion
(use-package! orderless
  :custom (completion-styles '(orderless)))

;; Load my "modules"
(load! "lisp/orgmode")
;;(load! "lisp/orgroam")
(load! "lisp/latex")
(load! "lisp/mappings")
(load! "lisp/myfunctions")
(load! "lisp/blog")
(load! "lisp/notmuch")

;; My daily snippet evaluates a backquoted shell call. This stops it from warning me.
(setq warning-suppress-types '((yasnippet backquote-change)))






;; Denote
;;

(require 'denote)

;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Documents/notes/"))
(setq denote-known-keywords '("emacs" "photography" "software" "person"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type nil) ; Org is the default, set others here
(setq denote-prompts '(title keywords))

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
(add-hook 'find-file-hook #'denote-link-buttonize-buffer)

;; Hide file permissions by default
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq denote-dired-rename-expert nil)

;; We use different ways to specify a path for demo purposes.
(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Desktop/Beyond the Infinite")))

;; Generic (great if you rename files Denote-style in lots of places):
(add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
;;(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

;; Here is a custom, user-level command from one of the examples we
;; showed in this manual.  We define it here and add it to a key binding
;; below.
(defun my-denote-journal ()
  "Create an entry tagged 'journal', while prompting for a title."
  (interactive)
  (denote
   (denote--title-prompt)
   '("journal")))

(defun jab/search-denote ()
 "Run consult-ripgrep on the denote directory"
 (interactive)
 (consult-ripgrep denote-directory nil))

(defun jab/find-denote-file ()
 "Run consult-find on the denote directory"
 (interactive)
 (consult-find denote-directory nil))

;; Denote does not define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n j") #'my-denote-journal) ; our custom command
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n S") #'denote-subdirectory)
  (define-key map (kbd "C-c n s") #'jab/search-denote)
  (define-key map (kbd "C-c n f") #'jab/find-denote-file)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-link-add-links)
  (define-key map (kbd "C-c n l") #'denote-link-find-file) ; "list" links
  (define-key map (kbd "C-c n b") #'denote-link-backlinks)
  ;; Note that `denote-dired-rename-file' can work from any context, not
  ;; just Dired bufffers.  That is why we bind it here to the
  ;; `global-map'.
  (define-key map (kbd "C-c n r") #'denote-dired-rename-file))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))



;; Temporary?
(defun native-comp-available-p () nil)

