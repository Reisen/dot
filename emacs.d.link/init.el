(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



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
    rust-mode))

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
  ; Set colours and fonts.
  (require 'color-theme-sanityinc-tomorrow)
  (require 'linum-relative)
  (color-theme-sanityinc-tomorrow-night)
  (set-default-font "Terminus 8")

  ; Disable/Enable gui elements.
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)

  ; Enable/Disable other visual settings
  (setq-default truncate-lines 1)
  (linum-mode 1)
)



; Miscellaneous Plugins
; ------------------------------------------------------------------------------
(progn
  (require 'multiple-cursors)
)



; Miscillaneous Settings
; ------------------------------------------------------------------------------
(progn
  (setq-default indent-tabs-mode nil)
)



; Language Specific Settings & Hooks
; ------------------------------------------------------------------------------
(progn
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
