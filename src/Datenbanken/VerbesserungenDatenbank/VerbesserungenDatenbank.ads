pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package VerbesserungenDatenbank is
                                     
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   
   -- VerbesserungGrafik
   -- Passierbarkeit
   -- Nahrungsbonus, Ressourcenbonus, Geldbonus, Wissensbonus, Verteidigungsbonus
   
   type VerbesserungListeArray is array (GlobaleDatentypen.Karten_Verbesserung_Enum'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray := (
                                                  -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                  GlobaleDatentypen.Leer => GlobaleKonstanten.LeerVerbesserungListe,
                                                  
                                                  -- Städte
                                                  GlobaleDatentypen.Eigene_Hauptstadt =>
                                                    ('♣',
                                                     (others => True),
                                                     0, 0, 0, 0, 3),
                                                  GlobaleDatentypen.Eigene_Stadt =>
                                                    ('♠',
                                                     (others => True),   
                                                     0, 0, 0, 0, 2),
                                                  GlobaleDatentypen.Fremde_Hauptstadt =>
                                                    ('⌂',
                                                     (others => True),
                                                     0, 0, 0, 0, 3),
                                                  GlobaleDatentypen.Fremde_Stadt =>
                                                    ('¤',
                                                     (others => True),
                                                     0, 0, 0, 0, 2),
                                                  
                                                  -- Gebilde
                                                  GlobaleDatentypen.Farm =>
                                                    ('F',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     2, 0, 1, 0, 1),
                                                  GlobaleDatentypen.Mine =>
                                                    ('M',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 2, 1, 0, 1),
                                                  GlobaleDatentypen.Festung =>
                                                    ('B',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 0, 0, 2),
                                                  GlobaleDatentypen.Sperre =>
                                                    ('S',
                                                     (GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                     0, 0, 0, 0, 0),
                                                  
                                                  -- Straßen
                                                  GlobaleDatentypen.Straßenkreuzung_Vier =>
                                                    ('╬',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straße_Waagrecht =>
                                                    ('═',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straße_Senkrecht =>
                                                    ('║',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
                                                    ('╔',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkurve_Unten_Links =>
                                                    ('╗',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
                                                    ('╚',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkurve_Oben_Links =>
                                                    ('╝',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkreuzung_Drei_Oben =>
                                                    ('╩',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkreuzung_Drei_Unten =>
                                                    ('╦',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkreuzung_Drei_Rechts =>
                                                    ('╠',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenkreuzung_Drei_Links =>
                                                    ('╣',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenendstück_Links =>
                                                    ('╞',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenendstück_Rechts =>
                                                    ('╡',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenendstück_Unten =>
                                                    ('╨',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straßenendstück_Oben =>
                                                    ('╥',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 1, 0, 0),
                                                  GlobaleDatentypen.Straße_Einzeln =>
                                                    ('▫',
                                                     (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                     0, 0, 0, 0, 0)
                                                 );
   
   procedure StandardVerbesserungenDatenbankWiederherstellen;
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   
   -- VerbesserungGrafik
   -- Passierbarkeit
   -- Nahrungsbonus, Ressourcenbonus, Geldbonus, Wissensbonus, Verteidigungsbonus
   
private
   
   VerbesserungListeStandard : constant VerbesserungListeArray := (
                                                                   -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                                   GlobaleDatentypen.Leer => GlobaleKonstanten.LeerVerbesserungListe,
                                                  
                                                                   -- Städte
                                                                   GlobaleDatentypen.Eigene_Hauptstadt =>
                                                                     ('♣',
                                                                      (others => True),
                                                                      0, 0, 0, 0, 3),
                                                                   GlobaleDatentypen.Eigene_Stadt =>
                                                                     ('♠',
                                                                      (others => True),   
                                                                      0, 0, 0, 0, 2),
                                                                   GlobaleDatentypen.Fremde_Hauptstadt =>
                                                                     ('⌂',
                                                                      (others => True),
                                                                      0, 0, 0, 0, 3),
                                                                   GlobaleDatentypen.Fremde_Stadt =>
                                                                     ('¤',
                                                                      (others => True),
                                                                      0, 0, 0, 0, 2),
                                                  
                                                                   -- Gebilde
                                                                   GlobaleDatentypen.Farm =>
                                                                     ('F',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      2, 0, 1, 0, 1),
                                                                   GlobaleDatentypen.Mine =>
                                                                     ('M',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 2, 1, 0, 1),
                                                                   GlobaleDatentypen.Festung =>
                                                                     ('B',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 0, 0, 2),
                                                                   GlobaleDatentypen.Sperre =>
                                                                     ('S',
                                                                      (GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                                      0, 0, 0, 0, 0),
                                                  
                                                                   -- Straßen
                                                                   GlobaleDatentypen.Straßenkreuzung_Vier =>
                                                                     ('╬',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True, others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straße_Waagrecht =>
                                                                     ('═',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straße_Senkrecht =>
                                                                     ('║',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
                                                                     ('╔',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkurve_Unten_Links =>
                                                                     ('╗',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
                                                                     ('╚',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkurve_Oben_Links =>
                                                                     ('╝',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkreuzung_Drei_Oben =>
                                                                     ('╩',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkreuzung_Drei_Unten =>
                                                                     ('╦',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkreuzung_Drei_Rechts =>
                                                                     ('╠',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenkreuzung_Drei_Links =>
                                                                     ('╣',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenendstück_Links =>
                                                                     ('╞',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenendstück_Rechts =>
                                                                     ('╡',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenendstück_Unten =>
                                                                     ('╨',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straßenendstück_Oben =>
                                                                     ('╥',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 1, 0, 0),
                                                                   GlobaleDatentypen.Straße_Einzeln =>
                                                                     ('▫',
                                                                      (GlobaleDatentypen.Boden => True, GlobaleDatentypen.Luft => True, GlobaleDatentypen.Weltraum => True,  others => False),
                                                                      0, 0, 0, 0, 0)
                                                                  );
   
end VerbesserungenDatenbank;
