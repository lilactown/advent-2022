;;; aoc22-day2 --- Day 2 of AoC 2022
;;; Commentary:
;;; Code:

(defun read-file-contents (filepath)
  "Return FILEPATH content as string."
  (with-temp-buffer
    (insert-file-contents filepath)
    (buffer-string)))

(defun day2/judge-round (opponent choice)
  (+ (pcase choice
       (:rock 1)
       (:paper 2)
       (:scissor 3))
     (pcase (list opponent
                  choice)
       (`(:rock, :rock) 3)
       (`(:rock, :paper) 6)
       (`(:rock, :scissor) 0)
       (`(:paper, :rock) 0)
       (`(:paper, :paper) 3)
       (`(:paper, :scissor) 6)
       (`(:scissor, :rock) 6)
       (`(:scissor, :paper) 0)
       (`(:scissor, :scissor) 3))))

(defun day2/part1 (file-contents)
  (let ((lines (split-string file-contents "\n"))
        (str->choice '(("A" . :rock)
                       ("B" . :paper)
                       ("C" . :scissor)
                       ("X" . :rock)
                       ("Y" . :paper)
                       ("Z" . :scissor))))
    (apply '+ (mapcar
               (lambda (line)
                 (let ((s (split-string line " ")))
                   (day2/judge-round
                    (cdr (assoc (car s) str->choice))
                    (cdr (assoc (cadr s) str->choice))))) lines))))

(day2/part1 (read-file-contents "example/day2"))

(day2/part1 (read-file-contents "input/day2"))

(defun day2/choose (opponent outcome)
  (pcase (list opponent outcome)
    (`(:rock, :draw) :rock)
    (`(:rock, :win) :paper)
    (`(:rock, :lose) :scissor)
    (`(:paper, :draw) :paper)
    (`(:paper, :win) :scissor)
    (`(:paper, :lose) :rock)
    (`(:scissor, :draw) :scissor)
    (`(:scissor, :win) :rock)
    (`(:scissor, :lose) :paper)))

(defun day2/part2 (file-contents)
  (let ((lines (split-string file-contents "\n"))
        (str->choice '(("A" . :rock)
                       ("B" . :paper)
                       ("C" . :scissor)))
        (str->outcome '(("X" . :lose)
                        ("Y" . :draw)
                        ("Z" . :win))))
    (apply '+ (mapcar
               (lambda (line)
                 (let ((s (split-string line " ")))
                   (let ((opponent (cdr (assoc (car s) str->choice)))
                         (outcome (cdr (assoc (cadr s) str->outcome))))
                     (day2/judge-round
                      opponent
                      (day2/choose opponent outcome)))))
                      lines))))

(day2/part2 (read-file-contents "example/day2"))

(day2/part2 (read-file-contents "input/day2"))

;;; day2.el ends here.
