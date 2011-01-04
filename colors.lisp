; Examples: 
; Print to screen        - (format t "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Return a string        - (format nil "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Using bakground colors - (format t "~a~a" (red-background (blue-text "test")) (yellow-background (green-text "test")))

(defun ansi-csi ()
  (format nil "~a[" (code-char 27)))

(defun ansi-clear ()
  (format nil "~a0m" (ansi-csi)))

(defun ansi-fg-red ()
  (format nil "~a31m" (ansi-csi)))

(defun ansi-fg-black ()
  (format nil "~a30m" (ansi-csi)))
  
(defun ansi-fg-clear ()
  (format nil "~a39m" (ansi-csi)))
  
(defun ansi-fg-blue ()
  (format nil "~a34m" (ansi-csi)))
  
(defun ansi-fg-green ()
  (format nil "~a32m" (ansi-csi)))
  
(defun ansi-fg-yellow ()
  (format nil "~a33m" (ansi-csi)))
  
(defun ansi-fg-purple ()
  (format nil "~a35m" (ansi-csi)))
  
(defun ansi-bg-red ()
  (format nil "~a41m" (ansi-csi)))

(defun ansi-bg-black ()
  (format nil "~a40m" (ansi-csi)))
  
(defun ansi-bg-blue ()
  (format nil "~a44m" (ansi-csi)))
  
(defun ansi-bg-green ()
  (format nil "~a42m" (ansi-csi)))
  
(defun ansi-bg-yellow ()
  (format nil "~a43m" (ansi-csi)))
  
(defun ansi-bg-purple ()
  (format nil "~a45m" (ansi-csi)))

(defun ansi-bg-clear ()
  (format nil "~a49m" (ansi-csi)))

(defun red-background (text)
  (format nil "~a~a~a" (ansi-bg-red) text (ansi-bg-clear)))

(defun black-background (text)
  (format nil "~a~a~a" (ansi-bg-black) text (ansi-bg-clear)))
  
(defun blue-background (text)
  (format nil "~a~a~a" (ansi-bg-blue) text (ansi-bg-clear)))
  
(defun yellow-background (text)
  (format nil "~a~a~a" (ansi-bg-yellow) text (ansi-bg-clear)))
  
(defun green-background (text)
  (format nil "~a~a~a" (ansi-bg-green) text (ansi-bg-clear)))

(defun purple-background (text)
  (format nil "~a~a~a" (ansi-bg-purple) text (ansi-bg-clear)))
  
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