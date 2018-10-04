; added by package.el.  this must come before configurations of
;; installed packages.  don't delete this line.  if you don't want it,
;; just commnt it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Emacs package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dashboard browse-kill-ring  multiple-cursors undo-tree smartrep  auto-complete))))
(setq make-backup-files nil)
(scroll-bar-mode nil)
(global-set-key "\C-x\C-b" 'buffer-menu)

;;~~~~~~~~~~~~~~~~~~~~display option~~~~~~~~~~~~~~~~~~~~
;; スタート時のスプラッシュ非表示
(setq inhibit-startup-message t)
;; 起動画面をdashboardで変更
(require 'dashboard)
;; Set the title
(setq dashboard-banner-logo-title "good job")
;; Set the banner
(setq dashboard-startup-banner "~/.emacs.d/429760.png")
(dashboard-setup-startup-hook)
(setq dashboard-items '((bookmarks . 5)
			))


;;dashbordの設定
(global-set-key (kbd "C-x M-d")
                #'(lambda () (interactive)
                    (switch-to-buffer "*dashboard*")))
(setq ring-bell-function 'ignore)
(global-linum-mode t) ;;行番号
(line-number-mode 0) ;;モードラインに列を非表示
(blink-cursor-mode 0) ;;カーソルの点滅
(electric-pair-mode t) ;;かっこの自動表示
(add-to-list 'electric-pair-pairs '(?{ . ?}))
(show-paren-mode 1);; かっこの光


;; (require 'multi-term);;this is for multiterm
;; (setq multi-term-program shell-file-name)

(setq scroll-margin 1)
(global-set-key "\M-n" (lambda () (interactive) (scroll-up 1)))
(global-set-key "\M-p" (lambda () (interactive) (scroll-down 1)))

(setq scroll-conservatively 35
  scroll-margin 0
)

(setq
 mouse-wheel-scroll-amount ;;マウスホイール
 '(1)
 mouse-wheel-progressive-speed nil
 )



(global-set-key (kbd "M-/") 'undo-tree-redo)
(global-set-key (kbd "C-/") 'undo-tree) 
(global-set-key (kbd "C-<") 'beginning-of-buffer);;バッファの先頭に
(global-set-key (kbd "C->") 'end-of-buffer);;バッファのケツに
(global-set-key (kbd "M->") 'switch-to-next-buffer) ;;バッファーとトグル操作簡単にする。
(global-set-key (kbd "M-<") 'switch-to-prev-buffer) ;;バッファーとトグル操作簡単にする。
;;brows-kill-ring
(global-set-key (kbd "M-y") 'browse-kill-ring)
;; enable to sort by buffer names in Buffer-menu-mode
(setq Buffer-menu-sort-column 2)
;;C-h as del, kill this line to use defaoult C-h"help". 
(global-set-key "\C-h" 'delete-backward-char)
;; 現在行をハイライト
(global-hl-line-mode t)
(defface my-hl-line-face
  '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
     (:background "black" t))   ; 背景を黒に.
    (((class color) (background light)) ; カラーかつ, 背景が light ならば,
     (:background "ForestGreen" t))     ; 背景を ForestGreen に.
    (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(setq frame-title-format "%f");;フルパス表示
;; ツールバー非表示
(tool-bar-mode 0)
;; メニューバー非表示
(menu-bar-mode 0)
(setq initial-scratch-message ";;this is #scratch#, you can use elisp evaluation by C-j")
;; current directory のモードライン表示
(let ((ls (member 'mode-line-buffer-identification
                  mode-line-format)))
  (setcdr ls
          (cons '(:eval (concat " ("
                                (abbreviate-file-name default-directory)
                                ")"))
                (cdr ls))))
;;背景透明を入れ替える。
(setq alpha-on-flag nil)
(defun skelton-toggle()
  (interactive)
  (if (equal alpha-on-flag t)
      (progn
	(set-frame-parameter nil 'alpha 100)
	(setq alpha-on-flag nil)
	(message "alpha-off"))
    (progn
      (set-frame-parameter nil 'alpha 85)
      (setq alpha-on-flag t)
      (message "alpha-on"))))


;; 警告音もフラッシュも全て無効(警告音が完全に鳴らなくなるので注意)
(setq ring-bell-function 'ignore)

(global-set-key (kbd "C-M-s")
                #'(lambda () (interactive)
                    (switch-to-buffer "*scratch*")))
;; (setq initial-frame-alist
;;       (append
;;        '((top . 22)    ; フレームの Y 位置(ピクセル数)
;;      (left . 0)    ; フレームの X 位置(ピクセル数)
;;    (width . 100)    ; フレーム幅(文字数)
;;     (height . 100)   ; フレーム高(文字数)
;;     ) initial-frame-alist))
;;カラーテーマの設定
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-zenburn)よくワカンねぇけどうまく言ってる。
;;; region
(transient-mark-mode t)
(set-face-background 'region "cornflower blue")
(set-face-foreground 'region "snow")
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
;;....................  view  mode ....................
(setq view-read-only t)
(defvar pager-keybind
      `( 
        ("h" . backward-char)
        ("l" . forward-char)
        ("j" . next-line)
        ("k" . previous-line)
        ("e" . end-of-buffer)
        ("f" . forward-word)
        ("b" . backward-word)
        ("]" . forward-word)
        ("[" . backward-word)
        ("}" . forward-paragraph)
        ("{" . backward-paragraph)
        ("n" . ,(lambda () (interactive) (scroll-up 1)))
        ("p" . ,(lambda () (interactive) (scroll-down 1)))
        ("N" . ,(lambda () (interactive) (scroll-other-window-down 1)))
        ("P" . ,(lambda () (interactive) (scroll-other-window 1)))
	("i" . view-mode)
        ))
(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)
 
(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)
 
;; 書き込み不能なファイルは view-mode で開くように
(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))

;; 書き込み不能な場合は view-mode を抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))
 
(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)
(global-set-key (kbd "M-i") 'view-mode)

;;@@@@@@@@@@@@@@@@@@@@  macro list @@@@@@@@@@@@@@@@@@@@
;;Mx name-, Mx insert-,
(fset 'chose-this-line
   [?\C-a ?\C-  ?\C-e])
(global-set-key (kbd "C-0") 'chose-this-line)

;;####################    dired   #####################

(load "dired-x") ;; dired-x
(ffap-bindings) ;; C-x C-f の拡張
(setq ls-lisp-dirs-first t) ;;ディレクトリ先
(when (eq system-type 'darwin);;'access-file' worked の処理
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode);; rでwrithng

;;$$$$$$$$$$$$$$$$$$$$  autocomplete $$$$$$$$$$$$$$$$$$$

(require 'auto-complete-config)
;; よくわからない
(ac-config-default)
;; TABキーで自動補完を有効にする
(ac-set-trigger-key "TAB")
;; auto-complete-mode を起動時に有効にする
(global-auto-complete-mode t)
(push 'ac-source-symbols ac-sources)
(global-set-key (kbd "<C-tab>") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "<C-S-tab>") (lambda () (interactive) (other-window -1)))
(setq completion-show-help nil) ;;completion buffer help を非表示.

;;%%%%%%%%%%%%%%%%%%%% multiple-cursors ################

(require 'multiple-cursors) ;; 複数のカーソル
(require 'smartrep)
(declare-function smartrep-define-key "smartrep")
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-M-r") 'mc/mark-all-in-region)
(global-unset-key "\C-t")
(smartrep-define-key global-map "C-t"
  '(("C-t"      . 'mc/mark-next-like-this)
    ("n"        . 'mc/mark-next-like-this)
    ("p"        . 'mc/mark-previous-like-this)
    ("m"        . 'mc/mark-more-like-this-extended)
    ("u"        . 'mc/unmark-next-like-this)
    ("U"        . 'mc/unmark-previous-like-this)
    ("s"        . 'mc/skip-to-next-like-this)
    ("S"        . 'mc/skip-to-previous-like-this)
    ("*"        . 'mc/mark-all-like-this)
    ("d"        . 'mc/mark-all-like-this-dwim)
    ("i"        . 'mc/insert-numbers)
    ("o"        . 'mc/sort-regions)
    ("O"        . 'mc/reverse-regions)))

;;^^^^^^^^^^^^^^^^^^^^ undo-tree ^^^^^^^^^^^^^^^^^^^^

(require 'undo-tree);;C-x u
;; undo-tree を起動時に有効にする
(global-undo-tree-mode t)

;;`````````````````````flymake''''''''''''''''''''''

(require 'flymake)
(defun flymake-get-make-cmdline (source base-dir)
  (list "make"
        (list "-s" "-C"
              base-dir
              (concat "CHK_SOURCES=" source)
              "SYNTAX_CHECK_MODE=1")))


;;&&&&&&&&&&&&&&&&&&&& my create &&&&&&&&&&&&&&&&&&&&

;; JIBANYAN ART
(defun jibanyan-init()
  (interactive)
  (progn
    (insert "
;;  　　∧＼＿＿＿／ヽ
;; 　 丿｜　 (､ ｜ く
;; 　 |／　　ﾉ)　＼ |
;; 　 /　 ／　 ＼ 　ﾍ
;; 　｜  (●) ▼ (●)  ｜
;; 　人( (＿／＼＿)  )ﾉ
;; 　人＼＿_二二_＿／人
;; （の)／ヽ_Θ_ノ＼(の)
;; 　||(ﾌ|＿＿＿＿ヽ)||
;; 　||　|||｜｜|||　||
;; 　ヽ二|￣￣￣￣|二ノ
;; 　　　ヽノ￣ヽノ\n")))
(global-set-key (kbd "M-[") 'jibanyan-init)
(defun sachi-init()
  (interactive)
  (progn
    (insert "
;;    ____
;;  /     ヽ
;; |   〠 　|
;; 山 　　　山
;; |　◯　◯  |
;; |　◯　◯  |
;; ヽ ＿＿　ノ \n")))
(global-set-key (kbd "M-]") 'sachi-init)

;;********************my memo********************
;; highlight-phases
(put 'downcase-region 'disabled nil)
(custom-set-faces

 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
