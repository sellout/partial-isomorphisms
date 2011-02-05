# partial-isomorphisms

Taken from the paper [Invertible Syntax Descriptions: Unifying Parsing and Pretty Printing](http://www.informatik.uni-marburg.de/~rendel/unparse/rendel10invertible.pdf), this paper implements reversible functions.

    > (defvar parser (make-isomorphism #'read-from-string #'write-to-string))
    PARSER
    > (funcall parser "42")
    42
    > (unfuncall parser *)
    "42"

It provides functions `MAKE-ISOMORPHISM` and `MAKE-AUTOMORPHISM`, as well as a number of operators for manipulating them, such as `INVERSE`.
