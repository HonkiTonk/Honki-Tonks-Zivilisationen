pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package VerbesserungenDatenbank is
                                     
   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   
   -- VerbesserungGrafik, Passierbarkeit
   -- Nahrungsbonus, Ressourcenbonus, Geldbonus, Wissensbonus, Verteidigungsbonus
   
   type VerbesserungListeArray is array (GlobaleDatentypen.KartenVerbesserung'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray := (
                                                  -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                  0 => GlobaleKonstanten.LeererWertVerbesserungListe,
                                                  
                                                  -- Eigene Hauptstadt
                                                  1 => ('♣', (1 => True, others => False),
                                                        0, 0, 0, 0, 3),
                                                  -- Eigene Stadt
                                                  2 => ('♠', (1 => True, others => False),   
                                                        0, 0, 0, 0, 2),
                                                  -- Andere Hauptstadt
                                                  3 => ('⌂', (1 => True, others => False),
                                                        0, 0, 0, 0, 3),
                                                  -- Andere Stadt
                                                  4 => ('¤', (1 => True, others => False),
                                                        0, 0, 0, 0, 2),
                                                  
                                                  -- Straßenkreuzung
                                                  5 => ('╬', (1 => True, others => False),
                                                        0, 0, 1, 0, 0),
                                                  -- Straße waagrecht
                                                  6 => ('═', (1 => True, others => False),
                                                        0, 0, 1, 0, 0),
                                                  -- Straße senkrecht
                                                  7 => ('║', (1 => True, others => False),
                                                        0, 0, 1, 0, 0),
                                                  -- Straßenkurve
                                                  8 => ('╔', (1 => True, others => False),
                                                        0, 0, 1, 0, 0),
                                                  -- Straßenkurve
                                                  9 => ('╗', (1 => True, others => False),
                                                        0, 0, 1, 0, 0),
                                                  -- Straßenkurve
                                                  10 => ('╚', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenkurve
                                                  11 => ('╝', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenkreuzung
                                                  12 => ('╩', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenkreuzung
                                                  13 =>('╦', (1 => True, others => False),
                                                        0, 0, 1, 0, 0),
                                                  -- Straßenkreuzung
                                                  14 => ('╠', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenkreuzung
                                                  15 => ('╣', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenendstück links
                                                  16 => ('╞', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenendstück rechts
                                                  17 => ('╡', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenendstück unten
                                                  18 => ('╨', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  -- Straßenendstück oben
                                                  19 => ('╥', (1 => True, others => False),
                                                         0, 0, 1, 0, 0),
                                                  
                                                  -- Farm
                                                  20 => ('F', (1 => True, others => False),
                                                         2, 0, 1, 0, 1),
                                                  -- Mine
                                                  21 => ('M', (1 => True, others => False),
                                                         0, 2, 1, 0, 1),
                                                  -- Festung
                                                  22 => ('B', (1 => True, others => False),
                                                         0, 0, 0, 0, 2),
                                                  -- Sperre
                                                  23 => ('S', (3 => True, others => False),
                                                         0, 0, 0, 0, 0),
                                                  
                                                  -- Straße einzeln
                                                  24 => ('▫', (1 => True, others => False),
                                                         0, 0, 0, 0, 0)
                                                 );
   
   procedure StandardVerbesserungenDatenbankWiederherstellen;
   
private
   
   VerbesserungListeStandard : constant VerbesserungListeArray := (
                                                                   -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                                   0 => GlobaleKonstanten.LeererWertVerbesserungListe,
                                                  
                                                                   -- Eigene Hauptstadt
                                                                   1 => ('♣', (1 => True, others => False),
                                                                         0, 0, 0, 0, 3),
                                                                   -- Eigene Stadt
                                                                   2 => ('♠', (1 => True, others => False),   
                                                                         0, 0, 0, 0, 2),
                                                                   -- Andere Hauptstadt
                                                                   3 => ('⌂', (1 => True, others => False),
                                                                         0, 0, 0, 0, 3),
                                                                   -- Andere Stadt
                                                                   4 => ('¤', (1 => True, others => False),
                                                                         0, 0, 0, 0, 2),
                                                  
                                                                   -- Straßenkreuzung
                                                                   5 => ('╬', (1 => True, others => False),
                                                                         0, 0, 1, 0, 0),
                                                                   -- Straße waagrecht
                                                                   6 => ('═', (1 => True, others => False),
                                                                         0, 0, 1, 0, 0),
                                                                   -- Straße senkrecht
                                                                   7 => ('║', (1 => True, others => False),
                                                                         0, 0, 1, 0, 0),
                                                                   -- Straßenkurve
                                                                   8 => ('╔', (1 => True, others => False),
                                                                         0, 0, 1, 0, 0),
                                                                   -- Straßenkurve
                                                                   9 => ('╗', (1 => True, others => False),
                                                                         0, 0, 1, 0, 0),
                                                                   -- Straßenkurve
                                                                   10 => ('╚', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenkurve
                                                                   11 => ('╝', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenkreuzung
                                                                   12 => ('╩', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenkreuzung
                                                                   13 =>('╦', (1 => True, others => False),
                                                                         0, 0, 1, 0, 0),
                                                                   -- Straßenkreuzung
                                                                   14 => ('╠', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenkreuzung
                                                                   15 => ('╣', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenendstück links
                                                                   16 => ('╞', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenendstück rechts
                                                                   17 => ('╡', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenendstück unten
                                                                   18 => ('╨', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                                   -- Straßenendstück oben
                                                                   19 => ('╥', (1 => True, others => False),
                                                                          0, 0, 1, 0, 0),
                                                  
                                                                   -- Farm
                                                                   20 => ('F', (1 => True, others => False),
                                                                          2, 0, 1, 0, 1),
                                                                   -- Mine
                                                                   21 => ('M', (1 => True, others => False),
                                                                          0, 2, 1, 0, 1),
                                                                   -- Festung
                                                                   22 => ('B', (1 => True, others => False),
                                                                          0, 0, 0, 0, 2),
                                                                   -- Sperre
                                                                   23 => ('S', (3 => True, others => False),
                                                                          0, 0, 0, 0, 0),
                                                  
                                                                   -- Straße einzeln
                                                                   24 => ('▫', (1 => True, others => False),
                                                                          0, 0, 0, 0, 0)
                                                                  );
   
end VerbesserungenDatenbank;
