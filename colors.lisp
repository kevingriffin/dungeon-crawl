; Examples: 
; Print to screen - (format t "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))
; Return a string - (format nil "This will be green:~a This will be red:~a" (green-text "green") (red-text "red"))

(defun ansi-csi ()
  (format nil "~a[" (code-char 27)))
  
(defun ansi-fg-red ()
  (format nil "~a31m" (ansi-csi)))

(defun ansi-fg-black ()
  (format nil "~a30m" (ansi-csi)))
  
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
  
(defun ansi-clear ()
  (format nil "~a0m" (ansi-csi)))
  
(defun red-text (text)
  (format nil "~a~a~a" (ansi-fg-red) text (ansi-fg-black)))

(defun black-text (text)
  (format nil "~a~a~a" (ansi-fg-black) text (ansi-fg-black)))
  
(defun blue-text (text)
  (format nil "~a~a~a" (ansi-fg-blue) text (ansi-fg-black)))

(defun yellow-text (text)
  (format nil "~a~a~a" (ansi-fg-yellow) text (ansi-fg-black)))

(defun green-text (text)
  (format nil "~a~a~a" (ansi-fg-green) text (ansi-fg-black)))

(defun purple-text (text)
  (format nil "~a~a~a" (ansi-fg-purple) text (ansi-fg-black)))