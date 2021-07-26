pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   -- PreisForschung, AnforderungForschung

   type ForschungListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (
                                            GlobaleDatentypen.Rasse_1 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_2 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_3 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_4 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_5 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_6 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_7 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_8 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_9 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_10 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_11 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_12 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_13 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_14 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_15 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_16 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_17 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_18 =>
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

                                               others => GlobaleKonstanten.LeerForschungListe)
                                           );

   procedure StandardForschungsDatenbankWiederherstellen;

private

   ForschungListeStandard : constant ForschungListeArray := (
                                                             GlobaleDatentypen.Rasse_1 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_2 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_3 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_4 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_5 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_6 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_7 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_8 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_9 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_10 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_11 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_12 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_13 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_14 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_15 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_16 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_17 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_18 =>
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

                                                                others => GlobaleKonstanten.LeerForschungListe)
                                                            );

end ForschungsDatenbank;
