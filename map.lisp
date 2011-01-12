(defstruct node (contents nil) (visited nil))

(defun make-map (rows columns)
  (defparameter *map*    (make-hash-table :test 'equal))
  (defparameter *height* rows)
  (defparameter *width*  columns)
  (create-node (1- rows) (1- columns) (1- columns)))

(defun random-contents ()
  nil)

(defun random-node (width height)
  (gethash (cons (random width) (random height)) *map*))
  
(defun create-node (x y rows)
  (if (< x 0)
      nil
      (progn
        (setf (gethash (cons x y) *map*) (make-node :contents (random-contents)))
        (if (= y 0)
            (create-node (1- x) rows rows)
            (create-node x (1- y) rows)))))


(defun get-node (coord)
  (gethash coord *map*))

(defun set-contents (node item)
  (if (consp node)
      (setf (node-contents (get-node node)) item)
      (setf (node-contents node) item)))

(defun set-visited (node)
  (if (consp node)
      (set-visited (get-node node))
      (setf (node-visited node) t)))

(defun pit-p (contents)
  (eql contents 'pit))

(defun content-text (node)
  (if (node-visited node)
      (cond ((item-p    (node-contents node)) (text-color :fg 'yellow :text "i"))
            ((monster-p (node-contents node)) (text-color :fg 'red    :text "M"))
            ((pit-p     (node-contents node)) (text-color :bg 'black  :text " "))
            (t (princ  " ")))
      (princ "#")))

(defun adjust-coord (coord height)
  (cons (1+ (* 2 (car coord))) (- height (cdr coord))))

(defun draw-map ()
  (ansi-clear-screen)
  (text-color :fg 'white :persist t)
  (maphash 
    (lambda (coord node)
      (ansi-goto (adjust-coord coord *height*))
      (content-text node))
    *map*)
  (ansi-goto (adjust-coord (player-position *player*) *height*))
  (text-color :fg 'blue :text "O")
  (revert-text-color)
  (draw-menu *width*)
  (ansi-goto (cons 0 (1+ *height*)))
  (text-color :fg 'black :bg 'white :text (format nil "~%>> ")))
  
  
(defun draw-menu (x)
  (print-menu (+ 3 (* 2 x)) (lambda (line-number) 
                (ansi-goto (cons (+ 3 (* 2 x)) line-number)))))
