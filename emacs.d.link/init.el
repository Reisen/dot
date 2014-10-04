(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("d6f302ffaf35a05fb64bd31da0cb91dfe625beaa5981bfc76f7cb69b87d15507" "5ab8f213f420aad076b4ebb70461814d5d4e6f2fbcca4768cfc05e5cc97940db" "524239dc59fd3b5923db2be6294943c930bbae053fc24f28e09319ad9ce8cfb8" "478f053960addd1bfc2697af4f6c05b79e6a4d17d4d2c25eab83a8b4b52a7d71" "925a7ec6725e7b5872b0c0b6dcd6bf97ea1b842f821a79d25835f5c9a3babee5" "761d44dc06b3c8fff771435fd771b170d1bbdd71348b6aaaa6c0d0270d56cb70" "a02a91280d196aac69d07102845f2d92271e890bfdd116690f199f24a7e02cec" "134f38000f413a88743764983c751ac34edbec75a602065e2ae3b87fcf26c451" "82db24153a4b92df8d7d75abc3bd69d72915d3cfb3d4311fb4c4f87f439f066b" "51ddcedbb049d8d3e3ff83bd3bf786ddf8d1572c4ba2b5c2b0e8ebdb82417c62" "668fb336b7ebbbb2ac2d5cc8d873b8988865fb8846415458b30c4171a3f73b98" "24a0de2422359c267b3e8cf923470181bbb1ac093a6e1e5986627133dae7e288" "e663aed6d8f5f81e087f22b0bb2e7cba9b86ea0a42ae1b50de2b73f4fb95b240" "86f4baa7d20edf1c232a1ecd44983146f20d0d7b501e0794942f9445a2900794" "6db14027489b24c31efa1aba587f07d7534fe7a1c3df3d8a5b85159fbc18e635" "cd36d4636e24fbc14960a340a094d5ca71536083a4125658d134501d754bbec1" "533976fbc9e95aadb82a4254e5ff187aadfe1cf426313419d0bb704ec12d05b9" "7bf64a1839bf4dbc61395bd034c21204f652185d17084761a648251041b70233" "be8e1a940b5a142d486fe4dd17ac74270dfef17b57421c48835f2f746ecc639a" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fringe-mode 6 nil (fringe))
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview-common ((t (:inherit default :background "#111111" :foreground "#336699"))) t)
 '(company-scrollbar-bg ((t (:background "#000000"))) t)
 '(company-scrollbar-fg ((t (:background "#0c0c0c"))) t)
 '(company-tooltip ((t (:inherit default :background "#000000"))) t)
 '(company-tooltip-common ((t (:inherit default :foreground "#336699" :background "#000000"))) t)
 '(company-tooltip-common-selection ((t (:inherit default :background "#111111" :foreground "#336699"))) t)
 '(company-tooltip-selection ((t (:inherit default :background "#111111"))) t)
 '(fringe ((t (:inherit default :background "#191919"))))
 '(linum ((t (:inherit default :background "#191919"))))
 '(mode-line ((t (:inherit default :background "#111111"))))
 '(mode-line-inactive ((t (:inherit default :foreground "#555555" :background "#111111"))))
 '(vertical-border ((t (:inherit default :background "#111111" :foreground "#111111")))))



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
    neotree))

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

     `(linum ((t (
       :inherit default
       :background "#191919"))))

     `(fringe ((t (
       :inherit default
       :background "#191919"))))

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

; Hook the loading of rust-mode in a buffer so we can override It's
; absolutely retarded settings with our own map and values.
(progn
  (add-hook 'rust-mode-hook (lambda ()
    (setq tab-width 4)
    (setq indent-line-function 'dumb-mode-indent)))
    (use-local-map rust-mode-map)
    (define-key
      rust-mode-map
      "\C-i"
      'self-insert-command)
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
