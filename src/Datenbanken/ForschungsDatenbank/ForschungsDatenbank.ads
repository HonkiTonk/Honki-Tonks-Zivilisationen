pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package ForschungsDatenbank is

   type ForschungListeArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range, GlobaleDatentypen.ForschungID'Range) of DatenbankRecords.ForschungListeRecord;
   ForschungListe : ForschungListeArray := (
                                            GlobaleDatentypen.Menschen =>
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

                                            GlobaleDatentypen.Maschinen =>
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

                                            GlobaleDatentypen.Biber =>
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

                                            GlobaleDatentypen.Wölfe =>
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

                                            GlobaleDatentypen.Fischotter =>
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

                                            GlobaleDatentypen.Marderhund =>
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

                                            GlobaleDatentypen.Wildschwein =>
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

                                            GlobaleDatentypen.Waschbär =>
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

                                            GlobaleDatentypen.Maulwurf =>
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

                                            GlobaleDatentypen.Ziesel =>
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

                                            GlobaleDatentypen.Spinnen =>
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

                                            GlobaleDatentypen.Steinbock =>
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

                                            GlobaleDatentypen.Greifvögel =>
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

                                            GlobaleDatentypen.Fische =>
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

                                            GlobaleDatentypen.Schlangen =>
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

                                            GlobaleDatentypen.Salamander =>
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

                                            GlobaleDatentypen.Pflanzen =>
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

                                            GlobaleDatentypen.Igel =>
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

   procedure StandardForschungsDatenbankLaden;

private

   ForschungListeStandard : constant ForschungListeArray := (
                                                             GlobaleDatentypen.Menschen =>
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

                                                             GlobaleDatentypen.Maschinen =>
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

                                                             GlobaleDatentypen.Biber =>
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

                                                             GlobaleDatentypen.Wölfe =>
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

                                                             GlobaleDatentypen.Fischotter =>
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

                                                             GlobaleDatentypen.Marderhund =>
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

                                                             GlobaleDatentypen.Wildschwein =>
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

                                                             GlobaleDatentypen.Waschbär =>
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

                                                             GlobaleDatentypen.Maulwurf =>
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

                                                             GlobaleDatentypen.Ziesel =>
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

                                                             GlobaleDatentypen.Spinnen =>
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

                                                             GlobaleDatentypen.Steinbock =>
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

                                                             GlobaleDatentypen.Greifvögel =>
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

                                                             GlobaleDatentypen.Fische =>
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

                                                             GlobaleDatentypen.Schlangen =>
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

                                                             GlobaleDatentypen.Salamander =>
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

                                                             GlobaleDatentypen.Pflanzen =>
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

                                                             GlobaleDatentypen.Igel =>
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
