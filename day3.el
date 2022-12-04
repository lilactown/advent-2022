;;; aoc22/day3 --- Day 3 of AoC 2022
;;; Commentary:
;;; Code:

(defun read-file-contents (filepath)
  "Return FILEPATH content as string."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(require 'seq)

(defun seq-split (sequence &optional n)
  (let ((n (or n (/ (length sequence) 2))))
    (let ((left (seq-take sequence n))
          (right (seq-drop sequence n)))
      (list left right))))

(require 'dash) ;; thread-last
(require 'cl-lib) ;; cl-mapcar / cl-intersection

(defun day3/part1 (file-contents)
  (let ((char->priority (cl-mapcar
                         'cons
                         "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         (number-sequence 1 52))))
    (->> (split-string file-contents "\n")
         (mapcar
          (lambda (line)
            (mapcar (lambda (c) (alist-get c char->priority))
                    line)))
         (mapcan
          (lambda (line)
            (let ((parts (seq-split line)))
              (cl-intersection
               (seq-uniq (car parts))
               (seq-uniq (cadr parts))))))
         (apply '+))))

(day3/part1 (read-file-contents "example/day3"))

(day3/part1 (read-file-contents "input/day3"))

(defun day3/part2 (file-contents)
  (let ((char->priority (cl-mapcar
                         'cons
                         "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         (number-sequence 1 52))))
    (->> (split-string file-contents "\n")
         (mapcar
          (lambda (line)
            (->> line
                 (mapcar (lambda (c) (alist-get c char->priority)))
                 (seq-uniq))))
         (-partition 3)
         (mapcan
          (lambda (parts)
            (cl-intersection
             (car parts)
             (cl-intersection
              (cadr parts)
              (caddr parts)))))
         (apply '+))))

(day3/part2 (read-file-contents "example/day3"))

(day3/part2 (read-file-contents "input/day3"))

;;; day3.el ends here.
