;; -*- lexical-binding: t; -*-

(defun config-gen-comp ()
  "Tangles the '*.org' file to '*.el', and compiles it to '*.elc' and '*.eln'."
  (interactive)
  (org-babel-tangle)
  (byte-recompile-directory "." 0)
  (native-compile "init.el"))

(require 'package)
(setq package-check-signature nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'use-package)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(use-package gcmh
  :config
  (gcmh-mode 1))

(setq gc-cons-threshold (* 50 1000 1000)
      gc-cons-percentage 0.6)

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "[*] GNU Emacs loaded in %s with %d GC's."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))

(setq comp-async-report-warnings-errors nil)

(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil)
  (setq native-comp-jit-compilation t)
  (setq comp-speed 3))

(use-package projectile
  :config
  (projectile-mode +1))

(use-package all-the-icons)
(use-package nerd-icons)

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-display-icons-p t)
  (setq dashboard-banner-logo-title "GNU Emacs")
  (setq dashboard-startup-banner "/home/iwas/.emacs.d/logo.png")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents . 10)
			  (agenda . 5)
			  (bookmarks . 5)
			  (projects . 5)
			  (registers . 5)))
  (global-display-line-numbers-mode 0)
  :config
  (dashboard-setup-startup-hook))

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(use-package doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-one t)

(use-package doom-modeline)
(doom-modeline-mode 1)

