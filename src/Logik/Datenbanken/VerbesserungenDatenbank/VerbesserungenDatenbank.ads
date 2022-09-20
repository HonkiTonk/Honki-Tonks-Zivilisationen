pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;

private with EinheitenDatentypen;
private with KartenRecordKonstanten;

with DatenbankRecords;

package VerbesserungenDatenbank is
   
   type VerbesserungenlisteArray is array (KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Verbesserungenliste : VerbesserungenlisteArray;
   
   type WegelisteArray is array (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Wegeliste : WegelisteArray;
   
   procedure StandardVerbesserungenDatenbankLaden;
   procedure StandardWegeDatenbankLaden;
      
private
   
   VerbesserungenlisteStandard : constant VerbesserungenlisteArray := (
                                                                       -- Städte
                                                                       KartenverbesserungDatentypen.Hauptstadt_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (others => True),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenverbesserungDatentypen.Stadt_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (others => True),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                                         -- Städte
      
      
                                                                       
                                                                       -- Gebilde
                                                                       KartenverbesserungDatentypen.Farm_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True, 
                                                                                                 others                            => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenverbesserungDatentypen.Mine_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                 others                               => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         ),
                                                  
                                                                       KartenverbesserungDatentypen.Festung_Enum =>
                                                                         (
                                                                          Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                                                 others                               => False),
                                                                          Bewertung          => (others => 1),
                                                                          Wirtschaft         => (others => (others => 1)),
                                                                          Kampf              => (others => (others => 1))
                                                                         )
                                                                         -- Gebilde
                                                                      );
   
   
   
   WegelisteStandard : constant WegelisteArray := (
                                                   -- Straßen
                                                   KartenverbesserungDatentypen.Straßenkreuzung_Vier_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straße_Waagrecht_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True, 
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straße_Senkrecht_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True, 
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkurve_Unten_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkurve_Oben_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenendstück_Links_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenendstück_Rechts_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenendstück_Unten_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straßenendstück_Oben_Enum =>
                                                     (
                                                      Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                               => False),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     ),
                                                  
                                                   KartenverbesserungDatentypen.Straße_Einzeln_Enum =>
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
