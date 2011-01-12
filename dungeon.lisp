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
    (k         (go-up))
    (down      (go-down))
    (j         (go-down))
    (left      (go-left))
    (h         (go-left))
    (right     (go-right))
    (l         (go-right))
    (inventory (view-inventory))
    (pickup    (pickup-item))
    (quit      (quit-game))
    (exit      (quit-game))
    (bye       (quit-game))
    (q         (quit-game))
    (t (progn
         (format t "What?")
         (main-menu)))))
         
(defun user-commands ()
  '("Movement:" " up down left right" "Items:" " inventory (View and manage items)" " pickup (Pick up the item at current location)" "Game:" " quit (Exit game)"))         

(defun print-menu (x position-function)
  (funcall position-function 0)
  (format t "~a" (text-color :fg 'blue :text "Commands" :to-string t))
  (let ((line-number 1))
    (mapcar 
      (lambda (line)
        (funcall position-function (incf line-number))
        (text-color :bg 'red :text " ")
        (format t " ~a ~%" line)) 
      (user-commands))
    (ansi-goto (cons x (incf line-number)))
    (format t "~a~%" (text-color :fg 'blue :text "Inventory" :to-string t))
    (mapcar 
      (lambda (item)
        (ansi-goto (cons x (incf line-number)))
        (text-color :bg 'red :text " ")
        (format t "~a" (view-item item))) 
      *inventory*)))

(defun game-loop ()
  (draw-map)
  (main-menu)
  (when *running* (game-loop)))
  
(defun new-game ()
  (defparameter *running* t)
  (defparameter *player* (make-player :health 30 :position (cons 3 3)))
  (make-map 25 25)
  (set-contents (get-node (cons 3 3)) (random-item))
  (loop for i upto 40 do (set-contents (random-node *width* *height*) (random-item)))
  (game-loop))