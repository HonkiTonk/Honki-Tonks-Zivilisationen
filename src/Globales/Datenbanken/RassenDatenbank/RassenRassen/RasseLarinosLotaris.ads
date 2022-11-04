pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

with DatenbankRecords;

package RasseLarinosLotaris is
   pragma Pure;

   RasseLarinosLotarisListe : constant DatenbankRecords.RassenlisteRecord := (
                                                                              Aggressivität       => 0,
                                                                              Expansion           => 20,
                                                                              Wissenschaft        => 0,
                                                                              Produktion          => 0,
                                                                              Wirtschaft          => 0,
                                                                              Bewirtschaftung     => 0,
                                                                              Staatsformen        =>
                                                                                (
                                                                                 RassenDatentypen.Anarchie_Enum,
                                                                                 RassenDatentypen.Demokratie_Enum,
                                                                                 RassenDatentypen.Anarchie_Enum,
                                                                                 RassenDatentypen.Anarchie_Enum,
                                                                                 RassenDatentypen.Anarchie_Enum
                                                                                )
                                                                             );

end RasseLarinosLotaris;
