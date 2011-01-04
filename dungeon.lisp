(load "colors")

(defstruct player health position)
(defstruct item)
(defstruct (potion (:include item)) (power 15))
(defstruct (sword (:include item)) (durability 100) (power 5))
(defstruct (shield (:include item)) (durability 100) (power 7))

(defparameter *map*     (make-array 25))
(defparameter *visited* (make-array 25))
(defparameter *rows*    5)
(defparameter *columns* 5)
(defparameter *inventory* (make-array 10))
(defparameter *item-builders* nil)
(defparameter *player* (make-player :position (cons 3 3)))

(setf (aref *map* 17) (make-sword))
(setf (aref *map* 2) (make-shield))
(setf (aref *map* 3) (make-potion))
(setf (aref *map* 10) (make-potion))
(setf (aref *map* 22) (make-potion))
(setf (aref *map* 8) (make-shield))

(setf (aref *inventory* 0) (make-sword))
(setf (aref *inventory* 1) (make-shield))

(defmethod view-item (item)
  "Empty"
)

(defmethod view-item ((item potion))
  (concatenate 'string "Potion     " "Power: " (prin1-to-string (potion-power item)))
)

(defmethod view-item ((item sword))
  (concatenate 'string "Sword      " "Power: " 
  (prin1-to-string (sword-power item)) (format nil " ~a: " (green-text "Durability"))  (prin1-to-string (sword-durability item)))
)

(defmethod view-item ((item shield))
  (concatenate 'string "Shield     " "Power: " 
  (prin1-to-string (shield-power item)) " Durability: " (prin1-to-string (shield-durability item)))
)

(defun pickup-item ()
  (let ((player-x (car (player-position *player*)))
       (player-y (cdr (player-position *player*)))
       )
  
  (loop for i below (length *inventory*)
     do (if (equal (aref *inventory* i) nil)
              (progn
                (setf (aref *inventory* i) (aref *map* (map-index *rows* *columns* player-x player-y)))
                (setf (aref *map* (map-index *rows* *columns* player-x player-y))
                      nil))
              )))
  )

(defun view-inventory ()
  (loop for item across *inventory*
        for i below (length *inventory*)
          do (princ (+ i 1))
          (princ " ")
          (princ (view-item item))
          (fresh-line)
  )
  (princ "Select an item: ")
  NIL
)

(defun draw-map (map_contents map_history rows columns)
  (princ (code-char 27))
  (princ "[")
  (princ "2J")

  (princ (code-char 27))
  (princ "[")
  (princ "0;0H")

    (display-message (player-position *player*))
  (loop for x below rows 
    do 
    (fresh-line)
    (loop for y below columns do (princ "-   "))
    (fresh-line)      
    (loop for y below columns
  		do
        (cond ((equal (player-position *player*) (cons x y)) 
                  (princ "| x "))
              ((equal (aref map_history (map-index rows columns x y)) nil)
                  (princ "| ? "))
              ((item-p (aref map_contents (map-index rows columns x y)))
                  (princ "| i "))
              (t	(princ "|   ")) 
      )))
)

(defun display-message (position)
  (princ "There is a ")
  (princ (view-item (aref *map* (map-index *rows* *columns* 
                                (car (player-position *player*)) (cdr (player-position *player*))))))
  (princ " here.")
  (fresh-line)
)

(defun doit () 
  (draw-map *map* *visited* 5 5)
  )

(defun move (direction)
  (let ((player-x (car (player-position *player*)))
       (player-y (cdr (player-position *player*)))
       )
       
  (setf (aref *visited* (map-index *rows* *columns* player-x player-y)) t)
  (case direction
  ((up)   (if (equal 0 player-x) 
              `(wont do it because ,player-x)
              (setf (player-position *player*) (cons (- player-x 1) player-y))
          )
  )
  ((down) 
        (if (equal (- *rows* 1) player-x) 
                    `(wont do it because ,player-x)
                    (setf (player-position *player*) (cons (+ player-x 1) player-y))
                )
  )
  
  ((left) 
        (if (equal 0 player-y) 
                    `(wont do it because ,player-y)
                    (setf (player-position *player*) (cons player-x (- player-y 1)))
                )
  )
  
  ((right) 
        (if (equal (- *columns* 1) player-y) 
                    `(wont do it because ,player-y)
                    (setf (player-position *player*) (cons player-x (+ player-y 1)))
                )
  )
  ))
  (doit)
)

;return entrance
(defun populate-map (new_map)
  (loop for i below (length new_map)
    do (setf (aref new_map i) (make-item :kind 'potion)))
)
    
(defun reveal-map (map_history)
  (loop for i below (length map_history)
     do (setf (aref map_history i) t))
)

(defun map-index (rows columns row column)
  (+ (* row columns) column ))