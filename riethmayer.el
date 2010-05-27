;; Full screen toggle
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                         'fullboth)))

(global-set-key (kbd "M-n") 'toggle-fullscreen)

;; Keyboard
;; Mac-friendly
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)
(global-unset-key (kbd "M-t"))
;; Other
(prefer-coding-system 'utf-8)

;; vendor stuff
(add-to-list 'load-path (concat dotfiles-dir "vendor"))

;; Snippets
(add-to-list 'load-path (concat dotfiles-dir "/vendor/yasnippet.el"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet.el/snippets"))

;; TextMate
(add-to-list 'load-path (concat dotfiles-dir "/vendor/textmate.el"))
(require 'textmate)
(textmate-mode)

;; Whitespaces
(require 'whitespace)

;; ruby-mode
(require 'topfunky/sinatra)
(add-to-list 'load-path (concat dotfiles-dir "/vendor/ruby-complexity"))
(require 'linum)
(require 'ruby-complexity)
(add-hook 'ruby-mode-hook
          (function (lambda ()
                      (flymake-mode)
                      (linum-mode)
                      (whitespace-mode)
                      (ruby-complexity-mode)
                      )))

;; Remove scrollbars and make hippie expand
;; work nicely with yasnippet
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(require 'hippie-exp)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        ;;         try-expand-dabbrev-from-kill
        ;;         try-complete-file-name
        ;;         try-complete-file-name-partially
        ;;         try-complete-lisp-symbol
        ;;         try-complete-lisp-symbol-partially
        ;;         try-expand-line
        ;;         try-expand-line-all-buffers
        ;;         try-expand-list
        ;;         try-expand-list-all-buffers
        ;;         try-expand-whole-kill
        ))
 
(defun indent-or-complete ()
  (interactive)
  (if (and (looking-at "$") (not (looking-back "^\\s-*")))
      (hippie-expand nil)
    (indent-for-tab-command)))
(add-hook 'find-file-hooks (function (lambda ()
                                       (local-set-key (kbd "TAB") 'indent-or-complete))))

;; dabbrev-case-fold-search for case-sensitive search

(require 'topfunky/rinari)
(add-to-list 'load-path (concat dotfiles-dir "/vendor/rspec-mode"))
(require 'rspec-mode)
;; (require 'topfunky/applescript)
;; (require 'topfunky/org)
(require 'topfunky/textile)
(require 'topfunky/markdown)
(require 'topfunky/haml)
;; (require 'topfunky/xcode)
(require 'topfunky/keyboard)

;; gist
(require 'gist)
;; javascript

(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))


;; Color Themes
;; (add-to-list 'load-path (concat dotfiles-dir "vendor/color-theme"))
;; (require 'color-theme)
;; (color-theme-initialize)

;; Activate theme
;; (load (concat dotfiles-dir user-login-name "/color-theme-twilight.el"))
;; ;; Normal is 30pt. Screencastable is 26pt.
;; (set-face-font 'default "-apple-inconsolata-medium-r-normal--16-0-72-72-m-0-iso10646-1")
;; (color-theme-twilight)

;; (load (concat dotfiles-dir user-login-name "/rvm.el"))
;; ;; 'load-path (concat dotfiles-dir "vendor/rvm.el"))
;; (setenv "LUA_PATH" "?.lua;/Users/riethmayer/Projects/uni/oose10/code/util/?.lua")
;; (require 'rvm)
;; (rvm-use-default)
(server-start)