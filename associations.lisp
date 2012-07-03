#!/usr/bin/sbcl --script

(defvar *last-class*)



(defun process-line (line count)
(format T "~D  ~S~%" count line)
) 


(defun main (filename)
  (let ((count 0))
    (with-open-file (stream filename) 
      (do ((line (read-line stream nil)
		 (read-line stream nil)))
	  ((null line))
	(if (search "class" line)
	    (progn
	      (format T "~%")
	      (setq count (+ 1 count))))
	(process-line line count)))))  


(main "/home/jacek/cl-script/assos1.txt")
