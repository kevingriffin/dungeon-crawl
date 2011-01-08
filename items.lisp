(defstruct item)
(defstruct (potion (:include item)) (power 15))
(defstruct (sword  (:include item)) (durability 100) (power 5))
(defstruct (shield (:include item)) (durability 100) (power 7))

(defparameter *inventory*     ())
(defparameter *item-builders* nil)

(defun no-item
  NIL)

(push #'make-potion *item-builders*)
(push #'make-sword  *item-builders*)
(push #'make-shield *item-builders*)
(push #'no-item     *item-builders*)

(defun durability-text (durability)
  (cond ((> durability 70)                          (text-color :fg 'green  :text durability :to-string t))
        ((and (> durability 40) (<= durability 70)) (text-color :fg 'yellow :text durability :to-string t))
        (t                                          (text-color :fg 'red    :text durability :to-string t))))

(defun random-item ()
  (funcall (nth (random (length *item-builders*)) *item-builders*)))

(defmethod view-item (item)
  "Empty")

(defmethod view-item ((item potion))
  (concatenate 'string "Potion     " 
                       "Power " 
                       (text-color :fg 'magenta :text (potion-power item) :to-string t)))

(defmethod view-item ((item sword))
  (concatenate 'string "Sword      " 
                       "Power "
                       (text-color :fg 'magenta :text (sword-power item) :to-string t) 
                       " Durability "
                       (durability-text (sword-durability item))))

(defmethod view-item ((item shield))
  (concatenate 'string "Shield     "
                       "Power " 
                       (text-color :fg 'magenta :text (shield-power item) :to-string t) 
                       " Durability " 
                       (durability-text (shield-durability item))))

(defun pickup-item ()
  (if (and (item-p (node-contents (get-node (player-position *player*))))
           (<= (length *inventory*) 10))
      (progn
        (push (node-contents (get-node (player-position *player*))) *inventory*)
        (setf (node-contents (get-node (player-position *player*))) nil))
      nil))
