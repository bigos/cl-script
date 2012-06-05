#!/usr/bin/sbcl --script


(defun plural-form (singular)
  (let ((guessed-plural (concatenate 'string singular "s")) (entered-plural))
    (format t "if ~S is correct plural press Enter, ~%otherwise enter correct version~%" guessed-plural)
    (setq entered-plural (read-line))
    (if (string= "" entered-plural) 
	guessed-plural
	entered-plural)))

(defun underscorize (str)
  (let ((myword ""))
    (loop for c across str
       do	 
	 (setq myword (concatenate 'string myword (if (upper-case-p c)
					       (format nil "_~C" (char-downcase c))
					       (format nil "~C" c)))))
    (string-left-trim "_" myword)))

(defun application (singular)
  (let ((plural (plural-form singular)))
    (format t "~%singular: ~S, plural: ~S~%" singular plural)
    (format t "underscorized sing ~S~%" (underscorize singular))
    (format t "underscorized plur ~S~%" (underscorize plural))))

(defun main (args)
  (let* ((options (cdr args))
	 (singular-form (car options)))
    (if (string= (car options) "--help")
	(format t "Enter singular form eg. Post~%")
	(application singular-form))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(main sb-ext:*posix-argv*)
