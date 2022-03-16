pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with KartenVerbesserungDatentypen;
with KartenRecordKonstanten;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungListeArray is array (KartenVerbesserungDatentypen.Karten_Verbesserung_Enum'Range) of DatenbankRecords.VerbesserungListeRecord;
   VerbesserungListe : VerbesserungListeArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
      
private
         
   VerbesserungListeStandard : constant VerbesserungListeArray := (
                                                                   -- Nullwert, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                                   KartenVerbesserungDatentypen.Leer_Verbesserung_Enum => KartenRecordKonstanten.LeerVerbesserungListe,
      
      
                                                  
                                                                   -- Städte
                                                                   KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
                                                                     (Passierbarkeit     => (others => True),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
                                                                     (Passierbarkeit     => (others => True),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Fremde_Hauptstadt_Enum =>
                                                                     (Passierbarkeit     => (others => True),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Fremde_Stadt_Enum =>
                                                                     (Passierbarkeit     => (others => True),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                                   -- Städte
      
      
                                                  
                                                                   -- Gebilde
                                                                   KartenVerbesserungDatentypen.Farm_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True, 
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Mine_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Festung_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Sperre_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                                   -- Gebilde
      
      
                                                  
                                                                   -- Wege
                                                                   -- Straßen
                                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straße_Waagrecht_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True, 
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straße_Senkrecht_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True, 
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenendstück_Links_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                             others                          => False),
                                                                      Bewertung          => (others => 1),
                                                                      Wirtschaft         => (others => (others => 1)),
                                                                      Kampf              => (others => (others => 1))),
                                                  
                                                                   KartenVerbesserungDatentypen.Straße_Einzeln_Enum =>
                                                                     (Passierbarkeit     => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                             EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                             EinheitStadtDatentypen.Weltraum_Enum => True,
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
