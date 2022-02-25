pragma SPARK_Mode (On);

with KartenKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenVerbesserungKonstanten;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungListeArray is array (KartenDatentypen.Karten_Verbesserung_Enum'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
      
private
         
   VerbesserungListeStandard : constant VerbesserungListeArray :=
     (
      -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
      KartenVerbesserungKonstanten.LeerVerbesserung => KartenKonstanten.LeerVerbesserungListe,
      
      
                                                  
      -- Städte
      KartenDatentypen.Eigene_Hauptstadt =>
        (VerbesserungGrafik => '♣',
         Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Eigene_Stadt =>
        (VerbesserungGrafik => '♠',
         Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Fremde_Hauptstadt =>
        (VerbesserungGrafik => '⌂',
         Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Fremde_Stadt =>
        (VerbesserungGrafik => '¤',
         Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
      -- Städte
      
      
                                                  
      -- Gebilde
      KartenDatentypen.Farm =>
        (VerbesserungGrafik => 'F',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True, 
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Mine =>
        (VerbesserungGrafik => 'M',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Festung =>
        (VerbesserungGrafik => 'B',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Sperre =>
        (VerbesserungGrafik => 'S',
         Passierbarkeit     => (EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
      -- Gebilde
      
      
                                                  
      -- Wege
      -- Straßen
      KartenDatentypen.Straßenkreuzung_Vier =>
        (VerbesserungGrafik => '╬',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straße_Waagrecht =>
        (VerbesserungGrafik => '═',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True, 
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straße_Senkrecht =>
        (VerbesserungGrafik => '║',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Unten_Rechts =>
        (VerbesserungGrafik => '╔',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True, 
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Unten_Links =>
        (VerbesserungGrafik => '╗',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Oben_Rechts =>
        (VerbesserungGrafik => '╚',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Oben_Links =>
        (VerbesserungGrafik => '╝',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Oben =>
        (VerbesserungGrafik => '╩',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Unten =>
        (VerbesserungGrafik => '╦',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Rechts =>
        (VerbesserungGrafik => '╠',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Links =>
        (VerbesserungGrafik => '╣',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Links =>
        (VerbesserungGrafik => '╞',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Rechts =>
        (VerbesserungGrafik => '╡',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Unten =>
        (VerbesserungGrafik => '╨',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Oben =>
        (VerbesserungGrafik => '╥',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straße_Einzeln =>
        (VerbesserungGrafik => '▫',
         Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
      -- Straßen
      
      
      
      -- Schienen
      -- Schienen
      
      
      
      -- Tunnel
      -- Tunnel
      -- Wege
      
      others                => KartenKonstanten.LeerVerbesserungListe
     );
         
end VerbesserungenDatenbank;
