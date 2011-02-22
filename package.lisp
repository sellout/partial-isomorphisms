(defpackage partial-isomorphisms
  (:use #:cl #:closer-mop)
  (:shadowing-import-from #:closer-mop
                          #:standard-class
                          #:standard-generic-function #:defgeneric
                          #:standard-method #:defmethod)
  (:export #:isomorphism #:make-isomorphism #:make-automorphism
           #:inverse #:apply #:funcall #:unapply #:unfuncall
           #:compose #:iso-identity
           #:tuple #:associate #:commute #:unit #:element #:subset))

(in-package #:partial-isomorphisms)
