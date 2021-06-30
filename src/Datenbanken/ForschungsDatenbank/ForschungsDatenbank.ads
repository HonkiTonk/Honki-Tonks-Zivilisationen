pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   -- PreisForschung, AnforderungForschung

   type ForschungListeArray is array (GlobaleDatentypen.Rassen'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (
                                            1 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            2 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            3 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            4 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            5 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            6 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            7 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            8 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            9 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            10 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            11 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            12 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            13 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            14 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            15 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            16 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            17 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe),

                                            18 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 => (100, (others => 0)),
                                               -- Straßen
                                               2 => (100, (others => 0)),
                                               -- Mineralienkunde
                                               3 => (100, (others => 0)),
                                               -- Schrift
                                               4 => (100, (others => 0)),
                                               -- Primitive Werkzeuge
                                               5 => (100, (others => 0)),
                                               -- Rad
                                               6 => (250, (2, 0, 0, 0)),
                                               -- Mathematik
                                               7 => (250, (4, 0, 0, 0)),
                                               -- Metallverarbeitung
                                               8 => (250, (3, 5, 0, 0)),
                                               -- Steinbearbeitung
                                               9 => (250, (5, 0, 0, 0)),
                                               -- Frühe Konstruktionen
                                               10 => (250, (5, 7, 0, 0)),
                                               -- Ägyptisches Nilschiff
                                               11 => (250, (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeererWertForschungListe)
                                           );

   procedure StandardForschungsDatenbankWiederherstellen;

   type RassenAufschlagArray is array (GlobaleDatentypen.Rassen'Range) of Natural;
   RassenAufschlagForschung : constant RassenAufschlagArray := (1 => 0,
                                                                2 => 0,
                                                                3 => 0,
                                                                4 => 0,
                                                                5 => 0,
                                                                6 => 0,
                                                                7 => 0,
                                                                8 => 0,
                                                                9 => 0,
                                                                10 => 0,
                                                                11 => 0,
                                                                12 => 0,
                                                                13 => 0,
                                                                14 => 0,
                                                                15 => 0,
                                                                16 => 0,
                                                                17 => 0,
                                                                18 => 0);

private

   ForschungListeStandard : constant ForschungListeArray := (
                                                             1 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             2 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             3 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             4 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             5 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             6 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             7 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             8 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             9 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             10 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             11 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             12 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             13 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             14 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             15 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             16 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             17 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe),

                                                             18 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 => (100, (others => 0)),
                                                                -- Straßen
                                                                2 => (100, (others => 0)),
                                                                -- Mineralienkunde
                                                                3 => (100, (others => 0)),
                                                                -- Schrift
                                                                4 => (100, (others => 0)),
                                                                -- Primitive Werkzeuge
                                                                5 => (100, (others => 0)),
                                                                -- Rad
                                                                6 => (250, (2, 0, 0, 0)),
                                                                -- Mathematik
                                                                7 => (250, (4, 0, 0, 0)),
                                                                -- Metallverarbeitung
                                                                8 => (250, (3, 5, 0, 0)),
                                                                -- Steinbearbeitung
                                                                9 => (250, (5, 0, 0, 0)),
                                                                -- Frühe Konstruktionen
                                                                10 => (250, (5, 7, 0, 0)),
                                                                -- Ägyptisches Nilschiff
                                                                11 => (250, (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeererWertForschungListe)
                                                            );

end ForschungsDatenbank;
