pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen;
with EinheitenDatentypen;

with DatenbankRecords;

package WegeStandard is

   type WegelisteArray is array (KartenverbesserungDatentypen.Karten_Straße_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Wegeliste : constant WegelisteArray := (
                                           others =>
                                             (
                                              Passierbarkeit     => (EinheitenDatentypen.Boden_Enum    => True,
                                                                     EinheitenDatentypen.Luft_Enum     => True,
                                                                     EinheitenDatentypen.Weltraum_Enum => True,
                                                                     others                            => False),
                                              Bewertung          => (others => 1),
                                              Wirtschaft         => (others => (others => 1)),
                                              Kampf              => (others => (others => 1))
                                             )
                                          );
                                           
   
   
   type SchienenlisteArray is array (KartenverbesserungDatentypen.Karten_Schiene_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Schienenliste : constant SchienenlisteArray := (
                                                   others =>
                                                     (
                                                      Passierbarkeit     => (
                                                                             EinheitenDatentypen.Boden_Enum    => True,
                                                                             EinheitenDatentypen.Luft_Enum     => True,
                                                                             EinheitenDatentypen.Weltraum_Enum => True,
                                                                             others                            => False
                                                                            ),
                                                      Bewertung          => (others => 1),
                                                      Wirtschaft         => (others => (others => 1)),
                                                      Kampf              => (others => (others => 1))
                                                     )
                                                  );
   
   
   
   type TunnellisteArray is array (KartenverbesserungDatentypen.Karten_Tunnel_Enum'Range) of DatenbankRecords.VerbesserungenWegeListeRecord;
   Tunnelliste : constant TunnellisteArray := (
                                               others =>
                                                 (
                                                  Passierbarkeit     => (
                                                                         EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                         others                                => False
                                                                        ),
                                                  Bewertung          => (others => 1),
                                                  Wirtschaft         => (others => (others => 1)),
                                                  Kampf              => (others => (others => 1))
                                                 )
                                              );

end WegeStandard;
