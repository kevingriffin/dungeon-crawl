(defun FIGHT! (player monsters)

  ; -----  inner functions  -----
  (labels ((display-intro ()
             (princ "-----  FIGHT TO THE DEATH!  -----")
             (terpri))
	       
           (display-monsters ()
             (loop for monster in monsters
                   for i from 0
                   do (format t "~d. ~a~%" i (monster-to-str monster))))
           
           (options ()
             (player-attack-options player))
                 
           (display-separator ()
             (format t "--------------------------------~%"))
           
           (display-options ()
             (loop for option in (options)
                   for i from 0
                   do (format t "~d. ~a~%" i option)))
           
   		   (valid-option? (option)
             (and (integerp option)
                  (<= 0 option)
                  (< option (length (options)))))
                           
           (get-option ()
             (let ((option (read)))
               (if (valid-option? option)
                   option
                   (get-option))))
                    
           (player-turn ()
			 (display-monsters)
			 (display-separator)
			 (display-options)
             (player-attack player (get-option) monsters))
           
          (monsters-turn ()
            (loop for monster in monsters
                  do (monster-attack monster player)))

           (play-round ()
             (player-turn)
             (monsters-turn)))

    ; -----  steps in a fight  -----
    (display-intro)
    (if (every #'monster-dead? monsters)
        nil
        (play-round))))