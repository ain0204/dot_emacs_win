;; ---
;;
;; package.el
;; ---
(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; 初期化
(package-initialize)


;; ---
;;
;; 文字コードの設定
;; ---
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")


;; ---
;;
;; face
;; ---
(load-theme 'monokai t)
;; コメントの色が気に入らないので変更
(set-face-foreground 'font-lock-comment-delimiter-face "YellowGreen")
(set-face-foreground 'font-lock-comment-face "YellowGreen")
;; Regionの色
;; (set-face-foreground 'region "white")
;; (set-face-background 'region "dimgray")
(set-face-foreground 'region "white")
(set-face-background 'region "honeydew4")


;; ---
;;
;; 基本的な表示・装飾に関して
;; ---
;; モードラインの表示設定
;; 行番号 / カラム番号の表示

(line-number-mode t)
(column-number-mode t)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "emacs : %f")

;; スタートアップ非表示
(setq inhibit-startup-screen t)
;; ツールバーを非表示
(tool-bar-mode -1)
;; メニューバーを非表示
(menu-bar-mode -1)
;; scroll-barの非表示
(scroll-bar-mode -1)

;; *scratch* バッファのメッセージ変更
(setq initial-scratch-message
      ";; Godspeed you!")

;; 対応する括弧をハイライト
(show-paren-mode t)
(setq show-paren-style 'mixed)


;; ---
;;
;; util
;; ---
;; backupファイルの保存先
(add-to-list 'backup-directory-alist
             (cons (expand-file-name "~/") (expand-file-name "~/.emacs.d/trash/")))

;; 変更のあったファイルの自動再読み込み
(global-auto-revert-mode 1)

;; 警告音を消す
(setq ring-bell-function 'ignore)

;; emacs クリップボード
(setq x-select-enable-clipboard t)

;; 保存時に行末空白行は削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; ---
;;
;; 背景透過を切り替える関数
;; ---
(setq alpha-on-flag nil)
(set-frame-parameter nil 'alpha 100)
(defun alpha-toggle()
  (interactive)
  (if (equal alpha-on-flag t)
      (progn
	(set-frame-parameter nil 'alpha 100)
	(setq alpha-on-flag nil)
	(message "alpha-off"))
    (progn
      (set-frame-parameter nil 'alpha 80)
      (setq alpha-on-flag t)
      (message "alpha-on"))))

(define-key global-map (kbd "C-c C-a") 'alpha-toggle)


;;---------------------------------------
;;
;; キーバインド集
;;---------------------------------------
;; C-mにnewline-and-indentを割り当てる
;; 本来、C-mにはnewlineが割り当てられている
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; "C-h"にbackspaceを割jり当てる
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; "C-c l"に折り返しトグルを割り当てる
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; "C-t"でウィンドウを切り替える
;; 初期値はtranspose-chars（入れ替えるやつ）が割り当てられてる。
(define-key global-map (kbd "C-t") 'other-window)

;; "C-c C-r" に置換を割り当てる
(define-key global-map (kbd "C-c C-r") 'replace-string)

;; "C-h"にbackspaceを割り当てる
;; (define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; nnで「ん」が入力できるようする設定。
(setq quail-japanese-use-double-n t)


;; 時計
(display-time)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (helm-tramp highlight-symbol auto-highlight-symbol auto-complete open-junk-file markdown-mode+ typing-game hlinum multiple-cursors google-translate monokai-theme solarized-theme nyan-mode helm redo+))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ---
;;
;; redo+
;; ---
(when (require 'redo+ nil t)
  (global-set-key (kbd "C-.") 'redo))


;; ---
;;
;; helm
;; ---
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-;") 'helm-for-files)
(global-set-key (kbd "C-:") 'helm-for-files) ;; 環境によってはC-;が持っていかれているので
(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-idle-delay 0.2)
(setq helm-input-idle-delay 0.2)
(setq helm-candidate-number-limit 100)


;; ---
;;
;; nyan-mode
;; ---
(require 'nyan-mode)
(nyan-mode)
(nyan-start-animation) ;; 動くぞ！



;; ---
;;
;; 翻訳
;; ---
(require 'google-translate)

(defvar google-translate-english-chars "[:ascii:]"
  "これらの文字が含まれているときは英語とみなす")
(defun google-translate-enja-or-jaen (&optional string)
  "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
  (interactive)
  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring (region-beginning) (region-end)))
              (t
               (save-excursion
                 (let (s)
                   (forward-char 1)
                   (backward-sentence)
                   (setq s (point))
                   (forward-sentence)
                   (buffer-substring s (point)))))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate
     (if asciip "en" "ja")
     (if asciip "ja" "en")
     string)))
(global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)




;; ---
;;
;; multiple-cursors
;; カーソル分身
;; https://github.com/magnars/multiple-cursors.el
;; ---
(require 'multiple-cursors)
;; 指定リージョン全てで分身
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; 指定中のワードで分身
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; ---
;;
;; hlinum
;; いい感じに行数を表示する
;; ---
(require 'hlinum)

(hlinum-activate)
(setq linum-format "%3d ")
(global-linum-mode t)


;; ---
;;
;; auto-complete
;; ---
(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "C-TAB") ;; トリガーキー
(setq ac-use-menu-map t) ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t) ;; 曖昧マッチ


;; ---
;;
;; highlight-symbol
;; ---
(require 'highlight-symbol)
;; 1秒後自動ハイライトされるようになる
(setq highlight-symbol-idle-delay 1.0)
;; 自動ハイライトをしたいならば
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
;; ソースコードにおいてM-p/M-nでシンボル間を移動
(add-hook 'prog-mode-hook 'highlight-symbol-nav-mode)
;; 色をつける（global-hl-line-modeとの兼ね合いで変になるけど...）
(global-set-key [(control f3)] 'highlight-symbol)
;; シンボル置換
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
