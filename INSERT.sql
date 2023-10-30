INSERT INTO statuses(slug, title) VALUES ('en_formation', 'En formation'),
                                         ('diplome', 'Diplômé'),
                                         ('abandon', 'Abandon'),
                                         ('retraite', 'Retraité'),
                                         ('a_dispo', 'A disposition'),
                                         ('indisponible', 'Indisponible'),
                                         ('arret_maladie', 'En arrêt maladie'),
                                         ('en_fonction', 'En fonction');

INSERT INTO grades(value, executed_on, examination_id, student_id) VALUES (5.5 * 100, '2023-10-30', 1, 1)