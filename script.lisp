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

(defun generate (sing_camel sing_under plu_camel plu_under)
  (format t  "generated arguments: ~S ~S ~S ~S ~%" sing_camel sing_under plu_camel plu_under))

(defun application (singular)
  (let ((plural (plural-form singular)))
    (generate
     singular
     (underscorize singular)
     plural     
     (underscorize plural))))

(defun main (args)
  (let* ((options (cdr args))
	 (singular-form (car options)))
    (if (string= (car options) "--help")
	(format t "Enter singular form eg. Post~%")
	(application singular-form))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(main sb-ext:*posix-argv*)
