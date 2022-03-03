pragma SPARK_Mode (On);

with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenVerbesserungKonstanten;
with KartenRecordKonstanten;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungListeArray is array (KartenDatentypen.Karten_Verbesserung_Enum'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
      
private
         
   VerbesserungListeStandard : constant VerbesserungListeArray :=
     (
      -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
      KartenVerbesserungKonstanten.LeerVerbesserung => KartenRecordKonstanten.LeerVerbesserungListe,
      
      
                                                  
      -- Städte
      KartenDatentypen.Eigene_Hauptstadt =>
        (Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Eigene_Stadt =>
        (Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Fremde_Hauptstadt =>
        (Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Fremde_Stadt =>
        (Passierbarkeit     => (others => True),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
      -- Städte
      
      
                                                  
      -- Gebilde
      KartenDatentypen.Farm =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True, 
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Mine =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Festung =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Sperre =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
      -- Gebilde
      
      
                                                  
      -- Wege
      -- Straßen
      KartenDatentypen.Straßenkreuzung_Vier =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straße_Waagrecht =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True, 
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straße_Senkrecht =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Unten_Rechts =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True, 
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Unten_Links =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Oben_Rechts =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkurve_Oben_Links =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Oben =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Unten =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Rechts =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenkreuzung_Drei_Links =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Links =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Rechts =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Unten =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straßenendstück_Oben =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
                                EinheitStadtDatentypen.Luft     => True,
                                EinheitStadtDatentypen.Weltraum => True,
                                others                          => False),
         Bewertung          => (others => 1),
         Wirtschaft         => (others => (others => 1)),
         Kampf              => (others => (others => 1))),
                                                  
      KartenDatentypen.Straße_Einzeln =>
        (Passierbarkeit     => (EinheitStadtDatentypen.Boden    => True,
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
      
      others                => KartenRecordKonstanten.LeerVerbesserungListe
     );
         
end VerbesserungenDatenbank;
