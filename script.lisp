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

(defun spaces (num)
  (make-string num :initial-element #\space))

(defun generate (sing_camel sing_under plu_camel plu_under)  
  (let ((methods `(("index" "all")
		   ("show" "find" "id")
		   ("new" "new")
		   ("edit" "find" "id")
		   ("create" "new" ,sing_under
			     ,(format nil "if @~A.save" sing_under))
		   ("update" "find" "id"
			     ,(format nil "if @~A.update_attributes(params[:~A])" sing_under sing_under))
		   ("destroy" "find" "id")))	
	(r (format nil "class ~AController < ApplicationController~%  respond_to :html :xml" plu_camel))
	(obj))    
    (dolist (e methods)      
      (setq r (concatenate 'string r (format nil "~2&~%~2Tdef ~A~%" (first e))))
      (if (string= "index" (first e))  (setq obj plu_under)  (setq obj sing_under))

      (setq r (concatenate 'string r (format nil "~4T@~A = ~A.~A" obj sing_camel (second e)  ))) 
  
      (setq r (concatenate 'string r (if (third e) (format nil "(params[:~A])" (third e)))))

      (if (fourth e) 
	  (setq r (concatenate 'string r (format nil "~2&~4T~A~%~6T#~%~4Telse~%~6T#~%~4Tend" (fourth e))))
)
      (if (string= "destroy" (first e)) (setq r (concatenate 'string r (format nil "~2&~4T@~A.destroy" obj))))
      (setq r (concatenate 'string r (format nil "~2&~4Trespond_with(@~A)"   obj)))
      (setq r (concatenate 'string r (format nil "~%~2Tend" )))
      )
    (setq r (concatenate 'string r (format nil "~%end~%")))
    (format t "~A~%" r)
    ))

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
    (if (or (string= (car options) "--help") (eq options NIL))
	(format t "Enter singular form as an argument, eg.  $ script.lisp Post~%")
	(application singular-form))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(main sb-ext:*posix-argv*)
