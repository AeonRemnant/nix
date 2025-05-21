(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-url "https://raw.githubusercontent.com/radian-software/straight.el/master/install.el"))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously bootstrap-url)
      (goto-char (point-min))
      (eval-buffer)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; UI settings
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Default font
(set-face-attribute 'default nil :font "JetBrains Mono Nerd Font Mono" :height 100)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono Nerd Font Mono-10"))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :init
  (progn
    (setq magit-repository-directories '(("~/repos" . 1)
                                         ("~/projects" . 1)
                                         (t . 0)))
    (setq magit-last-directory-behavior 'session-global))
  :bind
  ("C-x g" . magit-status)
  ("C-x M-g" . magit-status-quickly-search))

(defun my/magit-status-or-default (&optional path)
  "Open magit-status for PATH, or guess the current project."
  (interactive)
  (let* ((default-directory (if path
                                (file-truename path)
                              (locate-dominating-file (buffer-file-name) ".git"))))
    (magit-status)))

(defun my/magit-repo (repo-path)
  "Open magit-status for the repository at REPO-PATH."
  (interactive "DPath to repository: ")
  (find-file (concat repo-path "/.git"))
  (magit-status))
