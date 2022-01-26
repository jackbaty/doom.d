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
(setq doom-font (font-spec :family "IBM Plex Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 15))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-palenight)
;;(setq doom-theme 'modus-operandi)
(setq doom-theme 'modus-vivendi)
;;(setq doom-theme 'doom-tomorrow-day)

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



(setq fancy-splash-image (concat doom-private-dir "splash.png"))

(use-package! modus-themes
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-intense-markup t
        modus-themes-mixed-fonts t
        modus-themes-region '(bg-only no-extend)))

(setq modus-themes-intense-markup t)

(add-load-path! "~/icloud-drive/emacs/lisp")

(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 150))

;;(setq bookmark-default-file "~/icloud-drive/emacs/bookmarks")

(global-visual-line-mode)
(setq +zen-text-scale 0.8)  ;; Not quite so large, there Doom

(setq tab-bar-show t)
(setq tab-bar-mode t)
(setq tab-bar-new-tab-choice "*scratch*") ;; new tabs open scratch buffer

(cua-mode 1) ;; familiar system copy/paste I hope

(use-package! orderless
  :custom (completion-styles '(orderless)))

(load! "orgmode")
(load! "orgroam")
(load! "latex")
(load! "mail")
(load! "mappings")
(load! "myfunctions")

;;(desktop-save-mode 1)

;; Temporary
(defun native-comp-available-p () nil)
