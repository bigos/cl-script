#!/usr/bin/sbcl --script

(format t "running Lisp~% command line arguments are:~%")
(format t "~S~%" sb-ext:*posix-argv*)
