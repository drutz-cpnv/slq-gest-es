SELECT (checking.check_sum >= checking.subject_count) AS is_valid
FROM (SELECT SUM(check_subjects.valid) AS check_sum, AVG(subject_count) AS subject_count
      FROM (SELECT IF(AVG(g.value) < 400, FALSE, TRUE) AS valid, COUNT(subject_id) - 1 AS subject_count, student_id
            FROM grades g
                     LEFT JOIN people s on s.id = g.student_id
                     LEFT JOIN examinations e ON e.id = g.examination_id
                     LEFT JOIN courses c ON c.id = e.course_id
                     LEFT JOIN subjects sub ON sub.id = c.subject_id
            WHERE s.id = 1
              AND e.effective_date BETWEEN (SELECT start_on FROM moments WHERE uid = 'Y2324S1') AND (SELECT end_on FROM moments WHERE uid = 'Y2324S1')
            GROUP BY c.subject_id)
               As check_subjects
      GROUP BY check_subjects.student_id)
         AS checking;

-- SET @statement = (SELECT assert_function FROM test WHERE id = 1);
--
-- PREPARE prepared_stmt FROM @statement;
-- EXECUTE prepared_stmt;

-- create function is_promotable(arg1 int) returns varchar
--     return : SELECT name FROM classes WHERE id = 1
-- ;


-- -------------------------------------------------------------------------
-- Récupération de l'horaire d'une classe en fonction d'une date
-- -------------------------------------------------------------------------

SELECT c.id       AS course_id,
       c.start_at AS course_start_at,
       c.end_at   AS course_end_at,
       c.week_day AS course_start_at,
       s.id       AS subject_id,
       s.name     AS subject_name,
       r.id       AS room_id,
       r.name     AS room_name,
       cl.id      AS class_id,
       cl.name    AS class_name,
       m.uid      as quarter_uid
FROM courses as c
         LEFT JOIN moments m on m.id = c.moment_id
         LEFT JOIN classes cl on cl.id = c.class_id
         LEFT JOIN rooms r on r.id = cl.room_id
         LEFT JOIN subjects s on s.id = c.subject_id
         LEFT JOIN people t on t.id = c.teacher_id
WHERE m.type = 'QUARTER'
  AND :date BETWEEN m.start_on AND m.end_on
  AND class_id = :class_id
ORDER BY c.week_day, c.start_at
;