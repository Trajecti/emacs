;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parenthese when cursor is on one
(show-paren-mode t)

;; Highlight tabulations
(setq-default highlight-tabs t)

;; Show trailing white spaces
;(setq-default show-trailing-whitespace t)

;; Remove useless whitespaces before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Remove all backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Add package sources
(setq package-archives '(;("gnu" . "http://elpa.gnu.org/packages/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Set up el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; Set up the package manager of choice. Supports "el-get" and "package.el"
(setq pmoc "el-get")

;; List of all wanted packages
(setq
 wanted-packages
 '(
   color-theme
   autopair
   buffer-move
   ido-hacks
   ido-vertical-mode
   cider
   undo-tree
   solarized-emacs
   evil
   company-mode
   rainbow-delimiters
   clj-refactor
   smooth-scroll
   ;auto-complete
   ;ac-cider-compliment
   ;ac-anything
   ;ac-nrepl
   ))

;; Package manager and packages handler
(defun install-wanted-packages ()
  "Install wanted packages according to a specific package manager"
  (interactive)
  (cond
   ;; package.el
   ((string= pmoc "package.el")
    (require 'package)
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
    (add-to-list 'package-archives '("marmelade" . "http://marmalade-repo.org/packages/"))
    (package-initialize)
    (let ((need-refresh nil))
      (mapc (lambda (package-name)
	  (unless (package-installed-p package-name)
	(set 'need-refresh t))) wanted-packages)
      (if need-refresh
	(package-refresh-contents)))
    (mapc (lambda (package-name)
	(unless (package-installed-p package-name)
	  (package-install package-name))) wanted-packages)
    )
   ;; el-get
   ((string= pmoc "el-get")
    (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
    (unless (require 'el-get nil 'noerror)
      (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
    (el-get 'sync wanted-packages))
   ;; fallback
   (t (error "Unsupported package manager")))
  )

;; Install wanted packages
(install-wanted-packages)

;; UI elements
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Remove whitespace at end of file
;(setq-default show-trailing-whitespace t)
(setq-default highlight-tabs t)
(setq require-final-newline t)
(setq next-line-add-newlines nil)
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Load essential modes
(show-paren-mode t)
(global-font-lock-mode t)
(transient-mark-mode t)
(line-number-mode t)
(column-number-mode t)

;; Windmove
(global-set-key (kbd "<S-up>")     'windmove-up)
(global-set-key (kbd "<S-down>")   'windmove-down)
(global-set-key (kbd "<S-left>")   'windmove-left)
(global-set-key (kbd "<S-right>")  'windmove-right)


;; Move buffers
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; ido
(ido-mode 1)
(ido-vertical-mode 1)

(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
    (call-interactively
	(intern
	 (ido-completing-read
	  "M-x "
	  (all-completions "" obarray 'commandp))))))

;; Theme
(load-theme 'solarized-dark t)

;; Autopair
(autopair-global-mode)

;; undo tree
(global-undo-tree-mode)

;; Evil mode
;(evil-mode 1)

;; Font
;(set-default-font "droid sans mono 11")

;; Company mode
(global-company-mode)

(global-set-key (kbd "C-SPC") 'company-complete)

;; Fruity-tootie variablooby
(global-color-identifiers-mode)

;; (require 'ac-cider)
;;  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;;  (add-hook 'cider-mode-hook 'ac-cider-setup)
;;  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;;  (eval-after-load "auto-complete"
;;    '(add-to-list 'ac-modes 'cider-mode))

;; (defun set-auto-complete-as-completion-at-point-function ()
;; (setq completion-at-point-functions '(auto-complete)))

;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; Line number mode
(global-linum-mode t)

;; Rainbow delimeters
(rainbow-delimiters-mode 1)

;; Semantic mode
(semantic-mode 1)

;; Smooth scrolling
(setq smooth-scroll-margin 5)
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)


;; Enter indents lines now
(define-key global-map (kbd "RET") 'newline-and-indent)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "943bff6eada8e1796f8192a7124c1129d6ff9fbd1a0aed7b57ad2bf14201fdd4" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
