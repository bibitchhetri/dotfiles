;; -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom sync' after modifying this file!

;; User information (optional)
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Fonts
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;; Theme
(setq doom-theme 'doom-one)

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Org-mode directory
(setq org-directory "~/org/")

;; Remove frame decorations (titlebar, buttons, etc.)
(add-to-list 'default-frame-alist '(undecorated . t))

;; Org Mode Settings
(after! org
  ;; Link navigation
  (setq org-return-follows-link t
        org-tab-follows-link t
        org-link-search-must-match-exact-headline nil
        org-link-search-headline-must-match-exact nil)

  ;; Keybindings for link navigation
  (define-key org-mode-map (kbd "RET") 'org-open-at-point)
  (define-key org-mode-map (kbd "TAB") 'org-next-link)
  (define-key org-mode-map (kbd "S-TAB") 'org-previous-link)

  ;; Enable <s TAB snippets
  (require 'org-tempo))

;; Org visual enhancements
(use-package! toc-org
  :after org
  :hook (org-mode . toc-org-enable))

(use-package! org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "◇" "◆" "➤" "ᐅ" "▱" "■")
        org-superstar-item-bullet-alist '((?- . "•") (?+ . "➤") (?* . "⁃"))))

(add-hook 'org-mode-hook #'org-indent-mode)

;; Vertico Posframe (Floating UI)
(after! vertico
  (when (and (display-graphic-p)
             (require 'vertico-posframe nil t))
    (setq vertico-posframe-poshandler 'posframe-poshandler-frame-center
          vertico-posframe-width 90
          vertico-posframe-height 16
          vertico-posframe-border-width 1
          vertico-posframe-parameters
          '((internal-border-width . 10)
            (left-fringe . 8)
            (right-fringe . 8)
            (alpha . 97)))
    (vertico-posframe-mode 1)))

;; Mac-specific dark mode appearance
(when (fboundp 'ns-use-native-fullscreen)
  (set-frame-parameter nil 'ns-appearance 'dark))

