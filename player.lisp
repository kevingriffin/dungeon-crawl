(defstruct player health position)

(defun player-attack-options (player)
  '("punch" "double-swing"))

(defun player-how-many-attacks (self option)
  (case option
    (0 1)    ; punch
    (1 2)))  ; double-swing

(defun player-attack-damage (self option)
  (case option
    (0 3) 	; punch
    (1 5))) ; double-swing

(defun player-get-target (monsters)
  (fresh-line)
  (princ "Which monster? ")
  (let ((target (read)))
    (if (and (integerp target)
             (<= 0 target)
             (< target (length monsters)))
        target
        (player-get-target monsters))))

(defun player-attack (self option monsters)
  (loop for turn below (player-how-many-attacks self option)
        do (let* ((index    (player-get-target monsters))
                  (monster  (nth index monsters))
                  (damage	(player-attack-damage self option)))
 			 (format t "You attack the monster for ~d damage." damage)
             (monster-attacked monster damage))))

(defun player-dies (self)
  (princ "=====  GAME OVER  =====")
  (bye))

(defun lose-health (self health-lost)
  (decf (player-health self) health-lost)
  (when (< (player-health self) 1)
    (player-dies self)))
  
(defun player-attacked (self damage)
  (lose-health self damage))