(set-face-attribute 'mode-line nil :font "JetbrainsMono Nerd Font 14")
(setq doom-modeline-height 30
      doom-modeline-bar-width 5
      doom-modeline-persp-name t
      doom-modeline-persp-icon t)

(use-package rainbow-mode
  :diminish
  :hook
  org-mode prog-mode)

;; Add rainbow colouring to delimiters when in 'prog-mode' and 'text-mode'
(use-package rainbow-delimiters
  :hook
  ((prog-mode . rainbow-delimiters-mode)))

;; Face attributes for different conditions
(set-face-attribute 'default nil
		    :font "JetbrainsMono Nerd Font 13"
		    :weight 'medium)
(set-face-attribute 'variable-pitch nil
		    :font "JetbrainsMono Nerd Font 13"
		    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
		    :font "JetbrainsMono Nerd Font 13"
		    :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil
		    :weight 'normal
		    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
		    :weight 'extra-bold
		    :slant 'italic)

;; Ensure 'emacsclient' frames have the correct font
(add-to-list 'default-frame-alist '(font . "JetbrainsMono Nerd Font 13"))

;; Pretty symbols substitutions
(defun load-prettify-symbols ()
  "Set a buffer-local value for 'prettify-symbols-alist'."
  (setq prettify-symbols-alist
	'(("lambda" . ?λ)
	  ("<-" . ?⟵)
	  ("<--" . ?⟻)
	  ("->" . ?⟶)
	  ("-->" . ?⟼)
	  ("<==" . ?⟸)
	  ("=>" . ?⇒)
	  ("==>" . ?⟹)
	  ("<=>" . ?⇔)
	  ("<==>" . ?⟺)
	  ("==" . ?≈)
	  ("!=" . ?≉)
	  ("===" . ?≡)
	  ("!==" . ?≢)
	  ("<=" . ?⩽)
	  (">=" . ?⩾)
	  ("NULL" . ?⦰)
	  ("++" . ?∆)
	  ("#+begin_src" . ?)
	  ("#+BEGIN_SRC" . ?)
	  ("#+end_src" . ?)
	  ("#+END_SRC" . ?)
	  ("#+author:" . ?)
	  ("#+AUTHOR:" . ?)
	  ("#+title:" . ?)
	  ("#+TITLE:" . ?)
	  ("#+options:" . ?)
	  ("#+OPTIONS:" . ?)
	  ("#+property:" . ?)
	  ("#+PROPERTY:" . ?)
	  (":tangle" . ?⇶))))
(global-prettify-symbols-mode 1)

;; Add pretty symbols to 'org-mode'
(add-hook 'org-mode-hook 'load-prettify-symbols)
;; Add pretty symbols to 'prog-mode'
(add-hook 'prog-mode-hook 'load-prettify-symbols)

;; Enabling and disabling modes
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-visual-line-mode t)
(global-hl-line-mode 1)
(global-display-line-numbers-mode)
(electric-pair-mode t)
(delete-selection-mode 1)
(global-auto-revert-mode 1)
(pixel-scroll-precision-mode t)
(tooltip-mode -1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Setting some variables
(setq-default cursor-type '(bar . 3))
(setq-default indent-tabs-mode nil)
(setq display-line-numbers-type 'relative)
(setq ring-bell-function 'ignore)
(setq mouse-wheel-progressive-speed nil)
(setq make-backup-files nil)
(setq org-support-shift-select t)
(setq completion-cycle-threshold 3)
(setq standard-indent 2)
(setq sh-basic-offset 2)
(setq global-auto-revert-non-file-buffers t)
(setq pixel-scroll-precision-use-momentum t)
(setq pixel-scroll-precision-interpolate-mice t)
(setq pixel-scroll-precision-interpolate-page t)
(setq pixel-scroll-precision-interpolation-factor 0.7)
(setq pixel-scroll-precision-large-scroll-height nil)
(setq use-dialog-box nil)
(setq x-gtk-use-system-tooltips nil)
(setq org-return-follows-link t)
(setq compilation-scroll-output t)

;; Replace 'BufferMenu' with 'Ibuffer'
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; '<f5>' shortcut for 'M-x compile' command
(global-set-key (kbd "<f5>") 'compile)
;; '<f2>' shortcut for 'M-x man' command
(global-set-key (kbd "<f2>") 'man)

;; Disable 'electric-pair-mode' with '<>' predicate for 'org-mode'
(add-hook 'org-mode-hook
	  (lambda () (setq-local electric-pair-inhibit-predicate
				 `(lambda (c)
				    (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

;; Use spaces instead of tabs for 'go-mode'
(add-hook 'go-mode-hook
          (lambda () (setq tab-width 2
                           standard-indent 2
                           indent-tabs-mode nil)))

(defun prepare-scratch-for-kill ()
  "Whenever the 'scratch' buffer gets killed, open it again."
  (save-excursion
    (set-buffer (get-buffer-create "*scratch*"))
    (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer t)))

(defun kill-scratch-buffer ()
  "Kill function for the 'scratch' buffer."
  (let (kill-buffer-query-functions)
    (kill-buffer (current-buffer)))
  (prepare-scratch-for-kill)
  nil)

(prepare-scratch-for-kill)

(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'column))

;; Add indentation guides to 'prog-mode', 'org-mode' and 'text-mode'
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(add-hook 'org-mode-hook 'highlight-indent-guides-mode)
(add-hook 'text-mode-hook 'highlight-indent-guides-mode)

(setq dired-listing-switches "-agho --group-directories-first")

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-ranger)

(use-package dired-rainbow
  :after dired
  :custom
  (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
  (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
  (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
  (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
  (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
  (dired-rainbow-define media "#de751f" ("mp3" "mp4" "mkv" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
  (dired-rainbow-define log "#c17d11" ("log"))
  (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
  (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
  (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
  (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
  (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
  (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*"))

(use-package which-key
  :init
  (setq which-key-side-window-location 'bottom
	which-key-sort-order #'which-key-key-order-alpha
	which-key-sort-uppercase-first nil
	which-key-add-column-padding 1
	which-key-max-display-columns nil
	which-key-min-display-lines 6
	which-key-side-window-slot -10
	which-key-side-window-max-height 0.25
	which-key-idle-delay 0.8
	which-key-max-description-length 25
	which-key-allow-imprecise-window-fit t
	which-key-separator " → "))
(which-key-mode)

(use-package corfu
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  :config
  (add-hook 'eshell-mode-hook
	    (lambda () (setq-local corfu-quit-at-boundary t
				   corfu-quit-no-match t
				   corfu-auto nil)
	      (corfu-mode)))
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-echo-documentation 0.25)
  (corfu-preview-current nil)
  (corfu-preselect 'prompt)
  (corfu-on-exact-match nil)
  (corfu-scroll-margin 5))

(use-package counsel
  :after ivy
  :diminish
  :config (counsel-mode))

(use-package ivy
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1)
  :custom
  (ivy-virtual-abbreviate 'full
			  ivy-rich-switch-buffer-align-virtual-buffer t
			  ivy-rich-path-style 'abbrev))

(defun emacs-counsel-launcher ()
  "App launcher that reads '.desktop' files from within GNU Emacs."
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-run-launcher")
		    (minibuffer . only)
		    (fullscreen 0)
		    (undecorated . t)
		    (auto-raise . t)
		    (internal-border-width . 10)
		    (width . 30)
		    (height . 10)))
    (unwind-protect
	(counsel-linux-app)
      (delete-frame))))

;; Show only the pretty name
(setq counsel-linux-app-format-function 'counsel-linux-app-format-function-name-only)

(defun games/async-shell-command-no-frame (command)
  "Exeute a command with 'async-shell-command' without creating any output window."
  (let ((display-buffer-alist (list (cons "\\*Async Shell Command\\*.*"
					  (cons #'display-buffer-no-window nil)))))
    (async-shell-command command)))

(defun games/async-shell-command-new-frame (command)
  "Exeute a command with 'async-shell-command' opening a new frame with the output window on it."
  (let ((display-buffer-alist (list (cons "\\*Async Shell Command\\*.*"
					  (cons #'display-buffer-no-window nil)))))
    (other-frame-prefix)
    (async-shell-command command)))

(defun games/game-launcher ()
  "Game launcher that reads all working symlinks within '/usr/local/games'."
  (interactive)
  (setq game-list-str (shell-command-to-string "find /usr/local/games -type l -exec sh -c 'test -e \"$1\" && printf \"%s\\n\" \"$(basename \"$1\")\"' sh {} \\; | grep -v '\\.' | sort -n"))
  (setq game-list (split-string game-list-str "\n" t " "))

  (ivy-read "Run game: "
	    game-list
	    :action (lambda (x)
		      (games/async-shell-command-no-frame (format "/usr/local/games/%s" x)))))

(defun games/game-launcher-menu ()
  "Create a frame with a buffer that runs the 'games/game-launcher' function."
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-game-launcher")
		    (minibuffer . only)
		    (fullscreen 0)
		    (undecorated . t)
		    (auto-raise . t)
		    (internal-border-width . 10)
		    (width . 30)
		    (height . 10)))
    (unwind-protect
	(games/game-launcher)
      (delete-frame))))

(defvar node-name-list nil "List of sink names")

(defun pulse/sink-selector ()
  "Select a sink to use from an interactive list from Pulseaudio."
  (interactive)
  (setq node-name-list-str (shell-command-to-string "pactl list sinks | grep -oP '(?<=node.name = \").*?(?=\")'"))
  (setq node-name-list (split-string node-name-list-str "\n" t " "))

  (ivy-read "Select sink: "
	    node-name-list
	    :action (lambda (x)
		      (shell-command (format "pactl set-default-sink %s" x)))))

(defun pulse/sink-selector-menu ()
  "Create a frame with a buffer that runs the 'pulse/sink-selector' function."
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-pulse-sink-selector")
		    (minibuffer . only)
		    (fullscreen 0)
		    (undecorated . t)
		    (auto-raise . t)
		    (internal-border-width . 10)
		    (width . 78)
		    (height . 4)))
    (unwind-protect
	(pulse/sink-selector)
      (delete-frame))))

(defun power/sudo-shell-command (cmd)
  (shell-command (concat "echo " (read-passwd "passwd: ") " | sudo -S " cmd)))

(defun power/action-selector ()
  "Select a power action from a list."
  (interactive)
  (let ((actions '("Lock" "Log Out" "Halt" "Restart" "Power Off"))
	(cmds '("/usr/local/bin/lock" "/usr/local/bin/logout" "/usr/bin/halt" "/usr/bin/reboot" "/usr/bin/poweroff"))
	selected-action)

    (ivy-read "Select action: "
	      actions
	      :action (lambda (x)
			(setq selected-action (nth (cl-position x actions :test 'equal) cmds))
			(if selected-action
			    (if (or
                                 (string-equal x "Halt")
                                 (string-equal x "Restart")
                                 (string-equal x "Power Off"))
				(when (y-or-n-p (format "Are you sure you want to '%s'? " x))
				  (power/sudo-shell-command selected-action))
			      (when (y-or-n-p (format "Are you sure you want to '%s'? " x))
				(shell-command selected-action)))
			  (message "Invalid action"))))))

(defun power/action-selector-menu ()
  "Create a frame with a buffer that runs the 'power/action-selector' function."
  (interactive)
  (with-selected-frame
      (make-frame '((name . "emacs-power-action-selector")
		    (minibuffer . only)
		    (fullscreen 0)
		    (undecorated . t)
		    (auto-raise . t)
		    (internal-border-width . 10)
		    (width . 24)
		    (height . 6)))
    (unwind-protect
	(power/action-selector)
      (delete-frame))))

(defcustom neo-window-width 25
  "Set fixed width for neotree."
  :type 'integer
  :group 'neotree)

(use-package neotree
  :bind
  ("C-x C-n" . neotree)
  :config
  (setq neo-smart-open t
	neo-window-width 30
	neo-theme (if (display-graphic-p) 'icons)
	inhibit-compacting-font-caches t
	projectile-switch-project-action 'neotree-projectile-action)
  (add-hook 'neo-after-create-hook
	    #'(lambda (&rest _)
		(with-current-buffer (get-buffer neo-buffer-name)
		  (display-line-numbers-mode -1)
		  (setq truncate-lines t)
		  (setq word-wrap nil)
		  (make-local-variable 'auto-hscroll-mode)
		  (setq auto-hscroll-mode nil)))))

;; Show hidden files in neotree, and autorefresh
(setq-default neo-show-hidden-files t
	      neo-autorefresh t)

(use-package minimap
  :bind
  ("C-x C-m" . minimap-mode))

;; Set the minimap to the right side of the editor.
(setq minimap-window-location 'right)

(use-package magit)

(use-package elfeed
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"
        elfeed-feeds (quote
                      (("https://www.phoronix.com/rss.php" phoronix linux)))))

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package flycheck-eglot)
(global-flycheck-eglot-mode 1)

(use-package flycheck-inline)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

(use-package yaml-mode)
(use-package haskell-mode)
(use-package terraform-mode)
(use-package go-mode)
(use-package mermaid-mode)

(use-package markdown-mode)

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "JetbrainsMono Nerd Font"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.7))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.2)))))

(add-hook 'org-mode-hook 'org-indent-mode)

(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8
      x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(setq org-ellipsis " ▼ "
      org-log-done 'time
      org-hide-emphasis-markers nil
      org-src-fontify-natively t
      org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0
      org-confirm-babel-evaluate nil)

;; Make M-RET not add blank lines
(setq org-blank-before-new-entry (quote ((heading . nil)
					 (plain-list-item . nil))))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "⁑" "⁂" "❖" "✮" "✱" "✸")))

(defun org-colors-doom-one ()
  "Enable 'Doom One' colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.7 "#51afef" ultra-bold)
	 (org-level-2 1.6 "#c678dd" extra-bold)
	 (org-level-3 1.5 "#98be65" bold)
	 (org-level-4 1.4 "#da8548" semi-bold)
	 (org-level-5 1.3 "#5699af" normal)
	 (org-level-6 1.2 "#a9a1e1" normal)
	 (org-level-7 1.1 "#46d9ff" normal)
	 (org-level-8 1.0 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil
			:font "JetbrainsMono Nerd Font"
			:weight (nth 3 face)
			:height (nth 1 face)
			:foreground (nth 2 face)))
  (set-face-attribute 'org-table nil
		      :font "JetbrainsMono Nerd Font"
		      :weight 'normal
		      :height 1.0
		      :foreground "#bfafdf"))

(add-hook 'after-init-hook 'org-colors-doom-one)

(use-package org-tempo
  :ensure nil)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

;; Set the maximum depth of the ToC to the number of distinct heading bullet icons (7)
(setq toc-org-max-depth 7)

(setq org-agenda-files
      '("~/.emacs.d/agenda.org.d/todo.org")
      org-agenda-start-with-log-mode t
      org-log-done 'time
      org-log-into-drawer t)

(use-package ox-man
  :ensure nil)

(use-package vterm)
(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000)

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

(add-hook 'eshell-mode-hook (lambda (&rest _)
			      (setq-local global-hl-line-mode nil
					  cursor-type 'bar
					  pcomplete-cycle-completions nil
					  eshell-cmpl-cycle-completions nil)
			      (with-current-buffer (get-buffer eshell-buffer-name)
				(display-line-numbers-mode -1))
			      (local-set-key (kbd "<home>") #'eshell-bol)))

(setq eshell-aliases-file "~/.emacs.d/eshell/aliases"
      eshell-banner-message ""
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t)

(defun run-this-in-eshell (cmd)
  "Runs the command 'cmd' in eshell."
  (with-current-buffer "*eshell*"
    (end-of-buffer)
    (eshell-kill-input)
    (insert cmd)
    (eshell-send-input)
    (end-of-buffer)
    (eshell-bol)
    (yank)))

(bind-keys*
 ("C-l" . (lambda ()
	    (interactive)
	    (run-this-in-eshell "clear-scrollback"))))

(defun eshell-other-window ()
  "Create an interactive Eshell buffer in another window."
  (interactive)
  (other-window-prefix)
  (eshell))
(global-set-key (kbd "C-x j") 'eshell-other-window)

(use-package eat
  :config
  (eat-eshell-mode))

(setq gc-cons-threshold (* 2 1000 1000))
