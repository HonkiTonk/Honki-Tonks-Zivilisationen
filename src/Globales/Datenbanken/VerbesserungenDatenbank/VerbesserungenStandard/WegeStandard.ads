with KartenverbesserungDatentypen;
with EinheitenDatentypen;
with KartendatenbankRecord;

with BewertungDatentypen;

package WegeStandard is
   pragma Pure;
   use type EinheitenDatentypen.Bewegungspunkte;

   type WegelisteArray is array (KartenverbesserungDatentypen.Straße_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Wegeliste : constant WegelisteArray := (
                                           others =>
                                             (
                                              Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                 others                            => False),
                                              Bewertung      => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                              Wirtschaft     => (others => (others => 1)),
                                              Kampf          => (others => (others => 1)),
                                              Bewegung       => (others => -1)
                                             )
                                          );
                                           
   
   
   type SchienenlisteArray is array (KartenverbesserungDatentypen.Schiene_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Schienenliste : constant SchienenlisteArray := (
                                                   others =>
                                                     (
                                                      Passierbarkeit => (
                                                                         EinheitenDatentypen.Boden_Enum    => True,
                                                                         EinheitenDatentypen.Luft_Enum     => True,
                                                                         EinheitenDatentypen.Weltraum_Enum => True,
                                                                         others                            => False
                                                                        ),
                                                      Bewertung      => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                      Wirtschaft     => (others => (others => 1)),
                                                      Kampf          => (others => (others => 1)),
                                                      Bewegung       => (others => -2)
                                                     )
                                                  );
   
   
   
   type TunnellisteArray is array (KartenverbesserungDatentypen.Tunnel_Enum'Range) of KartendatenbankRecord.KartenpassierbarkeitslistenRecord;
   Tunnelliste : constant TunnellisteArray := (
                                               others =>
                                                 (
                                                  Passierbarkeit => (
                                                                     EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                     others                                => False
                                                                    ),
                                                  Bewertung      => (others => BewertungDatentypen.Bewertung_Eins_Enum),
                                                  Wirtschaft     => (others => (others => 1)),
                                                  Kampf          => (others => (others => 1)),
                                                  Bewegung       => (others => -1)
                                                 )
                                              );

end WegeStandard;
