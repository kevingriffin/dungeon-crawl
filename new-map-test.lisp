(defparameter *map* (make-hash-table))
(defstruct node (contents nil) (visited nil))

(defun make-map (rows columns)
  (create-node rows columns columns))

(defun random-contents ()
  nil)
  
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