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
  (format t  "generated arguments: ~S ~S ~S ~S ~%" sing_camel sing_under plu_camel plu_under)
)


;; def generate(plu_camel,plu_under,sing_camel,sing_under)
;;   methods=[ ['index','all'],
;;             ['show','find',':id'],
;;             ['new','new'],
;;             ['edit','find',':id'],
;;             ['create','new',":#{sing_under}","if @#{sing_under}.save"],
;;             ['update','find',':id',"if @#{sing_under}.update_attributes(params[:#{sing_under}]) "],
;;             ['destroy','find',':id'] ]
;;   conds = "#\n#{4.spaces}else\n#{6.spaces}#\n#{4.spaces}end\n"
;;   r="class #{plu_camel}Controller < ApplicationController\n"
;;   r << 2.spaces+"respond_to :html,:xml\n"
;;   methods.each do |e|
;;     r << 2.spaces+"def #{e[0]}\n"
;;     e[0]=='index' ? obj=plu_under : obj=sing_under
;;     r << 4.spaces+"@#{obj} = #{sing_camel}.#{e[1]}"
;;     e[2] ? r << "(params[#{e[2]}])\n" : r << "\n"
;;     r << 4.spaces+"#{e[3]}\n"+6.spaces+conds if e[3]
;;     r << 4.spaces+"@#{obj}.destroy\n" if e[0]=='destroy'
;;     r << 4.spaces+"respond_with(@#{obj})\n"
;;     r << 2.spaces+"end\n"
;;   end
;;   r << "end\n"
;;   puts r
;; end



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
