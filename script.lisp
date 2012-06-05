#!/usr/bin/sbcl --script


(defun plural-form (singular)
  (let ((guessed-plural (concatenate 'string singular "s")) (entered-plural))
    (format t "if ~S is correct plural press Enter, ~%otherwise enter correct version~%" guessed-plural)
    (setq entered-plural (read-line))
    (if (string= "" entered-plural) 
	guessed-plural
	entered-plural)))

(defun application (singular plural)
  (format t "~%singular: ~S, plural: ~S~%" singular plural)
  )

(defun main (args)
  (let* ((options (cdr args))
	 (singular-form (car options)))
    (if (string= (car options) "--help")
	(format t "Enter Singular form eg. Post~%")
	(application singular-form (plural-form singular-form)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(main sb-ext:*posix-argv*)
