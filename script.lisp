#!/usr/bin/sbcl --script

(format t "running Lisp~% command line argumants are:~%")
(format t "~S~%" sb-ext:*posix-argv*)
