(defun make-cd (artist title rating ripped)
  (list :artist artist :title title :rating rating :ripped ripped))

(defvar *db* nil)

(defun append-record(cd)
  (push cd *db*))

(defun dump-db ()
  (format t "~{~{~a:~10t~a~%~}~}" *db*))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (finish-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
    (prompt-read "Artist")
    (prompt-read "Title")
    (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
    (prompt-read "Ripped [y/n]")))
