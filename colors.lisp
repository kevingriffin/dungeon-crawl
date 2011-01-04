; Examples: 
; Print to screen        - (format t "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Return a string        - (format nil "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Using bakground colors - (format t "~a~a" (red-background (blue-text "test")) (yellow-background (green-text "test")))





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


(ansi underline () "4m" )

(ansi goto (y x) 
  (format nil "~a;~aH" y x))

(defun puts (&rest lines)
  (loop for line in lines
        do (princ line)
           (fresh-line)))

(ansi fg-red    ( &key underline ) (concatenate 'string "31m" (if underline (ansi-underline) "")))
(ansi fg-black  ( &key underline ) (concatenate 'string "30m" (if underline (ansi-underline) "")))
(ansi fg-clear  ( &key underline ) (concatenate 'string "39m" (if underline (ansi-underline) "")))  
(ansi fg-blue   ( &key underline ) (concatenate 'string "34m" (if underline (ansi-underline) "")))
(ansi fg-green  ( &key underline ) (concatenate 'string "32m" (if underline (ansi-underline) "")))
(ansi fg-yellow ( &key underline ) (concatenate 'string "33m" (if underline (ansi-underline) "")))
(ansi fg-purple ( &key underline ) (concatenate 'string "35m" (if underline (ansi-underline) "")))
(ansi bg-red    ( &key underline ) (concatenate 'string "41m" (if underline (ansi-underline) "")))
(ansi bg-black  ( &key underline ) (concatenate 'string "40m" (if underline (ansi-underline) "")))
(ansi bg-blue   ( &key underline ) (concatenate 'string "44m" (if underline (ansi-underline) "")))
(ansi bg-green  ( &key underline ) (concatenate 'string "42m" (if underline (ansi-underline) "")))
(ansi bg-yellow ( &key underline ) (concatenate 'string "43m" (if underline (ansi-underline) "")))
(ansi bg-purple ( &key underline ) (concatenate 'string "45m" (if underline (ansi-underline) "")))
(ansi bg-white  ( &key underline ) (concatenate 'string "47m" (if underline (ansi-underline) "")))
(ansi clear     ( &key underline ) (concatenate 'string  "0m" (if underline (ansi-underline) "")))


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