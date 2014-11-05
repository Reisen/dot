; Initialize the package manager interface.
; ------------------------------------------------------------------------------
(progn
  ; These are the package sources that packages are installed from.
  (setq package-archives '(
    ("mepla" . "http://melpa.milkbox.net/packages/")
    ("org"   . "http://orgmode.org/elpa/")
    ("gnu"   . "http://elpa.gnu.org/packages/")))

  (require 'package)
  (package-initialize)

  ; This is the list of packages I'm using. If you want to add more
  ; packages add them here. They will automatically be installed on
  ; run.
  (setq my-packages '(
    linum-relative
    color-theme-sanityinc-tomorrow
    multiple-cursors
    color-theme
    evil
    rust-mode
    magit
    yasnippet
    smartparens
    company
    move-text
    helm
    neotree
    git-gutter
    lua-mode
    haskell-mode
    flycheck))

  (unless package-archive-contents
    (package-refresh-contents))

  ; Perform installing of missing packages.
  (dolist (package my-packages)
    (unless (package-installed-p package)
      (package-install package))))




; Sort out theme related options. Includes syntax themes, UI options
; and things such as fonts.
; ------------------------------------------------------------------------------
(progn
  ; Load custom themes.
  (add-to-list
    'custom-theme-load-path
    "~/.emacs.d/themes")

  ; Set theme and Font
  (set-default-font "Terminus 8")
  (require 'color-theme-sanityinc-tomorrow)
  (if (display-graphic-p)
    (load-theme 'jazz t)
    (color-theme-sanityinc-tomorrow-night))


  ; Disable/Enable gui elements.
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (setq-default right-fringe-width 0)

  ; Enable/Disable other visual settings
  (setq-default truncate-lines 1)
  (require 'linum-relative)
  (global-linum-mode 1)
)



; Miscellaneous Plugins/Settings
; ------------------------------------------------------------------------------
(progn
  ; Require Plugins
  (require 'multiple-cursors)
  (require 'yasnippet)
  (require 'smartparens-config)
  (require 'move-text)
  (require 'color)
  (require 'ido)
  (require 'neotree)

  ; Enable/Configure Plugins
  (move-text-default-bindings)
  (smartparens-global-mode 1)
  (yas-global-mode 1)
  (setq-default company-idle-delay 0)
  (setq-default linum-relative-format "%3s ")
  (ido-mode t)

  ; Rebind YAS completion key.
  (define-key
    yas-minor-mode-map
    (kbd "<tab>")
    nil)
  (define-key
    yas-minor-mode-map
    (kbd "TAB")
    nil)
  (define-key
    yas-minor-mode-map
    (kbd "C-j")
    'yas-expand)

  ; Configure Company Mode Completion Colours
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(mode-line ((t (
       :inherit default
       :background "#111111"))))

     ;`(linum ((t (
     ;  :inherit default
     ;  :background "#191919"))))

     ;`(fringe ((t (
     ;  :inherit default
     ;  :background "#191919"))))

     `(vertical-border ((t (
       :inherit default
       :background "#111111"
       :foreground "#111111"))))

     `(mode-line-inactive ((t (
       :inherit default
       :foreground "#555555"
       :background "#111111"))))

     `(company-tooltip ((t (
       :inherit default
       :background ,(color-lighten-name bg -3)))))

     `(company-scrollbar-bg ((t (
       :background ,(color-lighten-name bg -5)))))

     `(company-scrollbar-fg ((t (
       :background ,(color-lighten-name bg 5)))))

     `(company-tooltip-selection ((t (
       :inherit default
       :background "#111111"))))

     `(company-tooltip-common-selection ((t (
       :inherit default
       :background "#111111"
       :foreground "#336699"))))

     `(company-preview-common ((t (
       :inherit default
       :background "#111111"
       :foreground "#336699"))))

     `(company-tooltip-common ((t (
       :inherit default
       :foreground "#336699"
       :background ,(color-lighten-name bg -3)))))))
)



; Miscillaneous Settings
; ------------------------------------------------------------------------------
(progn
  ; Tabbing Settings for All Languages
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
)



; Language Specific Settings & Hooks
; ------------------------------------------------------------------------------
; Create a new mode map for rust, because rust-mode sucks and doesn't
; even define a mode-map to work with.
(unless (boundp 'rust-mode-map)
  (defvar rust-mode-map (make-sparse-keymap)))

; Language Mode hooks for language specific settings.
(progn
  ; Rust Mode
  (add-hook 'rust-mode-hook (lambda ()
    (use-local-map rust-mode-map)
    (define-key
      rust-mode-map
      "\C-i"
      'self-insert-command)))

  ; C/C++ Mode


  (defun my-c-lineup-inclass (langelem)
    (let ((inclass (assoc 'inclass c-syntactic-context)))
      (save-excursion
        (goto-char (c-langelem-pos inclass))
        (if
          (or
            (looking-at "struct")
            (looking-at "typedef struct"))
          '+
          '++))))

  (add-hook 'c-mode-common-hook (lambda ()
    (c-set-style "stroustrap")
    (c-set-offset 'case-label 4)
    (c-set-offset 'access-label '-)
    (c-set-offset 'inclass 'my-c-lineup-inclass)
    (c-set-offset 'substatement-open 0)))
)



; Initialize and config evil, we do this last because it needs other plugins to
; be loaded to properly overlay the right keybindings.
; ------------------------------------------------------------------------------
(progn
  (require 'evil)
  (evil-mode 1)
  (setq-default evil-auto-indent 1)
  (define-key
    evil-insert-state-map
    (kbd "<RET>")
    'evil-ret-and-indent)
)
