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
      doom-variable-pitch-font (font-spec :family "iA Writer Quattro V" :size 16))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-palenight)

(setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-mixed-fonts t
        modus-themes-mode-line '(borderless)
        modus-themes-region '(bg-only no-extend))

(setq modus-themes-completions 'opinionated)
;;(setq modus-themes-completions '((t background intense accented)))


;;(setq doom-theme 'modus-operandi)
(setq doom-theme 'modus-vivendi)
;;(setq doom-theme 'doom-one)

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
(add-to-list 'load-path "~/Sync/emacs/lisp/denote")


(setq initial-frame-alist '((width . 120) (height . 61)))
(add-to-list 'after-make-frame-functions #'jab/frame-center)

(setq bookmark-default-file "~/Sync/emacs/bookmarks")
(setq bookmark-set-fringe-mark nil)
(global-visual-line-mode)
;;(setq +zen-text-scale 0.5)  ;; Not quite so large, there Doom
;;(add-hook 'writeroom-mode-hook (lambda () (setq line-spacing 0.4)))
(add-hook 'olivetti-mode-on-hook (lambda () (setq line-spacing 0.4)))
;;(add-hook 'olivetti-mode-on-hook (lambda () (olivetti-set-width 100)))
(setq markdown-hide-urls t) ; prettier URL display
(map! :leader "t z" #'olivetti-mode) ; Muscle memory from Doom's zen mode



(setq tab-bar-mode t)
(setq tab-bar-new-tab-choice "*scratch*") ;; new tabs open scratch buffer
(setq tab-bar-show t)


;; Some clever completion
(use-package! orderless
  :custom (completion-styles '(orderless)))

;; Load my "modules"
(load! "lisp/orgmode")
(load! "lisp/denote")
;;(load! "lisp/orgroam")
(load! "lisp/latex")
(load! "lisp/mappings")
(load! "lisp/myfunctions")
;;(load! "lisp/blog")
(load! "lisp/notmuch")

;; Load after denote and org-roam
(setq consult-notes-sources
      `(("Denote"      ?d ,denote-directory)
        ("Roam"        ?r "~/org/kb")))


;; My daily snippet evaluates a backquoted shell call. This stops it from warning me.
(setq warning-suppress-types '((yasnippet backquote-change)))

;; Temporary?
(defun native-comp-available-p () nil)

