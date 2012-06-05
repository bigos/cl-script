#!/usr/bin/sbcl --script


(defun plural-form (singular)
  (let ((guessed-plural (concatenate 'string singular "s")) (entered-plural))
    (format t "if ~S is correct press Enter, ~%otherwise enter correct version~%" guessed-plural)
    (setq entered-plural (read-line))
    (if (string= "" entered-plural) 
	guessed-plural
	entered-plural)))

(defun show-usage ()
  (format t "Enter Singular form eg. Post~%"))

(defun application (singular plural)
  (format t "~%singular: ~S, plural: ~S~%" singular plural)
  )

(defun main (args)
  (let* ((options (cdr args))
	 (singular-form (car options)))
    (if (string= (car options) "--help")
	(show-usage)	  
	(application singular-form (plural-form singular-form)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(main sb-ext:*posix-argv*)
