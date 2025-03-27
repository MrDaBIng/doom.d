;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(after! org-capture
  (setq! org-capture-templates
         '(("i" "Inbox Todo" entry (file+headline "~/workspace/ORG/GTD/inbox.org" "Inbox")
            "*  %?\n  %i\n  %a")
           ("p" "Projects")
           ("pe" "Eventbus Todo" entry (file+headline "~/workspace/ORG/GTD/eventbus.org" "Inbox")
            "*  %?\n  %i\n  %a")
           ("ps" "SiteBuild Todo" entry (file+headline "~/workspace/ORG/GTD/site-build.org" "Inbox")
            "*  %?\n  %i\n  %a")
           ("pv" "vdc Todo" entry (file+headline "~/workspace/ORG/GTD/vdc.org" "Inbox")
            "*  %?\n  %i\n  %a"))))
;; org-roam
(setq org-roam-directory (file-truename "~/workspace/ORG/")
      org-roam-dailies-directory "Journal/roam")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y/%m/%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
(setq! org-journal-dir "Journal/")
(setq! org-journal-file-format "%Y/%m/%Y-%m-%d.org")
;;---------------------------------------------
;;org-agenda
;;--------------------------------------------
(after! org-agenda
  (setq org-agenda-files '("~/workspace/ORG/GTD/")
        org-agenda-include-diary t
        org-agenda-use-time-grid t
        org-agenda-todo-keyword-format "%-6s"
        org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈ Now"
        org-todo-keywords
        '((sequence
           "TODO(t)"                    ;What needs to be done
           "NEXT(n)"                    ;A project without NEXTs is stuck
           "|"
           "DONE(d)")
          (sequence
           "REPEAT(e)"                    ;Repeating tasks
           "|"
           "DONE"))
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("NEXT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("REVIEW" . +org-todo-onhold)
          ("HOLD" . +org-todo-cancel)
          ("PROJ" . +org-todo-project)
          ("DONE"   . +org-todo-cancel)
          ("STOP" . +org-todo-cancel))
        org-agenda-time-grid (quote ((daily today require-timed)
                                     (300
                                      600
                                      900
                                      1200
                                      1500
                                      1800
                                      2100
                                      2400)
                                     "      "
                                     "-----------------------------------------------------"
                                     )))
  (setq org-super-agenda-groups
        '(
                                        ;(:name "Life" :tag "life" :time-grid t)
                                        ;(:name "Work" :tag "work")
          (:name "--------------------------------------------------\n 📥 INBOX" :and (:category "inbox") :order 99)
          (:name "Due today" :deadline today :order 1 :face (:foreground "red" :background "black"))
          (:name "Due soon" :deadline future :order 2 :face (:foreground "red"))
          (:name "Today" :scheduled t :order 3 :face (:foreground "yellow"))
          (:name "Started" :todo "STARTED" :order 4)
          (:name "Current sprint" :and (:tag "sprint" :tag "current") :order 5)
          (:name "Retro topics" :and (:todo "TODO" :tag "retro"))
          (:name "Other" :anything t :order 50)
          ))
  (org-super-agenda-mode))
;; 定义一个函数，用于检测当前是否是 org-todo-list
;; (defun my/org-super-agenda-enable-for-todo-list ()
;;   "Enable org-super-agenda-mode only in org-todo-list."
;;   (when (eq org-agenda-type 'todo)  ; 检测是否是 org-todo-list
;;     (org-super-agenda-mode)))     ; 启用 org-super-agenda-mode
;; (add-hook 'org-agenda-mode-hook #'my/org-super-agenda-enable-for-todo-list)

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq
   ;; Edit settings
   org-foldcatch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t
   ;; Appearance
   org-modern-radio-target    '("❰" t "❱")
   org-modern-internal-target '("↪ " t "")
   org-modern-todo t
   org-modern-tag t
   org-modern-timestamp t
   org-modern-statistics nil
   org-modern-progress t
   org-modern-priority nil
   org-modern-horizontal-rule "──────────"
   org-modern-hide-stars "·"
   org-modern-star ["⁖"]
   org-modern-keyword "‣"
   org-modern-list '((43 . "•")
                     (45 . "–")
                     (42 . "↪")))
  (custom-set-faces!
    `((org-modern-tag)
      :background ,(doom-blend (doom-color 'blue) (doom-color 'bg) 0.1)
      :foreground ,(doom-color 'grey))
    `((org-modern-radio-target org-modern-internal-target)
      :inherit 'default :foreground ,(doom-color 'blue)))
  )

;; (use-package! org-super-agenda
;;   :after org
;;   :init
;;   (let ((org-super-agenda-groups
;;          '((:log t)  ; Automatically named "Log"
;;            (:name "Schedule"
;;             :time-grid t)
;;            (:name "Work"
;;             :tag "work")
;;            (:name "Life"
;;             :tag "life"))))
;;     (org-agenda nil "a"))
;;   :config
;;   (org-super-agenda-mode t))

;; (setq! super-agenda-commonds
;;        '(("u" "Super view"
;;           ((agenda "" ((org-super-agenda-groups
;;                         '((:name "Today"
;;                            :time-grid t)))))
;;            (todo "" ((org-agenda-overriding-header "Projects")
;;                      (org-super-agenda-groups
;;                       '((:name none  ; Disable super group header
;;                          :children todo)
;;                         (:discard (:anything t))))))))))


;; (setq org-roam-directory (file-truename "~/Documents/orgfiles/org-roam"))
;; --- org-modern , pretty org ---
(setq org-modern-label-border nil)
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
;;   this file. Emacs searches the `load-path' when you loa d packages with
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

(setq initial-frame-alist '((top . 1) (left . 1) (width . 143) (height . 55)))


;; ------ keymap -----
(map! :n :desc "go-impl" :n "SPC c I" #'go-impl)

;;ace-window keymap
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(map! :g :desc "select a window" :g "M-o" #'ace-window)

;; treemacs keymap enhance
(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map (kbd "o-") 'treemacs-visit-node-ace-vertical-split)
  (define-key treemacs-mode-map (kbd "o\\") 'treemacs-visit-node-ace-horizontal-split))
;; (define-key treemacs-node-visit-map (kbd "") 'treemacs-visit-node-vertical-split)

(setq centaur-tabs-mode t)
;; (define-key global-map (kbd "C-x t") nil) ;;disable default tabs
(setq centaur-tabs-enable-key-bindings t)

(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))
