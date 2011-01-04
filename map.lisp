(defstruct node (contents nil) (visited nil))

(defun make-map (rows columns)
  (defparameter *map* (make-hash-table :test 'equal))
  (create-node (1- rows) (1- columns) (1- columns)))

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

(defun set-contents (node item)
  (if (consp node)
      (setf (node-contents (get-node node)) item)
      (setf (node-contents node) item)))


(defun populate-map (new_map)
  (loop for i below (length new_map)
    do (setf (aref new_map i)
             (funcall (nth (random (length *item-builders*))
                           *item-builders*)))))
    
(defun reveal-map (map_history)
  (loop for i below (length map_history)
     do (setf (aref map_history i)
              t)))

(defun draw-map (map_contents map_history rows columns)
  (princ (code-char 27))
  (princ "[")
  (princ "2J")

  (princ (code-char 27))
  (princ "[")
  (princ "0;0H")

  (display-message (player-position *player*))
  (loop for x below rows 
    do (fresh-line)
       (loop for y below columns do (princ "-   "))
       (fresh-line)      
       (loop for y below columns
             do (cond ((equal (player-position *player*) (cons x y)) 
                          (princ "| x "))
                      ((equal (aref map_history (map-index rows columns x y)) nil)
                          (princ "| ? "))
                      ((item-p (aref map_contents (map-index rows columns x y)))
                          (princ "| i "))
                      (t	(princ "|   "))))))
