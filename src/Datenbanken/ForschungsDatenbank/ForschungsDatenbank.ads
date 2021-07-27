pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   type ForschungListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (
                                            GlobaleDatentypen.Rasse_1 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_2 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_3 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_4 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_5 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_6 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_7 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_8 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_9 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_10 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_11 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_12 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_13 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_14 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_15 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_16 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_17 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe),

                                            GlobaleDatentypen.Rasse_18 =>
                                              (
                                               -- Einfache Landwirtschaft
                                               1 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Straßen
                                               2 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Mineralienkunde
                                               3 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Schrift
                                               4 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Primitive Werkzeuge
                                               5 =>
                                                 (PreisForschung       => 100,
                                                  AnforderungForschung => (others => 0)),

                                                 -- Rad
                                               6 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (2, 0, 0, 0)),

                                                 -- Mathematik
                                               7 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (4, 0, 0, 0)),

                                                 -- Metallverarbeitung
                                               8 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (3, 5, 0, 0)),

                                                 -- Steinbearbeitung
                                               9 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 0, 0, 0)),

                                                 -- Frühe Konstruktionen
                                               10 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (5, 7, 0, 0)),

                                                 -- Ägyptisches Nilschiff
                                               11 =>
                                                 (PreisForschung       => 250,
                                                  AnforderungForschung => (0, 0, 0, 0)),

                                               others => GlobaleKonstanten.LeerForschungListe)
                                           );

   procedure StandardForschungsDatenbankWiederherstellen;

private

   ForschungListeStandard : constant ForschungListeArray := (
                                                             GlobaleDatentypen.Rasse_1 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_2 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_3 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_4 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_5 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_6 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_7 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_8 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_9 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_10 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_11 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_12 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_13 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_14 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_15 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_16 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_17 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe),

                                                             GlobaleDatentypen.Rasse_18 =>
                                                               (
                                                                -- Einfache Landwirtschaft
                                                                1 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Straßen
                                                                2 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Mineralienkunde
                                                                3 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Schrift
                                                                4 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Primitive Werkzeuge
                                                                5 =>
                                                                  (PreisForschung       => 100,
                                                                   AnforderungForschung => (others => 0)),

                                                                  -- Rad
                                                                6 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (2, 0, 0, 0)),

                                                                  -- Mathematik
                                                                7 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (4, 0, 0, 0)),

                                                                  -- Metallverarbeitung
                                                                8 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (3, 5, 0, 0)),

                                                                  -- Steinbearbeitung
                                                                9 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 0, 0, 0)),

                                                                  -- Frühe Konstruktionen
                                                                10 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (5, 7, 0, 0)),

                                                                  -- Ägyptisches Nilschiff
                                                                11 =>
                                                                  (PreisForschung       => 250,
                                                                   AnforderungForschung => (0, 0, 0, 0)),

                                                                others => GlobaleKonstanten.LeerForschungListe)
                                                            );

end ForschungsDatenbank;
