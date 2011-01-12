(defstruct monster (health))
(defstruct (hydra (:include monster)))

(defun monster-dead? (monster)
  (< (monster-health monster) 1))


; ==========  HYDRA  ==========
(defun new-hydra ()
  (make-hydra :health (1+ (random 9))))

(defmethod monster-attack ((self hydra))
  (random (hydra-health self)))

(defmethod monster-attacked ((self hydra) damage)
  (decf (hydra-health self) damage))

(defmethod monster-attack-message ((self hydra) damage) 
  (format nil "The hydra bites you with ~d of its heads." damage))

(defmethod monster-die-message ((self hydra))
  (format nil "The headless hydra's falls to the floor, necks writhing."))

(defun hydra-heads (self)
  (hydra-health self))

(defmethod monster-to-str ((self hydra))
  (format nil "A hydra with ~d heads." (hydra-heads self))))
