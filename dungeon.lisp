(load "colors")
(load "map")
(load "items")

(defstruct player health position)

(defun view-inventory ()
  (loop for item across *inventory*
        for i below (length *inventory*)
          do (princ (+ i 1))
          (princ " ")
          (princ (view-item item))
          (fresh-line))
  (princ "Select an item: ")
  NIL)


(defun display-message (position)
  (princ "There is a ")
  (princ (view-item (aref *map* 
                          (map-index *rows*
                                     *columns* 
                                     (car (player-position *player*))
                                     (cdr (player-position *player*))))))
  (princ " here.")
  (fresh-line))

(defun doit () 
  (draw-map *map* *visited* 5 5))

(defun move (direction)
  (let ((player-x (car (player-position *player*)))
        (player-y (cdr (player-position *player*))))
       
  (setf (aref *visited*
              (map-index *rows*
                         *columns*
                         player-x
                         player-y))
        t)
  
  (case direction
    ((up)    (if (equal 0 player-x) 
                 `(wont do it because ,player-x)
                 (setf (player-position *player*)
                       (cons (- player-x 1) player-y))))
    ((down)  (if (equal (- *rows* 1) player-x)
                 `(wont do it because ,player-x)
                 (setf (player-position *player*)
                       (cons (+ player-x 1) player-y))))
    ((left)  (if (equal 0 player-y) 
                 `(wont do it because ,player-y)
                 (setf (player-position *player*)
                       (cons player-x (- player-y 1)))))
    ((right) (if (equal (- *columns* 1) player-y) 
                 `(wont do it because ,player-y)
                 (setf (player-position *player*)
                       (cons player-x (+ player-y 1)))))))
  (doit))

(defun main-menu ()
  (case (read)
    (up        (go-up))
    (down      (go-down))
    (left      (go-left))
    (right     (go-right))
    (inventory (view-inventory))
    (pickup    (pickup-item))
    (t (progn
         (format t "What?")
         (main-menu)))))

(defun game-loop ()
  (draw-board)
  (main-menu)
  (game-loop))
  
(defun new-game ()
  (defparameter *player* (make-player :health 30 :position (cons 3 3)))
  (make-map 5 5)
  (game-loop))