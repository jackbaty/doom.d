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
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Helvetica Neue" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-flatwhite)
(setq doom-theme 'modus-operandi)
;;(setq doom-theme 'doom-one)

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


(add-load-path! "~/Sync/emacs/lisp")
(add-load-path! "~/Sync/emacs/nano-emacs")
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 120))

(setq bookmark-default-file "~/Sync/emacs/bookmarks")

(setq yas-snippet-dirs
      '("~/Sync/emacs/yasnippets"))                 ;; personal snippets

(yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

;; looky-feely

(global-visual-line-mode)
(setq +zen-text-scale 0.8)  ;; Not quite so large, there Doom


(setq warning-suppress-types `(yasnippet backquote-change))


;;(require 'nano-faces)

(load! "orgmode")
(load! "orgroam")
(load! "latex")
(load! "mail")
(load! "mappings")
(load! "myfunctions")


;;(require 'nano-mu4e)

;;(add-hook 'markdown-mode-hook 'pandoc-mode)
;;(setq pandoc-data-dir "~/.pandoc/pandoc-mode/")
