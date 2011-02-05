(defpackage partial-isomorphisms-system
  (:use #:cl #:asdf))

(in-package #:partial-isomorphisms-system)

(defsystem partial-isomorphisms
  :description "A library for defining reversible functions."
  :author "Greg Pfeil <greg@technomadic.org>"
  :depends-on (closer-mop)
  :components ((:file "package")
               (:file "partial-isomorphisms" :depends-on ("package")))
  :in-order-to ((test-op (load-op partial-isomorphisms-tests)))
  :perform (test-op :after (op c)
                    (funcall (intern "RUN!" :partial-isomorphisms-tests)
                             (intern "TESTS" :partial-isomorphisms-tests))))

(defmethod operation-done-p ((o test-op)
                             (c (eql (find-system 'partial-isomorphisms))))
  (values nil))

(defsystem partial-isomorphisms-tests
  :depends-on (partial-isomorphisms fiveam)
  :pathname "tests/"
  :components ((:file "package")
               (:file "tests" :depends-on ("package"))))
