INSERT INTO moments(uid, start_on, end_on, type) VALUES
    ('Y2425', DATE('2024-08-20'), DATE('2025-07-01'), 'YEAR'),
    ('Y2425S1', DATE('2024-08-20'), DATE('2025-01-15'), 'SEMESTER'),
    ('Y2425S1T1', DATE('2024-08-20'), DATE('2024-11-07'), 'QUARTER');

SET @MOMENT_YEAR = (SELECT id FROM moments WHERE uid = 'Y2425');
SET @ROOM = (SELECT id FROM rooms WHERE name = 'SC-C332');

INSERT INTO classes(uid, name, moment_id, section_id, room_id, master_id)
    VALUES ('si_t2a_2425', 'SI-T2a', @MOMENT_YEAR.id, 1, @ROOM.id, 4);

INSERT INTO classes_students(student_id, class_id)
    SELECT id as student_id, 1
    FROM people
    WHERE type = 'STUDENT';