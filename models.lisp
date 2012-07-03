#!/usr/bin/sbcl --script

(format T "models script~%")
(defvar *results* '())


(defun process-line (file line count)
					;(format T "~A~%" line)
  (if (search "ActiveRecord" line) 
      (format T "~A~%"  line ))
  (if (or (search "belongs_to" line)
	  (search "has_one" line)
	  (search "has_many" line)
	  (search "has_and" line))
      (if (search ":through" line)
	  (format T "    ~A~%" line) 
	  (format T "    ~A~%" line))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
( defun main (models-path)
  (let ((count 0)	
	(filenames (directory models-path )))
    (loop for f in filenames do 
	 ;(format T "~%~%~D  PROCESSING... ~A~%~%" count f)
	 (setq count (+ 1 count))
	 (with-open-file (stream f )
	   (do ((line (read-line stream nil)
		      (read-line stream nil)))
	       ((null line))
	     (process-line f line count)
	     )))))

(main "/home/jack/vps/app/models/*.rb")
