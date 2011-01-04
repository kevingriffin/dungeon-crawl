; Examples: 
; Print to screen        - (format t "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Return a string        - (format nil "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Using bakground colors - (format t "~a~a" (red-background (blue-text "test")) (yellow-background (green-text "test")))




(defun puts (&rest lines)
  (loop for line in lines
        do (princ line)
           (fresh-line)))

; name:  symbol, name of the function, ie 'fg-red will define 'ansi-fg-red
; args:  arguments that the function should take
; block: code that evaluates to the ansi code as a string
(defmacro ansi (name args block)
  (labels ((concat-symbols (a b)
             (intern
               (with-output-to-string (s)
                 (princ a s)
                 (princ b s))))          
           (ansi-csi ()
             (format nil "~a[" (code-char 27))))
    `(defun ,(concat-symbols 'ansi- name) ,args
       (format nil "~a~a" ,(ansi-csi) ,block))))


(ansi goto (y x) 
  (format nil "~a;~aH" y x))

(ansi clear         ()  "0m")
(ansi fg-clear      () "39m")

(ansi underline     ()  "4m")
(ansi no-underline  () "24m")

(ansi fg-black      () "30m")
(ansi fg-red        () "31m")
(ansi fg-green      () "32m")
(ansi fg-yellow     () "33m")
(ansi fg-blue       () "34m")
(ansi fg-magenta    () "35m")
(ansi fg-cyan       () "36m")
(ansi fg-white      () "37m")
                    
(ansi bg-black      () "40m")
(ansi bg-red        () "41m")
(ansi bg-green      () "42m")
(ansi bg-yellow     () "43m")
(ansi bg-blue       () "44m")
(ansi bg-magenta    () "45m")
(ansi bg-cyan       () "46m")
(ansi bg-white      () "47m")


(defun red-text (text)
  (format nil "~a~a~a" (ansi-fg-red) text (ansi-fg-clear)))

(defun black-text (text)
  (format nil "~a~a~a" (ansi-fg-black) text (ansi-fg-clear)))
  
(defun blue-text (text)
  (format nil "~a~a~a" (ansi-fg-blue) text (ansi-fg-clear)))

(defun yellow-text (text)
  (format nil "~a~a~a" (ansi-fg-yellow) text (ansi-fg-clear)))

(defun green-text (text)
  (format nil "~a~a~a" (ansi-fg-green) text (ansi-fg-clear)))

(defun purple-text (text)
  (format nil "~a~a~a" (ansi-fg-purple) text (ansi-fg-clear)))