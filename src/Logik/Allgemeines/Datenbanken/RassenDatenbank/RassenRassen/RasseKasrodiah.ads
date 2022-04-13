pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

with DatenbankRecords;

package RasseKasrodiah is

   RasseKasrodiahListe : constant DatenbankRecords.RassenListeRecord := (
                                                                         Aggressivität       => 0,
                                                                         Expansion           => 20,
                                                                         Wissenschaft        => 0,
                                                                         Produktion          => 0,
                                                                         Wirtschaft          => 0,
                                                                         Bewirtschaftung     => 0,
                                                                         GültigeStaatsformen => (SystemDatentypen.Anarchie_Enum,
                                                                                                  SystemDatentypen.Demokratie_Enum,
                                                                                                  SystemDatentypen.Anarchie_Enum,
                                                                                                  SystemDatentypen.Anarchie_Enum,
                                                                                                  SystemDatentypen.Anarchie_Enum)
                                                                        );

end RasseKasrodiah;
