;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; My private Doom configuration

(setq user-full-name "Jack Baty"
      user-mail-address "jack@baty.net")
(add-load-path! "~/Sync/emacs/lisp")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-font (font-spec :family "Calling Code" :size 15)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 15))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; See below for NANO theme
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'modus-operandi)
(setq doom-theme 'modus-vivendi)

(setq leuven-scale-outline-headlines 1.10)
(setq leuven-scale-org-agenda-structure 1.10)

(setq modus-themes-completions '((t background intense accented)))
(setq modus-operandi-theme-variable-pitch-headings t
      modus-operandi-theme-slanted-constructs t
      modus-operandi-theme-bold-constructs t
      modus-operandi-theme-fringes 'nil ; {nil,'subtle,'intense}
      modus-themes-fringes 'nil ; {nil,'subtle,'intense}
      modus-operandi-theme-3d-modeline t
      modus-operandi-theme-faint-syntax t
      modus-operandi-theme-intense-hl-line t
      modus-operandi-theme-intense-paren-match t
      modus-operandi-theme-prompts 'subtle ; {nil,'subtle,'intense}
      modus-operandi-theme-completions 'moderate ; {nil,'moderate,'opinionated}
      modus-operandi-theme-subtle-diffs t
      modus-operandi-theme-org-blocks 'greyscale ; {nil,'greyscale,'rainbow}
      modus-operandi-theme-rainbow-headings t
      modus-operandi-theme-section-headings nil
      modus-operandi-theme-scale-headings nil)

;; (use-package! doom-nano-modeline
;;   :config
;;   (doom-nano-modeline-mode 1)
;;   (global-hide-mode-line-mode nil))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; **** HERE WE GO ***

;; Add frame borders and window dividers
;; (modify-all-frames-parameters
;;  '((right-divider-width . 20)
;;    (internal-border-width . 20)))
;; (dolist (face '(window-divider
;;                 window-divider-first-pixel
;;                 window-divider-last-pixel))
;;   (face-spec-reset-face face)
;;   (set-face-foreground face (face-attribute 'default :background)))
;; (set-face-background 'fringe (face-attribute 'default :background))

(setq initial-frame-alist '((width . 100) (height . 55)))
(setq default-frame-alist '((width . 100) (height . 55)))
(add-to-list 'after-make-frame-functions #'jab/frame-center)

(setq bookmark-default-file (concat doom-user-dir "bookmarks"))
(setq bookmark-set-fringe-mark nil)
(global-visual-line-mode)
(setq +zen-text-scale 0.3)  ;; Not quite so large, there Doom
;;(add-hook 'writeroom-mode-hook (lambda () (setq line-spacing 0.4)))
;;(add-hook 'olivetti-mode-on-hook (lambda () (setq line-spacing 0.4)))
;;(add-hook 'olivetti-mode-on-hook (lambda () (olivetti-set-width 100)))
(setq markdown-hide-urls nil) ; Hidden URLs are too hard to edit
;;(map! :leader "t z" #'olivetti-mode) ; Muscle memory from Doom's zen mode
;;




(after! writeroom-mode
  (setq writeroom-mode-line t))

(setq tab-bar-mode t)
(setq tab-bar-new-tab-choice "*scratch*") ;; new tabs open scratch buffer
(setq tab-bar-show t)


;; Some clever completion
(use-package! orderless
  :custom (completion-styles '(orderless)))


;; For markdown->html exports
(setq markdown-css-paths '("https://static.baty.net/cdn/simple.min.css"))

;; My daily snippet evaluates a backquoted shell call. This stops it from warning me.
(setq warning-suppress-types '((yasnippet backquote-change)))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(setq global-flycheck-mode nil)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

(setq emojify-emoji-styles '(unicode github))

(add-hook 'markdown-mode-hook (lambda() (company-mode 0)))


;; Configure Tempel
(use-package tempel
  ;; Require trigger prefix before template name when completing.
  ;;:custom
  ;;(tempel-trigger-prefix "<")

  :bind (("M-TAB" . tempel-expand) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))

  :init

  ;; Setup completion at point
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)
  (add-hook 'org-mode-hook 'tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  (global-tempel-abbrev-mode)
  (setq tempel-path "~/.config/emacs/my-templates")
)

(setq tempel-path (concat doom-user-dir "tempel"))
(map! :leader :desc "Insert tempel template" "i s" #'tempel-insert)



;; Load my "modules"
(load! "lisp/orgmode")
(load! "lisp/latex")
(load! "lisp/mappings")
(load! "lisp/myfunctions")
(load! "lisp/mu4e")
;;(load! "lisp/notmuch")
(load! "lisp/elfeed")
;;(load! "lisp/crm")
(load! "lisp/denote")
