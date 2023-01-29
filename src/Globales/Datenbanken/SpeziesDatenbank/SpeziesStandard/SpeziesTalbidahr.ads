with SpeziesDatentypen;
with DatenbankRecords;

package SpeziesTalbidahr is
   pragma Pure;

   SpeziesTalbidahrListe : constant DatenbankRecords.SpezieslisteRecord := (
                                                                            Aggressivität       => 0,
                                                                            Expansion           => 20,
                                                                            Wissenschaft        => 0,
                                                                            Produktion          => 0,
                                                                            Wirtschaft          => 0,
                                                                            Bewirtschaftung     => 0,
                                                                            Staatsformen        =>
                                                                              (
                                                                               SpeziesDatentypen.Anarchie_Enum,
                                                                               SpeziesDatentypen.Demokratie_Enum,
                                                                               SpeziesDatentypen.Anarchie_Enum,
                                                                               SpeziesDatentypen.Anarchie_Enum,
                                                                               SpeziesDatentypen.Anarchie_Enum
                                                                              )
                                                                           );

end SpeziesTalbidahr;
