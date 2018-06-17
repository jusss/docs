install auto-complete on emacs for coding auto completion

emacs自带的python-mode再安装auto-complete就能自动补全python代码，不一定非得用jedi,在python-mode里C-c C-z打开个python shell,然后C-c C-c就能直接运行buffer里的代码

;;;put those into ~/.emacs
;;; run  (package-refresh-contents) update content, if some packages are not found, then (package-archives) and (package-initialize)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)



;;;https://github.com/auto-complete/auto-complete
;;;M-x package-install RET auto-complete RET
;;; if there're other errors like ac-update-greedy, try re-instal popup and yasnippet-classic-yasnippet with package-install

(ac-config-default)

;;; then you can run M-x auto-complete in *scratch* buff to enable it or wherever you want to use auto complete



