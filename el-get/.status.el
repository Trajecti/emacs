((autopair status "installed" recipe
	   (:name autopair :website "https://github.com/capitaomorte/autopair" :description "Autopair is an extension to the Emacs text editor that automatically pairs braces and quotes." :type github :pkgname "capitaomorte/autopair" :features autopair))
 (buffer-move status "installed" recipe
	      (:name buffer-move :description "Swap buffers without typing C-x b on each window" :type emacswiki :features buffer-move))
 (cider status "installed" recipe
	(:name cider :description "CIDER is a Clojure IDE and REPL." :type github :pkgname "clojure-emacs/cider" :depends
	       (dash queue clojure-mode pkg-info)))
 (clj-refactor status "installed" recipe
	       (:name clj-refactor :description "A collection of simple clojure refactoring functions" :type github :depends
		      (dash s clojure-mode yasnippet paredit multiple-cursors)
		      :pkgname "magnars/clj-refactor.el"))
 (clojure-mode status "installed" recipe
	       (:name clojure-mode :website "https://github.com/clojure-emacs/clojure-mode" :description "Emacs support for the Clojure language." :type github :pkgname "clojure-emacs/clojure-mode"))
 (color-identifiers-mode status "installed" recipe
			 (:name color-identifiers-mode :description "Emacs minor mode to highlight each source code identifier uniquely based on its name" :type github :pkgname "ankurdave/color-identifiers-mode" :depends
				(dash python)))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (company-mode status "installed" recipe
	       (:name company-mode :website "http://company-mode.github.io/" :description "Modular in-buffer completion framework for Emacs" :type github :pkgname "company-mode/company-mode"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:load "el-get.el"))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (evil status "installed" recipe
       (:name evil :website "http://gitorious.org/evil/pages/Home" :description "Evil is an extensible vi layer for Emacs. It\n       emulates the main features of Vim, and provides facilities\n       for writing custom extensions." :type git :url "git://gitorious.org/evil/evil.git" :features evil :depends
	      (undo-tree goto-chg)
	      :build
	      (("make" "all" "info"))
	      :build/berkeley-unix
	      (("gmake" "all" "info"))
	      :build/darwin
	      `(("make" ,(format "EMACS=%s" el-get-emacs)
		 "all" "info"))
	      :info "doc"))
 (goto-chg status "installed" recipe
	   (:name goto-chg :description "Goto the point of the most recent edit in the buffer." :type emacswiki :features goto-chg))
 (ido-hacks status "installed" recipe
	    (:name ido-hacks :description "Advices for ido-mode." :type github :pkgname "scottjad/ido-hacks" :load "ido-hacks.el"))
 (ido-vertical-mode status "installed" recipe
		    (:name ido-vertical-mode :type github :pkgname "rson/ido-vertical-mode.el" :description "makes ido-mode display vertically" :features ido-vertical-mode))
 (multiple-cursors status "installed" recipe
		   (:name multiple-cursors :description "An experiment in adding multiple cursors to emacs" :type github :pkgname "magnars/multiple-cursors.el"))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (let
		       ((old-package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))))
		     (when
			 (file-directory-p old-package-user-dir)
		       (add-to-list 'package-directory-list old-package-user-dir)))
		   (setq package-archives
			 (bound-and-true-p package-archives))
		   (mapc
		    (lambda
		      (pa)
		      (add-to-list 'package-archives pa 'append))
		    '(("ELPA" . "http://tromey.com/elpa/")
		      ("melpa" . "http://melpa.milkbox.net/packages/")
		      ("gnu" . "http://elpa.gnu.org/packages/")
		      ("marmalade" . "http://marmalade-repo.org/packages/")
		      ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (paredit status "installed" recipe
	  (:name paredit :description "Minor mode for editing parentheses" :type http :prepare
		 (progn
		   (autoload 'enable-paredit-mode "paredit")
		   (autoload 'disable-paredit-mode "paredit"))
		 :url "http://mumble.net/~campbell/emacs/paredit.el"))
 (pkg-info status "installed" recipe
	   (:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
		  (dash epl)))
 (python status "installed" recipe
	 (:name python :description "Python's flying circus support for Emacs (trunk version, hopefully Emacs 24.x compatible)" :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/master:/lisp/progmodes/python.el"))
 (queue status "installed" recipe
	(:name queue :description "Queue data structure" :type elpa))
 (rainbow-delimiters status "installed" recipe
		     (:name rainbow-delimiters :website "https://github.com/jlr/rainbow-delimiters#readme" :description "Color nested parentheses, brackets, and braces according to their depth." :type github :pkgname "jlr/rainbow-delimiters"))
 (s status "installed" recipe
    (:name s :description "The long lost Emacs string manipulation library." :type github :pkgname "magnars/s.el"))
 (smooth-scroll status "installed" recipe
		(:name smooth-scroll :description "Minor mode for smooth scrolling." :type emacswiki :features smooth-scroll))
 (solarized-emacs status "installed" recipe
		  (:name solarized-emacs :description "Solarized for Emacs is an Emacs port of the Solarized theme for vim, developed by Ethan Schoonover." :website "https://github.com/bbatsov/solarized-emacs" :minimum-emacs-version "24" :type github :pkgname "bbatsov/solarized-emacs" :depends dash :prepare
			 (add-to-list 'custom-theme-load-path default-directory)))
 (undo-tree status "installed" recipe
	    (:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/"))
 (yasnippet status "installed" recipe
	    (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :compile "yasnippet.el" :submodule nil :build
		   (("git" "submodule" "update" "--init" "--" "snippets")))))
