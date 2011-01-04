(defstruct item)
(defstruct (potion (:include item)) (power 15))
(defstruct (sword  (:include item)) (durability 100) (power 5))
(defstruct (shield (:include item)) (durability 100) (power 7))

(defparameter *inventory* (make-array 10))
(defparameter *item-builders* nil)

(defun no-item
  NIL)

(push #'make-potion *item-builders*)
(push #'make-sword  *item-builders*)
(push #'make-shield *item-builders*)
(push #'no-item     *item-builders*)


(defmethod view-item (item)
  "Empty")

(defmethod view-item ((item potion))
  (concatenate 'string "Potion     " 
                       "Power: " 
                       (prin1-to-string (potion-power item))))

(defmethod view-item ((item sword))
  (concatenate 'string "Sword      " 
                       "Power: " 
                       (prin1-to-string (sword-power item)) 
                       (format nil " ~a: " (green-text "Durability"))
                       (prin1-to-string (sword-durability item))))

(defmethod view-item ((item shield))
  (concatenate 'string "Shield     "
                       "Power: " 
                       (prin1-to-string (shield-power item)) 
                       " Durability: " 
                       (prin1-to-string (shield-durability item))))



(defun pickup-item ()
  (if (and (item-p (node-contents (get-node (player-position *player*))))
           (<= (length *inventory*) 10))
      (progn
        (push (node-contents (get-node (player-position *player*))) *inventory*)
        (setf (node-contents (get-node (player-position *player*))) nil))
      nil))
