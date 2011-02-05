(in-package #:partial-isomorphisms-tests)

(def-suite tests)

(in-suite tests)

(test should-be-isomorphic
  (let ((read/write (make-isomorphism #'read-from-string #'write-to-string))
        (original "42"))
    (is (equal original (unfuncall read/write (funcall read/write original))))))

(test should-invert-isomorphism
  (let ((read/write (make-isomorphism #'read-from-string #'write-to-string))
        (original "42")
        (reversed 42))
    (is (equal original (unfuncall read/write (funcall read/write original))))
    (is (equal original (funcall (inverse read/write) reversed)))))

(test should-also-be-isomorphic
  (let ((original '(1 2 3))
        (reversed '(3 2 1))
        (iso (make-automorphism #'reverse)))
    (is (equal reversed (funcall iso original)))
    (is (equal original (unfuncall iso reversed)))))

(test should-be-automorphic
  (let ((original '(1 2 3))
        (reversed '(3 2 1))
        (iso (make-automorphism #'reverse)))
    (is (equal reversed (funcall iso original)))
    (is (equal original (funcall iso reversed)))))

(test should-tuplize
  (let ((original '((1 2 3) (4 5 6)))
        (reversed '((3 2 1) (4 5 6)))
        (iso (tuple (make-automorphism #'reverse)
                    (make-automorphism #'identity))))
    (is (equal reversed (funcall iso original)))
    (is (equal original (unfuncall iso reversed)))))

(test should-triplize
  (let ((original '((1 2 3) (4 5 6) (7 8 9)))
        (reversed '((3 2 1) (4 5 6) (9 8 7)))
        (iso (tuple (make-automorphism #'reverse)
                    (make-automorphism #'identity)
                    (make-automorphism #'reverse))))
    (is (equal reversed (funcall iso original)))
    (is (equal original (unfuncall iso reversed)))))

(test element-should-work
  (is (equal 42 (funcall (element 42) 42)))
  (is (equal 42 (funcall (element 42) 17)))
  (is (equal nil (unfuncall (element 42) 42)))
  (signals error (unfuncall (element 42) 17)))