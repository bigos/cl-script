#!/usr/bin/sbcl --script

(format T "models script~%")
(defvar *results* '())
(defvar *filenames* 
  (directory  "/home/jacek/Programming/work/vps/app/models/*.rb"))

(defun process-line (file line)
  ;(format T "~A~%" line)
  (if (search "ActiveRecord" line) (format T "+++++++++++++++++ ~A~%" line))
  (if (or (search "belongs_to :" line)
	  (search "has_one :" line)
	  (search "has_many :" line)
	  )
      (format T "*************** ~A~%" line))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(loop for f in *filenames* do 
     (format T "~%~%PROCESSING... ~A~%~%" f)
(with-open-file (stream f )
  (do ((line (read-line stream nil)
	     (read-line stream nil)))
      ((null line))
    (process-line f line)
    )))
