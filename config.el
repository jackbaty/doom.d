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
(setq doom-font (font-spec :family "Iosevka Comfy" :size 16)
      doom-variable-pitch-font (font-spec :family "iA Writer Quattro V" :size 16))


(add-load-path! "~/Sync/emacs/lisp")
(add-to-list 'load-path "~/Sync/emacs/lisp/denote")
(add-to-list 'load-path "~/Sync/emacs/lisp/standard-themes")
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-palenight)

;; Make customisations that affect Emacs faces BEFORE loading a theme
;; (any change needs a theme re-load to take effect).
(require 'standard-themes)

;; THEME CONFIG
;; Read the doc string of each of those user options.  These are some
;; sample values.
(setq standard-themes-bold-constructs t
      standard-themes-italic-constructs t
      standard-themes-mixed-fonts t
      standard-themes-variable-pitch-ui t
      standard-themes-mode-line-accented t

      ;; Accepts a symbol value:
      standard-themes-fringes 'subtle

      ;; The following accept lists of properties
      standard-themes-links '(neutral-underline)
      standard-themes-region '(no-extend neutral intense)
      standard-themes-prompts '(bold italic)

      ;; more complex alist to set weight, height, and optional
      ;; `variable-pitch' per heading level (t is for any level not
      ;; specified):
      standard-themes-headings
      '((0 . (variable-pitch light 1.2))
        (1 . (variable-pitch light 1.2))
        (2 . (variable-pitch light 1.2))
        (3 . (variable-pitch semilight 1.1))
        (4 . (variable-pitch semilight 1.1))
        (5 . (variable-pitch 1.1))
        (6 . (variable-pitch 1.1))
        (7 . (variable-pitch 1.1))
        (t . (variable-pitch 1.0))))

;; Disable all other themes to avoid awkward blending:
(mapc #'disable-theme custom-enabled-themes)

(load-theme 'standard-light :no-confirm)

(define-key global-map (kbd "<f5>") #'standard-themes-toggle)
;; /THEME CONFIG



(setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-mixed-fonts t
        modus-themes-mode-line '(borderless)
        modus-themes-region '(bg-only no-extend))

(setq modus-themes-completions 'opinionated)
;;(setq modus-themes-completions '((t background intense accented)))


;;(setq doom-theme 'modus-operandi)
;;(setq doom-theme 'modus-vivendi)
;;(setq doom-theme 'ef-frost)
(setq doom-theme 'standard-light)




;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/"
      org-attach-id-dir "files/")

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



(setq initial-frame-alist '((width . 200) (height . 61)))
(setq default-frame-alist '((width . 150) (height . 55)))
(add-to-list 'after-make-frame-functions #'jab/frame-center)

(setq bookmark-default-file "~/Sync/emacs/bookmarks")
(setq bookmark-set-fringe-mark nil)
(global-visual-line-mode)
(setq +zen-text-scale 0.3)  ;; Not quite so large, there Doom
;;(add-hook 'writeroom-mode-hook (lambda () (setq line-spacing 0.4)))
;;(add-hook 'olivetti-mode-on-hook (lambda () (setq line-spacing 0.4)))
;;(add-hook 'olivetti-mode-on-hook (lambda () (olivetti-set-width 100)))
(setq markdown-hide-urls t) ; prettier URL display
;;(map! :leader "t z" #'olivetti-mode) ; Muscle memory from Doom's zen mode


(after! writeroom-mode
  (setq writeroom-mode-line t))

(setq tab-bar-mode t)
(setq tab-bar-new-tab-choice "*scratch*") ;; new tabs open scratch buffer
(setq tab-bar-show t)


;; Some clever completion
(use-package! orderless
  :custom (completion-styles '(orderless)))

;; Fixes org-roam backlinks display but breaks folding in org-cycle
;;(setq org-fold-core-style "overlays")

;; Load my "modules"
(load! "lisp/orgmode")
(load! "lisp/denote")
;;(load! "lisp/orgroam")
(load! "lisp/latex")
(load! "lisp/mappings")
(load! "lisp/myfunctions")
(load! "lisp/mu4e")

;; For markdown->html exports
(setq markdown-css-paths '("https://static.baty.net/cdn/simple.min.css"))

;; My daily snippet evaluates a backquoted shell call. This stops it from warning me.
(setq warning-suppress-types '((yasnippet backquote-change)))

(setq mastodon-instance-url "https://fosstodon.org"
         mastodon-active-user "jackbaty")
;; Temporary?
(defun native-comp-available-p () nil)


