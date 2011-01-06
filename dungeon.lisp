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
  
(defun go-up ()
  (let ((new-position (cons (car (player-position *player*)) (+ (cdr (player-position *player*)) 1))))
  
  (if (get-node new-position)
      (move-player new-position)
      (format t "You can't go that way."))))
      
(defun go-down ()
  (let ((new-position (cons (car (player-position *player*)) (- (cdr (player-position *player*)) 1))))
  
  (if (get-node new-position)
      (move-player new-position)
      (format t "You can't go that way."))))
      
(defun go-right ()
  (let ((new-position (cons (+ (car (player-position *player*)) 1) (cdr (player-position *player*)))))
  
  (if (get-node new-position)
      (move-player new-position)
      (format t "You can't go that way."))))
      
(defun go-left ()
  (let ((new-position (cons (- (car (player-position *player*)) 1) (cdr (player-position *player*)))))
  
  (if (get-node new-position)
      (move-player new-position)
      (format t "You can't go that way."))))

(defun move-player (new-position)
  (set-visited new-position)
  (setf (player-position *player*) new-position))
  
(defun quit-game ()
  (setf *running* nil))
  
(defun main-menu ()
  (case (read)
    (up        (go-up))
    (down      (go-down))
    (left      (go-left))
    (right     (go-right))
    (inventory (view-inventory))
    (pickup    (pickup-item))
    (quit      (quit-game))
    (exit      (quit-game))
    (bye       (quit-game))
    (q         (quit-game))
    (t (progn
         (format t "What?")
         (main-menu)))))

(defun game-loop ()
  (draw-map)
  (main-menu)
  (when *running* (game-loop)))
  
(defun new-game ()
  (defparameter *running* t)
  (defparameter *player* (make-player :health 30 :position (cons 3 3)))
  (make-map 25 25)
  (move-player (cons 3 3))
  (game-loop))