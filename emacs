----------------------------------------------------------
;;; https://emacs.stackexchange.com/questions/42172/run-elisp-when-async-shell-command-is-done
;;; https://stackoverflow.com/questions/34857843/kill-emacss-async-shell-command-buffer-if-command-is-terminated

(defun my-python-compile ()
  (interactive)
  (if (string-match "^/ssh:.*?:" (buffer-file-name (current-buffer)))
      ;;; if tramp-mode on remote
      (progn
        (write-region (point-min) (point-max) (concat (buffer-file-name) ".tmp"))
        (setq tmp-file (concat
              (substring (buffer-file-name) 
                         (+ 1 (string-match ":/.*" (buffer-file-name)))
                         (length (buffer-file-name)))
              ".tmp"))
        )
      ;;; on local
      (progn (setq tmp-file (concat (buffer-file-name) ".tmp"))
             (write-region (point-min) (point-max) tmp-file)))
  (let* ((proc (progn
                 (async-shell-command (concat "python " tmp-file))
                 (switch-to-buffer-other-window "*Async Shell Command*")
                 (get-buffer-process "*Async Shell Command*"))))
    (if (process-live-p proc)
        (set-process-sentinel proc #'after-async-done)
      (message "No process running."))))

(defun after-async-done (process signal)
  (when (memq (process-status process) '(exit signal))
    (back-to-code-buffer)
    (shell-command-sentinel process signal)))

(defun back-to-code-buffer ()
  (interactive)
  (switch-to-buffer-other-window 
   (substring (car (last (split-string tmp-file "/"))) 0 -4)))

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "<f5>") 'my-python-compile)))

;;; in tramp-mode buffer, M-x shell RET, will open remote shell
(defun my-haskell-compile ()
  (interactive)
  (if (string-match "^/ssh:.*?:" (buffer-file-name (current-buffer)))
      ;;; if tramp-mode on remote
      (progn
        (write-region (point-min) (point-max) (concat (buffer-file-name) ".tmp"))
        (setq tmp-file (concat
              (substring (buffer-file-name) 
                         (+ 1 (string-match ":/.*" (buffer-file-name)))
                         (length (buffer-file-name)))
              ".tmp")))
      ;;; on local
      (progn (setq tmp-file (concat (buffer-file-name) ".tmp"))
             (write-region (point-min) (point-max) tmp-file)))

  (let* ((proc (progn
                 (async-shell-command (concat "runghc " tmp-file))
                 (switch-to-buffer-other-window "*Async Shell Command*")
                 (get-buffer-process "*Async Shell Command*"))))
    (if (process-live-p proc)
        (set-process-sentinel proc #'after-async-done)
      (message "No process running."))))

(electric-indent-mode -1)
(add-hook 'haskell-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-haskell-compile)
      (haskell-indentation-mode -1)
      (haskell-indent-mode 1) ;;; just won't work, I don't know why
     ))
;;; http://haskell.github.io/haskell-mode/manual/latest/Indentation.html#Indentation
;;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(setq compilation-save-buffers-predicate '(lambda () nil))
(setq compilation-always-kill t)

----------------------------------------------
reference 

https://stackoverflow.com/questions/34857843/kill-emacss-async-shell-command-buffer-if-command-is-terminated

What you are looking for is Process Sentinels.

The sentinel for *Async Shell Command* is shell-command-sentinel.

You can advise it:

(defun my-kill-buffer-when-done (process signal)
  (when (and (process-buffer process)
             (memq (process-status process) '(exit signal)))
    (kill-buffer (process-buffer process))))

(defun my-kill-async-buffer-when-done ()
  (let ((process (get-buffer-process "*Async Shell Command*")))
    (add-function :after (process-sentinel process) #'kill-buffer-when-done)))

(add-function :after #'async-shell-command #'my-kill-async-buffer-when-done)

PS. I did not test the above code, mostly because I think it is a horrible idea: you want to examine the content of *Async Shell Command* before killing it. However, I hope reading the code and links above will help you become a more proficient Emacs user.


https://emacs.stackexchange.com/questions/42172/run-elisp-when-async-shell-command-is-done

You can specify the output buffer for async-shell-command. The shell runs as a process of the output buffer. You can get that process with get-buffer-process. Define your own process sentinel for the shell and set it with set-process-sentinel. It is wise to run shell-command-sentinel from your sentinel since that is the sentinel actually set by async-shell-command.

Note that the output buffer may not be associated with any other process when you call async-shell-command. Otherwise an other buffer could be used as process buffer for the shell command (see the documentation of the variable async-shell-command-buffer).

There follows an example:

(defun do-something (process signal)
  (when (memq (process-status process) '(exit signal))
    (message "Do something!")
    (shell-command-sentinel process signal)))

(let* ((output-buffer (generate-new-buffer "*Async shell command*"))
       (proc (progn
               (async-shell-command "sleep 10; echo Finished" output-buffer)
               (get-buffer-process output-buffer))))
  (if (process-live-p proc)
      (set-process-sentinel proc #'do-something)
    (message "No process running.")))
--------------------------------------------------------

emacs neotree, treemacs + projectile + lsp, more look like an IDE
also doom-themes
package install use-package RET

---------------------------------
there's also you can do
`proxychains emacs` to install elpa packages through socks proxy,
this proxy can be proxychains -> ssh -> stunnel -> kcptun -> kcptun:remote -> stunnel -> sshd

--------------------------------------------
C-x C-f /ssh:user@remote#port:/path/to/a.py
this a.py buffer is in tramp-mode
in this buffer, M-& will run async shell command
in this buffer,M-x auto-revert-tail-mode RET runs similarly showing continuous output. 
M-& run `async-shell-command`, in tramp-mode, async-shell-command will auto use remote shell, not local shell
https://www.gnu.org/software/tramp/#Remote-processes

;;; in tramp-mode buffer, M-x shell RET, will open remote shell
(defun my-haskell-compile ()
  (interactive)
  (if (string-match "^/ssh:.*?:" (buffer-file-name (current-buffer)))
      ;;; if tramp-mode on remote
      (progn
        (write-region (point-min) (point-max) (concat (buffer-file-name) ".tmp"))
        (setq tmp-file (concat
              (substring (buffer-file-name) 
                         (+ 1 (string-match ":/.*" (buffer-file-name)))
                         (length (buffer-file-name)))
              ".tmp")))
      ;;; on local
      (progn (setq tmp-file (concat (buffer-file-name) ".tmp"))
             (write-region (point-min) (point-max) tmp-file)))

  (async-shell-command (concat "runghc " tmp-file)))

(electric-indent-mode -1)
(add-hook 'haskell-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-haskell-compile)
      (haskell-indentation-mode -1)
      (haskell-indent-mode 1) ;;; just won't work, I don't know why
     ))

--------------------------------------------------------------------
(substring "/ssh:user@remote:/path/to/files" (string-match ":/.*" "/ssh:user@remote:/path/to/files") nil)
":/path/to/files"


(substring "/ssh:user@remote:/path/to/files" (+ 1 (string-match ":/.*" "/ssh:user@remote:/path/to/files")) (length "/ssh:user@remote:/path/to/files"))
"/path/to/files"


(defun my-python-compile ()
  (interactive)
  (setq tmp-file (concat (buffer-file-name) ".tmp"))
  (write-region (point-min) (point-max) tmp-file)
  (async-shell-command (concat "python " tmp-file)))

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "<f5>") 'my-python-compile)))

(defun my-haskell-compile ()
  (interactive)
  (setq tmp-file (concat (buffer-file-name) ".tmp.hs"))
  (write-region (point-min) (point-max) tmp-file)
  (async-shell-command (concat "runghc " tmp-file)))

(electric-indent-mode -1)
(add-hook 'haskell-mode-hook
	  (lambda () (local-set-key (kbd "<f5>") 'my-haskell-compile)
      (haskell-indentation-mode -1)
      (haskell-indent-mode 1) ;;; just won't work, I don't know why
     ))

this can run python and haskell code in shell mode,you can input 
something to the async shell buffer
----------------------------
in tramp-mode, run M-x shell will open remote shell,
but how to run remote shell command via a key binding?
like press F5 to run "python a.py" in remote, answer is above

--------------------------
<jusss> what this (interactive) do?  [16:51]
<refusenick> jusss: It means you can call the function via M-x  [16:52]
<refusenick> It makes the function interactive.
<jusss> refusenick: ok
<refusenick> C-h f interactive
------------------------------------
<jusss> C-x o I can jump another filed, how I can reverse?
<jusss> jump back?
<str1ngs> jusss: C-u -1 C-x o IIRC  [23:55]
<str1ngs> jusss: I use the switch-window package instead. there is also
          ace-window. switch-window works better with frame
<str1ngs> err frames  [00:05]
<str1ngs> jusss: switch-window will label the windows then you just press
          label for the window you want
############################################
;;; python-mode will not eval python buffer if there is threading code
(defun my-python-compile ()
  (interactive)
  (setq tmp-file (concat (buffer-file-name) ".tmp"))
  (write-region (point-min) (point-max) tmp-file)
  (compile (concat "python " tmp-file)))

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "<f5>") 'my-python-compile)))

(setq compilation-save-buffers-predicate '(lambda () nil))
##################################### 

(set-fontset-font "fontset-default"  
                  'gb18030' ("微软雅黑" . "unicode-bmp"))

 
 
https://segmentfault.com/q/1010000000125755
 

;; ============================================================
;; Setting English Font
(set-face-attribute
 'default nil :font "DejaVu Sans Mono 11")
;; Setting Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
            charset
            (font-spec :family "Microsoft Yahei" :size 14)))

 
 

(set-default-font "Monaco-12")
(set-fontset-font "fontset-default"  
                  'gb18030' ("微软雅黑" . "unicode-bmp")

详细可以看下这里
http://emacser.com/torture-emacs.htm

然后我自己的配置在这里，有兴趣可以参考一下
https://bitbucket.org/lisp/dot-emacs/src/9e3f0ec2acd2432798da5e5d4b4cc35b29c9e3ed/site-lisp/font-settings.el?at=default

-------------------------------
python.el bug, If it's the only thingthen it prints the output but with anything else
it doesn't, Bug #29592 
in python code buffer with python-mode (python.el)
def aha()
  return 9
aha()
press C-c C-c won't show 9 in *Python* repl

but just input 3 and press C-c C-c will show 3 in *Python* repl

and yet I try the same in racket-mode with racket language, and yet the repl
shows whatever it got return,
-----------------------------
;;; auto-complete for coding
(require 'auto-complete)
(add-to-list 'ac-modes 'javascript-mode)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'css-mode)
(add-to-list 'ac-modes 'python-mode)
(add-to-list 'ac-modes 'racket-mode)
(add-to-list 'ac-modes 'scheme-mode)
(ac-config-default)

--------------------------------------------------------
M-x package-refresh-contents
M-x package-list-packages
M-x package-install RET racket-mode RET C-x C-z will open racket
和python-mode一样，C-c C-z调出repl, F5直接求值并显示结果在repl C-c C-c 运行
C-x C-e 求值光标之前的表达式
C-x C-r 求值选择的区域(region也就是C-S-n或M-; M-w)的表达式
或者直接M-x eshell RET racket
---------------------------------
M-x desktop-save  can save the buffers when you leave, or write (desktop-save-mode 1) into .emacs, then use M-x desktop-read to re-open them
-----------------------------------------------------
M-! 和 M-& 可以运行系统指令, M-!会阻塞emacs, M-&是异步执行指令，不阻塞emacs
可以用C-h k M-!来查看该组合键的使用
C-h f function-name 查看函数

M-x ielm 进入elisp
--------------------------------------------------------

M-x package-list or M-x package-list-packages   ;update the packages log
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
M-x pacakge-install RET auto-complete
(ac-config-default)    ; write this into .emacs
~

--------------------------------------------------------
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



