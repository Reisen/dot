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
    git-gutter))

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
    (load-theme 'jazz)
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
  (setq-default indent-tabs-mode nil)
)



; Language Specific Settings & Hooks
; ------------------------------------------------------------------------------
; This function implements a very dumb indent mode for C-like languages, I know
; it goes against the 'emacs way' but I edit a lot of rust, and the rust-mode
; extension is really broken. This works fine.
(defun dumb-mode-indent ()
  (indent-line-to
    (save-excursion
      ; Check the previous line to decide how to indent.
      (previous-line)
      (end-of-line)

      ; If the previous line isn't empty, we're good to go. This check makes
      ; sure that pressing left doesn't move back an extra line and do weird
      ; indentation.
      (if (not (= (current-column) 0))
        (progn

          ; Move back so we can inspect what character we are looking at.
          (backward-char)
          (cond

            ; Check for characters that mean we indent a new level.
            ((or
              (looking-at "{")
              (looking-at "(")
              (looking-at "\\["))
                (back-to-indentation)
                (+ (current-column) 4))

            ; Unindent for functions.
            ((looking-at "}")
              (back-to-indentation)
              (indent-line-to (- (current-column) 4))
              (current-column))

            ; Unindent for arrays and tuples.
            (t
              (beginning-of-line-text)
              (cond
                ((or
                  (looking-at ");")
                  (looking-at "];"))
                    (back-to-indentation)
                    (indent-line-to (- (current-column) 4))
                    (current-column))
                (t
                  (current-column))))))

        ; But if the line IS empty, we still need to maintain indent level,
        ; so we keep scanning back until we find a non-empty line and copy
        ; that lines indent level.
        (progn
          (while
            (=
              (length (buffer-substring-no-properties
                (line-beginning-position)
                (line-end-position)))
              0)
            (previous-line))
          (back-to-indentation)
          (current-column))))))

; Create a new mode map for rust, because rust-mode sucks and doesn't
; even define a mode-map to work with.
(unless (boundp 'rust-mode-map)
  (defvar rust-mode-map (make-sparse-keymap)))

; Language Mode hooks for language specific settings.
(progn
  ; Hook the loading of rust-mode in a buffer so we can override It's
  ; absolutely retarded settings with our own map and values.
  (add-hook 'rust-mode-hook (lambda ()
    (setq tab-width 4)
    (setq indent-line-function 'dumb-mode-indent)))
    (use-local-map rust-mode-map)
    (define-key
      rust-mode-map
      "\C-i"
      'self-insert-command)
      
  ; Hook the C++ mode so we can configure that to be a little less
  ; horrible as well.
  (add-hook 'c-mode-common-hook (lambda ()
    (c-set-offset 'case-label 4)
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#080808" "#953331" "#546a29" "#909737" "#385e6b" "#7f355e" "#34676f" "#c6a57b"])
 '(custom-safe-themes (quote ("6edc1aed8d373bd95d3771fa0331263e24cafd907e169ff0fbeb4b1f3eb2bf6d" "fc1ac6fa119b8eb9a893431ddd60ee8cdc0f39ff0c338ebf44e653e80bc61770" "e79733c55be4e163078b39550d2b17fd1fe37de4f931e2ebe407cda6a4fd05d2" "7748d2dae8e08d83780e2015e103944d24d5405b8784419f08cd6cd05f43c04f" "b3ab37a5c6c96d3b7db33f16cf3deeb1766afa8d62eca73de3ea60413a5ffad1" "c1a38c723be80ba66c4be9fe791977d0862f7740e88dc6f883e655db2dba409b" default)))
 '(fci-rule-color "#080808"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview-common ((t (:inherit default :background "#111111" :foreground "#336699"))) t)
 '(company-scrollbar-bg ((t (:background "#000000"))) t)
 '(company-scrollbar-fg ((t (:background "#141414"))) t)
 '(company-tooltip ((t (:inherit default :background "#000000"))) t)
 '(company-tooltip-common ((t (:inherit default :foreground "#336699" :background "#000000"))) t)
 '(company-tooltip-common-selection ((t (:inherit default :background "#111111" :foreground "#336699"))) t)
 '(company-tooltip-selection ((t (:inherit default :background "#111111"))) t)
 '(mode-line ((t (:inherit default :background "#111111"))))
 '(mode-line-inactive ((t (:inherit default :foreground "#555555" :background "#111111"))))
 '(vertical-border ((t (:inherit default :background "#111111" :foreground "#111111")))))
