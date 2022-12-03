(defun read-file-contents (filepath)
  "Return FILEPATH content as string."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(defun seq-split (sequence &optional n)
  (let ((n (or n (/ (length sequence) 2))))
    (let ((left (seq-take sequence n))
          (right (seq-drop sequence n)))
      (list left right))))

(require 'a) ;; a-get / a-reduce-kv
(require 'dash) ;; thread-last
(require 'cl-lib) ;; cl-intersection

(defun dups (sequence)
  (let ((seen (make-hash-table)))
    (dolist (x sequence)
      (incf (gethash x seen 0)))
    (a-reduce-kv
     (lambda (dups k v)
       (if (< 1 v) (cons k dups) dups))
     nil seen)))

(defun part1 (file-contents)
  (let ((char->priority (mapcar*
                         'cons
                         "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         (number-sequence 1 52))))
    (->> (split-string file-contents "\n")
         (mapcar
          (lambda (line)
            (mapcar (lambda (c) (a-get char->priority c))
                    line)))
         (mapcan
          (lambda (line)
            (let ((parts (mapcar 'seq-uniq (seq-split line))))
              (dups (apply 'append parts)))))
         (apply '+))))

(part1 (read-file-contents "example/day3"))

(part1 (read-file-contents "input/day3"))

(defun part2 (file-contents)
  (let ((char->priority (mapcar*
                         'cons
                         "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         (number-sequence 1 52))))
    (->> (split-string file-contents "\n")
         (mapcar
          (lambda (line)
            (->> line
                 (mapcar (lambda (c) (a-get char->priority c)))
                 (-uniq))))
         (-partition 3)
         (mapcan
          (lambda (parts)
            (cl-intersection
             (car parts)
             (cl-intersection
              (cadr parts)
              (caddr parts)))))
         (apply '+))))

(part2 (read-file-contents "example/day3"))

(part2 (read-file-contents "input/day3"))
