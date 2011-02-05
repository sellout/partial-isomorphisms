(in-package #:partial-isomorphisms)

(defclass isomorphism ()
  ((application :initarg :application :reader application)
   (unapplication :initarg :unapplication :reader unapplication))
  (:metaclass funcallable-standard-class))

(defmethod initialize-instance :after
    ((instance isomorphism) &key application &allow-other-keys)
  (set-funcallable-instance-function instance application))

(defun make-isomorphism (application unapplication)
  (make-instance 'isomorphism
                 :application application :unapplication unapplication))

(defun make-automorphism (function)
  (make-isomorphism function function))

(defgeneric unapply (function arg &rest args)
  (:method ((function isomorphism) arg &rest args)
    (apply (unapplication function) arg args)))

(defgeneric unfuncall (fn &rest args)
  (:method ((fn isomorphism) &rest args)
    (apply (unapplication fn) args)))

(defgeneric inverse (iso)
  (:method ((iso isomorphism))
    (make-isomorphism (unapplication iso) (application iso))))

(defgeneric compose-2 (left right)
  (:method (left right)
    (lambda (&rest args) (funcall left (apply right args))))
  (:method ((iso1 isomorphism) (iso2 isomorphism))
    (make-isomorphism (compose-2 (application iso1) (application iso2))
                      (compose-2 (unapplication iso2) (unapplication iso1)))))

(defun compose (&rest functions)
  (reduce #'compose-2 functions :from-end t))

(defun iso-identity ()
  (make-automorphism #'identity))

(defun tuple (&rest isos)
  (make-isomorphism (lambda (list) (mapcar #'funcall isos list))
                    (lambda (list) (mapcar #'unfuncall isos list))))

(defun associate ()
  (make-isomorphism (lambda (list)
                      (list (list (first list) (first (second list)))
                            (second (second list))))
                    (lambda (list)
                      (cons (caar list) (cons (cadar list) (cdr list))))))

(defun commute ()
  (make-automorphism #'reverse))

(defun unit ()
  (make-isomorphism (lambda (a) (list a))
                    (lambda (a) (if (null (cdr a)) (car a) (error 'meh)))))

(defun element (obj)
  (make-isomorphism (lambda (a) (declare (ignore a)) obj)
                    (lambda (b) (if (eq obj b) nil (signal 'nothing)))))

(defun subset (function)
  (make-automorphism (lambda (obj)
                       (if (funcall function obj) obj (signal 'nothing)))))
