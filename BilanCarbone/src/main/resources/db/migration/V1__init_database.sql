INSERT INTO public.type (id, created_date, name, parent_id, active, is_deleted, update_date, entreprise_id)
VALUES
    (69, NOW(), 'archived', NULL, true, NULL, NOW(), NULL),
    (21, NOW(), 'Moteur', NULL, true, NULL, NOW(), NULL),
    (22, NOW(), 'Transport', NULL, true, NULL, NULL, NULL),
    (23, NOW(), 'Énergie', NULL, true, NULL, NULL, NULL),
    (24, NOW(), 'Déchets', NULL, true, NULL, NULL, NULL),
    (25, NOW(), 'Matériaux', NULL, true, NULL, NULL, NULL),
    (66, NOW(), 'z', NULL, true, NOW(), NOW(), NULL),
    (78, NOW(), 'ParentType', NULL, true, NULL, NOW(), NULL),
    (37, NOW(), 'Niveau 1', NULL, true, NULL, NULL, NULL),
    (28, NOW(), 'Électricité', 23, true, NULL, NULL, NULL),
    (30, NOW(), 'Déchets Organiques', 24, true, NULL, NULL, NULL),
    (31, NOW(), 'Déchets Non Organiques', 24, true, NULL, NULL, NULL),
    (32, NOW(), 'Acier', 25, true, NULL, NULL, NULL),
    (33, NOW(), 'Béton', 25, true, NULL, NULL, NULL),
    (38, NOW(), 'Niveau 2-A', 37, true, NULL, NULL, NULL),
    (39, NOW(), 'Niveau 2-B', 37, true, NULL, NULL, NULL),
    (41, NOW(), 'Niveau 3-B', 38, true, NULL, NULL, NULL),
    (44, NOW(), 'Niveau 4-B', 41, true, NULL, NULL, NULL),
    (45, NOW(), 'Niveau 4-C', 42, true, NULL, NULL, NULL),
    (42, NOW(), 'Niveau 3-C', 37, true, NULL, NULL, NULL),
    (79, NOW(), 'ChildType1', 78, true, NULL, NOW(), NULL),
    (81, NOW(), 'ChildType2', 78, true, NULL, NULL, NULL),
    (43, NOW(), 'Niveau 4-A', 40, false, NULL, NOW(), NULL),
    (40, NOW(), 'Niveau 3-A', 38, true, NULL, NOW(), NULL),
    (27, NOW(), 'Véhicule Lourd', 22, true, NULL, NOW(), NULL),
    (26, NOW(), 'Véhicule Léger', 22, true, NULL, NOW(), NULL);

INSERT INTO public.facteur (id, created_date, emission_factor, nom, unit, type_id, active, is_deleted, update_date, entreprise_id)
VALUES
    (1, NOW(), 2.50, 'Essence Petit Moteur', 'kM', 21, true, NULL, NOW(), NULL),
    (17, NOW(), 1.20, 'Facteur A', 'HR', 43, false, NULL, NOW(), NULL),
    (2, NOW(), 1.25, 'Électrique Petit Moteur', 'kM', 21, true, NULL, NULL, NULL),
    (8, NOW(), 3.20, 'Essence Véhicule Lourd', 'kM', 27, true, NULL, NULL, NULL),
    (10, NOW(), 0.90, 'Électricité Charbon', 'kWh', 28, true, NULL, NULL, NULL),
    (9, NOW(), 0.02, 'Électricité Nucléaire', 'kWh', 28, true, NULL, NULL, NULL),
    (18, NOW(), 1.50, 'Facteur B', 'HR', 44, true, NULL, NULL, NULL),
    (19, NOW(), 1.80, 'Facteur C', 'HR', 45, true, NULL, NULL, NULL),
    (59, NOW(), 55.00, 'test', 'kM', 26, true, NOW(), NOW(), NULL),
    (53, NOW(), 4.56, 'Factor4', 'kWh', 81, true, NULL, NOW(), NULL),
    (3, NOW(), 3.50, 'Essence Grand Moteur', 'kM', 21, true, NULL, NOW(), NULL),
    (5, NOW(), 2.10, 'Essence Véhicule Léger', 'kM', 26, true, NULL, NOW(), NULL),
    (7, NOW(), 3.80, 'Diesel Véhicule Lourd', 'kM', 27, true, NULL, NOW(), NULL),
    (4, NOW(), 1.50, 'Électrique Grand Moteur', 'kM', 21, true, NULL, NOW(), NULL),
    (6, NOW(), 2.60, 'Diesel Véhicule Léger', 'kM', 26, true, NULL, NOW(), NULL),
    (58, NOW(), 1.70, 'test', 'kM', 27, true, NOW(), NOW(), NULL);

INSERT INTO public.type_facteurs (type_id, facteurs_id)
VALUES
    (21, 1),
    (43, 17),
    (21, 2),
    (27, 8),
    (28, 10),
    (28, 9),
    (44, 18),
    (45, 19),
    (26, 59),
    (81, 53),
    (21, 3),
    (26, 5),
    (27, 7),
    (21, 4),
    (26, 6),
    (27, 58);
INSERT INTO public.entreprise (id, nom, update_date, is_deleted, type, created_date, adresse, bloque)
VALUES
    (1, 'TechCorp', NULL, NULL, 'TECHNOLOGIE', NOW(), '123 Tech Street', false),
    (2, 'HealthSolutions', NULL, NULL, 'SANTE', NOW(), '456 Health Ave', false),
    (3, 'FinanceGroup', NULL, NULL, 'FINANCE', NOW(), '789 Finance Blvd', false),
    (4, 'EduWorld', NULL, NULL, 'EDUCATION', NOW(), '101 Education Lane', false),
    (5, 'AutoServices', NULL, NULL, 'AUTRE', NOW(), '202 Auto Park', false);
