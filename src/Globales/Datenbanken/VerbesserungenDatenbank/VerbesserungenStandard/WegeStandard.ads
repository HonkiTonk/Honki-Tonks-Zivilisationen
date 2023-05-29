with KartenverbesserungDatentypen;
with EinheitenDatentypen;
with KartendatenbankRecord;
with ProduktionKonstanten;

package WegeStandard is
   pragma Pure;
   use type EinheitenDatentypen.Bewegungspunkte;

   type WegelisteArray is array (KartenverbesserungDatentypen.Straße_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Wegeliste : constant WegelisteArray := (
                                           others =>
                                             (
                                              Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                 EinheitenDatentypen.Luft_Enum     => True,
                                                                 EinheitenDatentypen.Weltraum_Enum => True,
                                                                 others                            => False),
                                              Wirtschaft     => (others => (others => ProduktionKonstanten.LeerBonus)),
                                              Kampf          => (others => (others => ProduktionKonstanten.LeerBonus)),
                                              Bewegung       => (others => -1)
                                             )
                                          );
                                           
   
   
   type SchienenlisteArray is array (KartenverbesserungDatentypen.Schiene_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Schienenliste : constant SchienenlisteArray := (
                                                   others =>
                                                     (
                                                      Passierbarkeit => (
                                                                         EinheitenDatentypen.Boden_Enum    => True,
                                                                         EinheitenDatentypen.Luft_Enum     => True,
                                                                         EinheitenDatentypen.Weltraum_Enum => True,
                                                                         others                            => False
                                                                        ),
                                                      Wirtschaft     => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                      Kampf          => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                      Bewegung       => (others => -2)
                                                     )
                                                  );
   
   
   
   type TunnellisteArray is array (KartenverbesserungDatentypen.Tunnel_Enum'Range) of KartendatenbankRecord.WegelisteRecord;
   Tunnelliste : constant TunnellisteArray := (
                                               others =>
                                                 (
                                                  Passierbarkeit => (
                                                                     EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                     others                                => False
                                                                    ),
                                                  Wirtschaft     => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                  Kampf          => (others => (others => ProduktionKonstanten.LeerBonus)),
                                                  Bewegung       => (others => -1)
                                                 )
                                              );

end WegeStandard;
