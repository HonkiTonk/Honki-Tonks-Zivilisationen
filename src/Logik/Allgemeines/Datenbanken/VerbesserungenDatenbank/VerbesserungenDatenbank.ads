pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen;
with KartenVerbesserungDatentypen;
with KartenRecordKonstanten;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungenListeArray is array (KartenVerbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   VerbesserungenListe : VerbesserungenListeArray;
   
   type WegeListeArray is array (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   WegeListe : WegeListeArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
   procedure StandardWegeDatenbankLaden;
      
private
         
   VerbesserungenListeStandard : constant VerbesserungenListeArray := (
                                                                       -- Städte
                                                                       KartenVerbesserungDatentypen.Eigene_Hauptstadt_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (others => True),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenVerbesserungDatentypen.Eigene_Stadt_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (others => True),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenVerbesserungDatentypen.Fremde_Hauptstadt_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (others => True),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenVerbesserungDatentypen.Fremde_Stadt_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (others => True),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                                         -- Städte
      
      
                                                  
                                                                       -- Gebilde
                                                                       KartenVerbesserungDatentypen.Farm_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True, 
                                                                                                 others                               => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenVerbesserungDatentypen.Mine_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                 others                               => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenVerbesserungDatentypen.Festung_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                 others                               => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenVerbesserungDatentypen.Sperre_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                 others                               => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         )
                                                                         -- Gebilde
                                                                      );
   
   
   
   WegeListeStandard : constant WegeListeArray := (
                                                   -- Straßen
                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straße_Waagrecht_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True, 
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straße_Senkrecht_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True, 
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenendstück_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenVerbesserungDatentypen.Straße_Einzeln_Enum =>
                                                     (
                                                      Passierbarkeit     => (
                                                                             EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False
                                                                            ),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                     -- Straßen
                                                   
      
      
                                                   -- Schienen
                                                   
                                                   -- Schienen
      
      
      
                                                   -- Tunnel
                                                   
                                                   -- Tunnel
      
                                                   others                => KartenRecordKonstanten.LeerVerbesserungListe
                                                  );
         
end VerbesserungenDatenbank;
