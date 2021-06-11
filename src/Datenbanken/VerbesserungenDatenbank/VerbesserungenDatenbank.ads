pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with DatenbankRecords;

package VerbesserungenDatenbank is

   LeererWertVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (' ', -- VerbesserungGrafik
                                                                                       1, -- Passierbarkeit
                                                                                       0, 0, 0, 0, 0); -- Nahrungsbonus, Ressourcenbonus, Geldbonus, Wissensbonus,
   -- 7. Wert = Verteidigungsbonus
      
   -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
   -- Addieren für genaue Passierbarkeit
   type VerbesserungListeArray is array (GlobaleDatentypen.KartenVerbesserung'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray := (LeererWertVerbesserungListe, -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                  ('♣',    1,    0, 0, 0, 0, 3), -- 1 Eigene Hauptstadt
                                                  ('♠',    1,    0, 0, 0, 0, 2), -- 2 Eigene Stadt
                                                  ('⌂',    1,    0, 0, 0, 0, 3), -- 3 Andere Hauptstadt
                                                  ('¤',    1,    0, 0, 0, 0, 2), -- 4 Andere Stadt
                                                  ('╬',    1,    0, 0, 1, 0, 0), -- 5 Straßenkreuzung
                                                  ('═',    1,    0, 0, 1, 0, 0), -- 6 Straße waagrecht
                                                  ('║',    1,    0, 0, 1, 0, 0), -- 7 Straße senkrecht
                                                  ('╔',    1,    0, 0, 1, 0, 0), -- 8 Straßenkurve
                                                  ('╗',    1,    0, 0, 1, 0, 0), -- 9 Straßenkurve

                                                  ('╚',    1,    0, 0, 1, 0, 0), -- 10 Straßenkurve
                                                  ('╝',    1,    0, 0, 1, 0, 0), -- 11 Straßenkurve
                                                  ('╩',    1,    0, 0, 1, 0, 0), -- 12 Straßenkreuzung
                                                  ('╦',    1,    0, 0, 1, 0, 0), -- 13 Straßenkreuzung

                                                  ('╠',    1,    0, 0, 1, 0, 0), -- 14 Straßenkreuzung
                                               
                                                  ('╣',    1,    0, 0, 1, 0, 0), -- 15 Straßenkreuzung
                                                  ('╞',    1,    0, 0, 1, 0, 0), -- 16 Straßenendstück links
                                                  ('╡',    1,    0, 0, 1, 0, 0), -- 17 Straßenendstück rechts
                                                  ('╨',    1,    0, 0, 1, 0, 0), -- 18 Straßenendstück unten
                                                  ('╥',    1,    0, 0, 1, 0, 0), -- 19 Straßenendstück oben
                                                  ('F',    1,    2, 0, 1, 0, 1), -- 20 Farm
                                                  ('M',    1,    0, 2, 1, 0, 1), -- 21 Mine
                                                  ('B',    1,    0, 0, 0, 0, 2), -- 22 Festung
                                                  ('S',    3,    0, 0, 0, 0, 0), -- 23 Sperre
                                                  ('▫',    1,    0, 0, 0, 0, 0)); -- 24 Straße einzeln
   
   procedure StandardVerbesserungenDatenbankWiederherstellen;
   
private
   
   VerbesserungListeStandard : constant VerbesserungListeArray := (LeererWertVerbesserungListe, -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                                   ('♣',    1,    0, 0, 0, 0, 3), -- 1 Eigene Hauptstadt
                                                                   ('♠',    1,    0, 0, 0, 0, 2), -- 2 Eigene Stadt
                                                                   ('⌂',    1,    0, 0, 0, 0, 3), -- 3 Andere Hauptstadt
                                                                   ('¤',    1,    0, 0, 0, 0, 2), -- 4 Andere Stadt
                                                                   ('╬',    1,    0, 0, 1, 0, 0), -- 5 Straßenkreuzung
                                                                   ('═',    1,    0, 0, 1, 0, 0), -- 6 Straße waagrecht
                                                                   ('║',    1,    0, 0, 1, 0, 0), -- 7 Straße senkrecht
                                                                   ('╔',    1,    0, 0, 1, 0, 0), -- 8 Straßenkurve
                                                                   ('╗',    1,    0, 0, 1, 0, 0), -- 9 Straßenkurve

                                                                   ('╚',    1,    0, 0, 1, 0, 0), -- 10 Straßenkurve
                                                                   ('╝',    1,    0, 0, 1, 0, 0), -- 11 Straßenkurve
                                                                   ('╩',    1,    0, 0, 1, 0, 0), -- 12 Straßenkreuzung
                                                                   ('╦',    1,    0, 0, 1, 0, 0), -- 13 Straßenkreuzung

                                                                   ('╠',    1,    0, 0, 1, 0, 0), -- 14 Straßenkreuzung
                                               
                                                                   ('╣',    1,    0, 0, 1, 0, 0), -- 15 Straßenkreuzung
                                                                   ('╞',    1,    0, 0, 1, 0, 0), -- 16 Straßenendstück links
                                                                   ('╡',    1,    0, 0, 1, 0, 0), -- 17 Straßenendstück rechts
                                                                   ('╨',    1,    0, 0, 1, 0, 0), -- 18 Straßenendstück unten
                                                                   ('╥',    1,    0, 0, 1, 0, 0), -- 19 Straßenendstück oben
                                                                   ('F',    1,    2, 0, 1, 0, 1), -- 20 Farm
                                                                   ('M',    1,    0, 2, 1, 0, 1), -- 21 Mine
                                                                   ('B',    1,    0, 0, 0, 0, 2), -- 22 Festung
                                                                   ('S',    3,    0, 0, 0, 0, 0), -- 23 Sperre
                                                                   ('▫',    1,    0, 0, 0, 0, 0)); -- 24 Straße einzeln
   
end VerbesserungenDatenbank;
