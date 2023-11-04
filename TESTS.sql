
-- -----------------------------------------------
-- TEST: Passage d'une classe à une autre
-- -----------------------------------------------

INSERT INTO moments(uid, start_on, end_on, type) VALUES
    ('Y2425', DATE('2024-08-20'), DATE('2025-07-01'), 'YEAR'),
    ('Y2425S1', DATE('2024-08-20'), DATE('2025-01-15'), 'SEMESTER'),
    ('Y2425S1T1', DATE('2024-08-20'), DATE('2024-11-07'), 'QUARTER');

INSERT INTO classes(uid, name, moment_id, section_id, room_id, master_id)
    VALUES ('si_t2a_2425', 'SI-T2a', (SELECT id AS moment_id FROM moments WHERE uid = 'Y2425'), 1, (SELECT id FROM rooms WHERE name = 'SC-C332'), 4);

INSERT INTO students_follow_classes(student_id, class_id)
    SELECT id as student_id, (SELECT id AS class_id FROM classes WHERE uid = 'si_t2a_2425')
    FROM people
    WHERE username IN ('dimitri_rutz' 'andros_terbeck', 'anetta_carne', 'anetta_mehew', 'arda_noades', 'ardelia_dolley', 'ardys_gostyke', 'arleen_spincke', 'ashley_ellwood', 'aubine_o_fihily', 'auguste_whyman', 'avery_lux', 'berna_nissle', 'bernadene_kleinmintz', 'berny_dalli', 'bertie_overshott', 'bessy_cough', 'bibbie_geere', 'billie_devanny', 'blanca_loughead', 'bunny_harcarse', 'camella_lind');



-- -----------------------------------------------
-- TEST: Redoublement d'un élève
-- -----------------------------------------------

INSERT INTO classes(uid, name, moment_id, section_id, room_id, master_id)
VALUES ('si_t1a_2425', 'SI-T1a', (SELECT id AS moment_id FROM moments WHERE uid = 'Y2425'), 1, (SELECT id FROM rooms WHERE name = 'SC-C331'), 4);

INSERT INTO students_follow_classes(student_id, class_id)
    SELECT id as student_id, (SELECT id AS class_id FROM classes WHERE uid = 'si_t1a_2425')
    FROM people
    WHERE username = 'dimitri_rutz';

SELECT username, name as class, start_on AS year_start, end_on AS year_end FROM people p
    LEFT JOIN students_follow_classes cs ON p.id = cs.student_id
    LEFT JOIN classes c ON cs.class_id = c.id
    LEFT JOIN moments m ON c.moment_id = m.id
WHERE username = 'dimitri_rutz';



-- -------------------------------------------------------------
-- TEST: Récupération des notes d'un étudiant pour un semestre
-- -------------------------------------------------------------

SELECT e.title AS title, g.value / 100 AS value, e.effective_date AS date, s.name AS subject FROM people
    LEFT JOIN grades g ON people.id = g.student_id
    LEFT JOIN examinations e ON g.examination_id = e.id
    LEFT JOIN courses c ON e.course_id = c.id
    LEFT JOIN subjects s ON c.subject_id = s.id
    JOIN moments m ON m.uid = 'Y2324S1'
WHERE username = 'dimitri_rutz' AND e.effective_date BETWEEN m.start_on AND m.end_on
