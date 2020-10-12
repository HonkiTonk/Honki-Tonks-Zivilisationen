with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package KartenDatenbank is

   type KartenObjekt is record

      Anzeige : Wide_Wide_Character := ' ';
      
      Passierbarkeit : Integer; -- 1 = Landeinheiten können passieren, 2 = Wassereinheiten können passieren, Lufteinheiten können immer passieren
                                -- Addieren für genaue Passierbarkeit

      Nahrungsgewinnung : Integer;
      Ressourcengewinnung : Integer;
      Geldgewinnung : Integer;
      Wissensgewinnung : Integer;

      Verteidigungsbonus : Integer;
      
   end record;
   
   type KartenObjektListeArray is array (0 .. 34) of KartenObjekt;
   KartenObjektListe : constant KartenObjektListeArray := ((' ', 1,    0, 0, 0, 0,    0), -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                           -- Sollte mit Einlesen und Textausgabe funtkionieren, wenn nicht auf letzte Position verschieben.
                                                           (' ', 1,    0, 0, 0, 1,    0), -- 1 Eis █
                                                           (' ', 2,    1, 0, 1, 1,    0), -- 2 Wasser ░
                                                           (' ', 1,    2, 1, 1, 0,    0), -- 3 Ebene ▒
                                                           (' ', 1,    1, 2, 1, 1,    0), -- 4 Tundra #
                                                           (' ', 1,    0, 1, 1, 1,    0), -- 5 Wüste §
                                                           (' ', 1,    1, 2, 1, 0,    1), -- 6 Hügel -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                           (' ', 1,    0, 3, 1, 1,    2), -- 7 Gebirge
                                                           (' ', 1,    1, 2, 1, 1,    1), -- 8 Wald
                                                           (' ', 1,    1, 3, 1, 1,    2), -- 9 Dschungel
                                                           ('♦', 1,    0, 2, 1, 0,    0), -- 10 Kohle = Ressource 1
                                                           ('♦', 1,    0, 2, 1, 0,    0), -- 11 Eisen = Ressource 2
                                                           ('♦', 1,    0, 2, 1, 0,    0), -- 12 Öl = Ressource 3
                                                           ('♦', 1,    2, 1, 1, 0,    0), -- 13 Hochwertiger Boden = Ressource 4
                                               
                                                           ('╋', 1,    1, 0, 1, 0,    1), -- 14 Flußkreuzung
                                                           ('━', 1,    1, 0, 1, 0,    1), -- 15 Fluß waagrecht
                                                           ('┃', 1,    1, 0, 1, 0,    1), -- 16 Fluß senkrecht
                                                           ('┏', 1,    1, 0, 1, 0,    1), -- 17 Flußkurve
                                                           ('┓', 1,    1, 0, 1, 0,    1), -- 18 Flußkurve
                                               
                                                           ('┗', 1,    1, 0, 1, 0,    1), -- 19 Flußkurve
                                                           ('┛', 1,    1, 0, 1, 0,    1), -- 20 Flußkurve
                                                           ('┻', 1,    1, 0, 1, 0,    1), -- 21 Flußkreuzung
                                                           ('┳', 1,    1, 0, 1, 0,    1), -- 22 Flußkreuzung
                                               
                                                           ('┣', 1,    1, 0, 1, 0,    1), -- 23 Flußkreuzung
                                               
                                                           ('┫', 1,    1, 0, 1, 0,    1), -- 24 Flußkreuzung
                                                           ('╺', 1,    1, 0, 1, 0,    1), -- 25 Flußendstück links
                                                           ('╸', 1,    1, 0, 1, 0,    1), -- 26 Flußendstück rechts
                                                           ('╹', 1,    1, 0, 1, 0,    1), -- 27 Flußendstück unten
                                                           ('╻', 1,    1, 0, 1, 0,    1), -- 28 Flußendstück oben
                                                           ('≈', 2,    2, 0, 1, 0,    0), -- 29 Fisch = WasserRessource 1
                                                           ('≈', 2,    2, 1, 2, 0,    0), -- 30 Wal = WasserRessource 2
                                                           (' ', 2,    2, 0, 1, 0,    0), -- 31 Küsten/Seegewässer
                                                           (' ', 1,    1, 1, 1, 1,    2), -- 32 Sumpf
                                                           ('♦', 1,    0, 1, 3, 0,    0), -- 33 Gold = Ressource 5
                                                           (' ', 1,    0, 0, 0, 0,    0)); -- 34 Hügel mit (Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?)
                                                                       
   procedure Beschreibung (ID : in Integer);

end KartenDatenbank;
