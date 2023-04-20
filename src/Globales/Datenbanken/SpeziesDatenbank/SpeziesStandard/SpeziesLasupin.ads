with SpeziesDatentypen;
with DatenbankRecords;

package SpeziesLasupin is
   pragma Pure;

   SpezieslisteLasupin : constant DatenbankRecords.SpezieslisteRecord := (
                                                                          Aggressivität       => 1,
                                                                          Expansion           => 20,
                                                                          Wissenschaft        => 1,
                                                                          Produktion          => 1,
                                                                          Wirtschaft          => 1,
                                                                          Bewirtschaftung     => 1,
                                                                          Staatsformen        =>
                                                                            (
                                                                             SpeziesDatentypen.Anarchie_Enum,
                                                                             SpeziesDatentypen.Demokratie_Enum,
                                                                             SpeziesDatentypen.Anarchie_Enum,
                                                                             SpeziesDatentypen.Anarchie_Enum,
                                                                             SpeziesDatentypen.Anarchie_Enum
                                                                            )
                                                                         );

end SpeziesLasupin;
