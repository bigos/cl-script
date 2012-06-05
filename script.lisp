#!/usr/bin/sbcl --script


(defun run (singular-form)
  (let ((plural-form (concatenate 'string singular-form "s")) (entered-plural))
    (format t "singular-form: ~S~%" singular-form )
    (format t "plural: ~S~%" plural-form)
    (format t "enter preferred plural form or if above plural is correct just press enter: ~%")
    (setq entered-plural (read-line ))
    (format t "you have entered: ~S~%" entered-plural)
    ))



(defun usage ()
  (format t "Enter Singular form eg. Post~%"))

(defun main (args)
  (let ((options (cdr args)))
    (progn
      (if (string= (car options) "--help")
	  (usage)
	  (run (car options))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(main sb-ext:*posix-argv*)
