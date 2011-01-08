; Usage:
; (text-color :fg red :persist t "test")
; test(printed in red)
; ---any other text printed here will be red---
; (revert-text-color)

; (text-color :fg green :persist t) - printed text will be green until (revert-text-color) is called
; (text-color :fg blue "test2")  - test2 will be printed in blue and then the color will be reverted
  
(defparameter *color-stack* (list (format nil "~a[0m" (code-char 27))))

(defun color-stack-text ()
  (labels ((make-text (lst text)
             (if lst
                 (make-text (cdr lst) (concatenate 'string (car lst) text))
                 text)))
          (make-text *color-stack* "")))

(defun ansi-fg (color)
  (case color
    (black  "30")
    (red    "31")
    (green  "32")
    (yellow "33")
    (blue   "34")
    (magenta"35")
    (cyan   "36")
    (white  "37")
    (t      "39")))

(defun ansi-bg (color)
  (case color
    (black  "40")
    (red    "41")
    (green  "42")
    (yellow "43")
    (blue   "44")
    (magenta"45")
    (cyan   "46")
    (white  "47")
    (t      "49")))
  
(defun ansi-color (&optional (fg "39") (bg "49"))
  (format nil "~a[~a;~am" (code-char 27) fg bg))

(defun revert-text-color ()
  (if (> (length *color-stack*) 1)
      (progn
        (pop *color-stack*)
        (text-color))
      nil))
  
(defun text-color (&key fg bg persist text to-string)
  (push (ansi-color (ansi-fg fg) (ansi-bg bg))  *color-stack*)
  (if to-string
      (if persist
          (format nil "~a~a" (color-stack-text) text)
          (progn
            (let ((start-text (format nil "~a~a" (color-stack-text) text)))
                 (pop *color-stack*)
                 (concatenate 'string start-text (color-stack-text)))))
      (progn
        (when text (format t "~a~a" (color-stack-text) text))
        (unless persist (pop *color-stack*))
        (format t "~a" (color-stack-text)))))

(defun ansi-clear-screen ()
  (format t "~a[2J" (code-char 27)))
  
(defun ansi-goto (coord)
  (format t "~a[~a;~aH" (code-char 27) (cdr coord) (car coord)))

(defun ansi-clear-screen ()
  (format t "~a[2J" (code-char 27)))
