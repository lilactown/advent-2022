;;; aoc22-day1 --- Day 1 of AoC 2022
;;; Commentary:
;;; Code:

(require 'seq)

(defun read-file-contents (filepath)
  "Return FILEPATH content as string."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(defun partition-by (f coll)
  "Apply F to each element of COLL, splitting each time F return a new value.
Returns new list of partitions."
  (let ((coll2 nil)
        (partition nil)
        (prev (funcall f (car coll))))
    (dolist (x coll)
      (let ((cur (funcall f x)))
        (if (equal prev cur)
            (push x partition)
          ;; else
          (push partition coll2)
          (setq partition (list x)))
        (setq prev cur)))
    (push partition coll2)))

(defun split-by-elt (elt coll)
  "Partitions COLL by each occurrence of ELT."
  (remove (list elt) (partition-by (lambda (x) (equal elt x)) coll)))

;; (partition-by (lambda (x) x) '(1 1 1 2 2 2 3 3 4 5))
;; ((5) (4) (3 3) (2 2 2) (1 1 1))

;; (split-by 0 '(1 2 3 0 4 5 6 0 7 8 9 10))
;; ((10 9 8 7) (6 5 4) (3 2 1))

(defun day1 (file-contents)
  "Find the Elf carrying the most Calories in FILE-CONTENTS.
How many total Calories is that Elf carrying?"
  (let ((lines (mapcar #'string-to-number (split-string file-contents "\n"))))
    (let ((partitions (split-by-elt 0 lines))) ; "" is mapped to 0
      (seq-reduce
       (lambda (max nums)
         (let ((sum (apply '+ nums)))
           (if (< max sum) sum max)))
       partitions
       0))))

;; (day1 (read-file-contents "example/day1"))
;; 24000

(day1 (read-file-contents "input/day1"))

66186

(defun day2 (file-contents)
  "Find the top three Elves carrying the most Calories in FILE-CONTENTS.
How many Calories are those Elves carrying in total?"
  (let ((lines (mapcar #'string-to-number (split-string file-contents "\n"))))
    (let ((partitions (split-by-elt 0 lines))) ; "" is mapped to 0
      (let ((sums (mapcar (lambda (nums) (apply '+ nums)) partitions)))
        (apply '+ (seq-take (sort sums '>) 3))))))

;; (day2 (read-file-contents "example/day1"))
;; 45000

(day2 (read-file-contents "input/day1"))

196804

(provide 'day1)
;;; day1.el ends here.
