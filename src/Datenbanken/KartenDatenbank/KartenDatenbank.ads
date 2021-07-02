pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   
   -- KartenGrafik, Passierbarkeit
   -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus
   
   type KartenListeArray is array (GlobaleDatentypen.KartenGrund'Range) of DatenbankRecords.KartenListeRecord;
   KartenListe : KartenListeArray := (
                                      -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                      0 => GlobaleKonstanten.LeererWertKartenListe,
                                      
                                      -- Eis
                                      1 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            0, 0, 0, 1, 0),
                                      -- Wasser
                                      2 => (' ', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                            1, 0, 1, 1, 0),
                                      -- Ebene
                                      3 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            2, 1, 1, 0, 0),
                                      -- Tundra
                                      4 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            1, 2, 1, 1, 0),
                                      -- Wüste
                                      5 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            0, 1, 1, 1, 0),
                                      -- Hügel, Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                      6 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            1, 2, 1, 0, 1),
                                      -- Gebirge
                                      7 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            0, 3, 1, 1, 2),
                                      -- Wald
                                      8 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            1, 2, 1, 1, 1),
                                      -- Dschungel
                                      9 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                            1, 3, 1, 1, 2),
                                      -- Kohle = Ressource 1
                                      10 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                             0, 2, 1, 0, 0),
                                      -- Eisen = Ressource 2
                                      11 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                             0, 2, 1, 0, 0),
                                      -- Öl = Ressource 3
                                      12 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                             0, 2, 1, 0, 0),
                                      -- Hochwertiger Boden = Ressource 4
                                      13 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                             2, 1, 1, 0, 0),
                                      -- Flußkreuzung
                                      14 => ('╋', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Fluß waagrecht
                                      15 => ('━', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Fluß senkrecht
                                      16 => ('┃', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkurve
                                      17 => ('┏', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkurve
                                      18 => ('┓', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkurve
                                      19 => ('┗', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkurve
                                      20 => ('┛', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkreuzung
                                      21 => ('┻', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkreuzung
                                      22 => ('┳', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkreuzung
                                      23 => ('┣', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußkreuzung
                                      24 => ('┫', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußendstück links
                                      25 => ('╺', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußendstück rechts
                                      26 => ('╸', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußendstück unten
                                      27 => ('╹', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Flußendstück oben
                                      28 => ('╻', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1),
                                      -- Fisch = WasserRessource 1
                                      29 => ('≈', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                             2, 0, 1, 0, 0),
                                      -- Wal = WasserRessource 2
                                      30 => ('≈', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                             2, 1, 2, 0, 0),
                                      -- Küsten/Seegewässer
                                      31 => (' ', (2 => True, 3 => True, 4 => True, 5 => True, others => False),
                                             2, 0, 1, 0, 0),
                                      -- Sumpf
                                      32 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 1, 1, 1, 2),
                                      -- Gold = Ressource 5
                                      33 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                             0, 1, 3, 0, 0),
                                      -- Hügel mit (Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?)
                                      34 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Erde, soll das doppelt drin sein oder kann das raus?
                                      35 => (' ', (1 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Lava
                                      36 => (' ', (7 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Wolken
                                      37 => (' ', (3 => True, 4 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Weltraum
                                      38 => (' ', (4 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Erde
                                      39 => (' ', (6 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Gestein
                                      40 => (' ', (6 => True, others => False),
                                             0, 0, 0, 0, 0),
                                      -- Wasser für Unterwasser
                                      41 => (' ', (5 => True, others => False),
                                             1, 0, 1, 1, 0),
                                      -- Küsten/Seegewässer für Unterwasser
                                      42 => (' ', (5 => True, others => False),
                                             2, 0, 1, 0, 0),
                                      -- Fluß einzeln
                                      43 => ('▪', (1 => True, 3 => True, 4 => True, others => False),
                                             1, 0, 1, 0, 1)
                                     );
   
   procedure StandardKartenDatenbankWiederherstellen;
   
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   
   -- KartenGrafik, Passierbarkeit
   -- Nahrungsgewinnung, Ressourcengewinnung, Geldgewinnung, Wissensgewinnung, Verteidigungsbonus
   
private
   
   KartenListeStandard : constant KartenListeArray := (
                                                       -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                       0 => GlobaleKonstanten.LeererWertKartenListe,
                                      
                                                       -- Eis
                                                       1 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             0, 0, 0, 1, 0),
                                                       -- Wasser
                                                       2 => (' ', (2 => True, 3 => True, 4 => True, others => False),
                                                             1, 0, 1, 1, 0),
                                                       -- Ebene
                                                       3 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             2, 1, 1, 0, 0),
                                                       -- Tundra
                                                       4 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             1, 2, 1, 1, 0),
                                                       -- Wüste
                                                       5 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             0, 1, 1, 1, 0),
                                                       -- Hügel, Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                       6 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             1, 2, 1, 0, 1),
                                                       -- Gebirge
                                                       7 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             0, 3, 1, 1, 2),
                                                       -- Wald
                                                       8 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             1, 2, 1, 1, 1),
                                                       -- Dschungel
                                                       9 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                             1, 3, 1, 1, 2),
                                                       -- Kohle = Ressource 1
                                                       10 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                              0, 2, 1, 0, 0),
                                                       -- Eisen = Ressource 2
                                                       11 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                              0, 2, 1, 0, 0),
                                                       -- Öl = Ressource 3
                                                       12 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                              0, 2, 1, 0, 0),
                                                       -- Hochwertiger Boden = Ressource 4
                                                       13 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                              2, 1, 1, 0, 0),
                                                       -- Flußkreuzung
                                                       14 => ('╋', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Fluß waagrecht
                                                       15 => ('━', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Fluß senkrecht
                                                       16 => ('┃', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkurve
                                                       17 => ('┏', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkurve
                                                       18 => ('┓', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkurve
                                                       19 => ('┗', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkurve
                                                       20 => ('┛', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkreuzung
                                                       21 => ('┻', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkreuzung
                                                       22 => ('┳', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkreuzung
                                                       23 => ('┣', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußkreuzung
                                                       24 => ('┫', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußendstück links
                                                       25 => ('╺', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußendstück rechts
                                                       26 => ('╸', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußendstück unten
                                                       27 => ('╹', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Flußendstück oben
                                                       28 => ('╻', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1),
                                                       -- Fisch = WasserRessource 1
                                                       29 => ('≈', (2 => True, 3 => True, 4 => True, others => False),
                                                              2, 0, 1, 0, 0),
                                                       -- Wal = WasserRessource 2
                                                       30 => ('≈', (2 => True, 3 => True, 4 => True, others => False),
                                                              2, 1, 2, 0, 0),
                                                       -- Küsten/Seegewässer
                                                       31 => (' ', (2 => True, 3 => True, 4 => True, others => False),
                                                              2, 0, 1, 0, 0),
                                                       -- Sumpf
                                                       32 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 1, 1, 1, 2),
                                                       -- Gold = Ressource 5
                                                       33 => ('♦', (1 => True, 3 => True, 4 => True, others => False),
                                                              0, 1, 3, 0, 0),
                                                       -- Hügel mit (Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?)
                                                       34 => (' ', (1 => True, 3 => True, 4 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Erde
                                                       35 => (' ', (1 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Lava
                                                       36 => (' ', (7 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Wolken
                                                       37 => (' ', (3 => True, 4 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Weltraum
                                                       38 => (' ', (4 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Erde
                                                       39 => (' ', (6 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Gestein
                                                       40 => (' ', (6 => True, others => False),
                                                              0, 0, 0, 0, 0),
                                                       -- Wasser für Unterwasser
                                                       41 => (' ', (5 => True, others => False),
                                                              1, 0, 1, 1, 0),
                                                       -- Küsten/Seegewässer für Unterwasser
                                                       42 => (' ', (5 => True, others => False),
                                                              2, 0, 1, 0, 0),
                                                       -- Fluß einzeln
                                                       43 => ('▪', (1 => True, 3 => True, 4 => True, others => False),
                                                              1, 0, 1, 0, 1)
                                                      );

end KartenDatenbank;
