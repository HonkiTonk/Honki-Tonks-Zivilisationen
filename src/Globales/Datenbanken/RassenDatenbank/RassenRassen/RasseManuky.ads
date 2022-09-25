pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

with DatenbankRecords;

package RasseManuky is

   RasseManukyListe : constant DatenbankRecords.RassenlisteRecord := (
                                                                      Aggressivität       => 0,
                                                                      Expansion           => 20,
                                                                      Wissenschaft        => 0,
                                                                      Produktion          => 0,
                                                                      Wirtschaft          => 0,
                                                                      Bewirtschaftung     => 0,
                                                                      GültigeStaatsformen =>
                                                                        (
                                                                         RassenDatentypen.Anarchie_Enum,
                                                                         RassenDatentypen.Demokratie_Enum,
                                                                         RassenDatentypen.Anarchie_Enum,
                                                                         RassenDatentypen.Anarchie_Enum,
                                                                         RassenDatentypen.Anarchie_Enum
                                                                        )
                                                                     );

end RasseManuky;
