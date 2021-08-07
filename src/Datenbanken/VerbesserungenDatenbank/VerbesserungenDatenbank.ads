pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleKonstanten;
use GlobaleDatentypen;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungListeArray is array (GlobaleDatentypen.Karten_Verbesserung_Enum'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
      
private
      
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   
   VerbesserungListeStandard : constant VerbesserungListeArray :=
     (
      -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
      GlobaleDatentypen.Leer => GlobaleKonstanten.LeerVerbesserungListe,
      
      
                                                  
      -- Städte
      GlobaleDatentypen.Eigene_Hauptstadt =>
        (VerbesserungGrafik => '♣',
         Passierbarkeit     => (others => True),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Eigene_Stadt =>
        (VerbesserungGrafik => '♠',
         Passierbarkeit     => (others => True),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Fremde_Hauptstadt =>
        (VerbesserungGrafik => '⌂',
         Passierbarkeit     => (others => True),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Fremde_Stadt =>
        (VerbesserungGrafik => '¤',
         Passierbarkeit     => (others => True),
         VerbesserungWerte  => (others => (others => 1))),
      -- Städte
      
      
                                                  
      -- Gebilde
      GlobaleDatentypen.Farm =>
        (VerbesserungGrafik => 'F',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True, 
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Mine =>
        (VerbesserungGrafik => 'M',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Festung =>
        (VerbesserungGrafik => 'B',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Sperre =>
        (VerbesserungGrafik => 'S',
         Passierbarkeit     => (GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
      -- Gebilde
      
      
                                                  
      -- Wege
      GlobaleDatentypen.Straßenkreuzung_Vier =>
        (VerbesserungGrafik => '╬',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straße_Waagrecht =>
        (VerbesserungGrafik => '═',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True, 
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straße_Senkrecht =>
        (VerbesserungGrafik => '║',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
        (VerbesserungGrafik => '╔',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True, 
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkurve_Unten_Links =>
        (VerbesserungGrafik => '╗',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
        (VerbesserungGrafik => '╚',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkurve_Oben_Links =>
        (VerbesserungGrafik => '╝',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkreuzung_Drei_Oben =>
        (VerbesserungGrafik => '╩',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkreuzung_Drei_Unten =>
        (VerbesserungGrafik => '╦',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkreuzung_Drei_Rechts =>
        (VerbesserungGrafik => '╠',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenkreuzung_Drei_Links =>
        (VerbesserungGrafik => '╣',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenendstück_Links =>
        (VerbesserungGrafik => '╞',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenendstück_Rechts =>
        (VerbesserungGrafik => '╡',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenendstück_Unten =>
        (VerbesserungGrafik => '╨',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straßenendstück_Oben =>
        (VerbesserungGrafik => '╥',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1))),
                                                  
      GlobaleDatentypen.Straße_Einzeln =>
        (VerbesserungGrafik => '▫',
         Passierbarkeit     => (GlobaleDatentypen.Boden    => True,
                                GlobaleDatentypen.Luft     => True,
                                GlobaleDatentypen.Weltraum => True,
                                others                     => False),
         VerbesserungWerte  => (others => (others => 1)))
      -- Wege
     );
         
end VerbesserungenDatenbank;
