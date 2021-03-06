;; Full screen toggle

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                         'fullboth)))

(global-set-key (kbd "M-n") 'toggle-fullscreen)
(global-set-key (kbd "C-z") 'yank)
(global-set-key (kbd "C-x C-o") 'other-frame)
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

;;My snippets

;; Develop and keep personal snippets under ~/.emacs.d/mysnippets
(setq yas/root-directory "~/emacs.d/mysnippets")
;; Load the snippets
(yas/load-directory yas/root-directory)
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
(add-to-list 'load-path (concat dotfiles-dir "vendor/rspec-mode"))
(require 'rspec-mode)
;; (require 'topfunky/applescript)
;; (require 'topfunky/org)
(require 'topfunky/textile)
(require 'topfunky/markdown)
(require 'topfunky/haml)                ;
;; (require 'topfunky/xcode)
(require 'topfunky/keyboard)

;; gist
(require 'gist)


;; javascript

(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

(server-start)
