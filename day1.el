;;; aoc22-day1 --- Day 1 of AoC 2022
;;; Commentary:
;;; Code:

(require 'seq)

(defun read-file-contents (filepath)
  "Return FILEPATH content as string."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(defun day1/sum (lst)
  "Computes the sum of all elements of list LST."
  (apply '+ lst))

(defun day1/part1 (file-contents)
  "Find the Elf carrying the most Calories in FILE-CONTENTS.
How many total Calories is that Elf carrying?"
  (let ((sums (mapcar (lambda (s)
                        (day1/sum (mapcar 'string-to-number (split-string s "\n"))))
                      (split-string file-contents "\n\n"))))
    (seq-max sums)))

;; (part1 (read-file-contents "example/day1"))
;; 24000

(day1/part1 (read-file-contents "input/day1"))

66186

(defun day1/part2 (file-contents)
  "Find the top three Elves carrying the most Calories in FILE-CONTENTS.
How many Calories are those Elves carrying in total?"
  (let ((sums (mapcar
               (lambda (s)
                 (day1/sum (mapcar 'string-to-number (split-string s "\n"))))
               (split-string file-contents "\n\n"))))
    (day1/sum (seq-take (sort sums '>) 3))))

;; (day1/part2 (read-file-contents "example/day1"))
;; 45000

(day1/part2 (read-file-contents "input/day1"))

196804

(provide 'aoc22/day1)
;;; day1.el ends here.
