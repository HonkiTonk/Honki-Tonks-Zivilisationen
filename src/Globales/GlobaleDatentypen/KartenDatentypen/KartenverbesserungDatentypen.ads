package KartenverbesserungDatentypen is
   pragma Pure;

   -- Das hier auch mal teilweise erweitern, so dass die Grafiken dann über verschiedene Felder hinweg möglich sind? äöü
   type Verbesserung_Enum is (
                              Leer_Verbesserung_Enum,
                                     
                              -- Städte
                              Hauptstadt_Enum, Stadt_Enum,
                                     
                              -- Friedlich
                              Farm_Enum, Mine_Enum,
                                     
                              -- Krieg
                              Festung_Enum
                             );
   
   subtype Verbesserung_Vorhanden_Enum is Verbesserung_Enum range Verbesserung_Enum'Succ (Verbesserung_Enum'First) .. Verbesserung_Enum'Last;

   subtype Verbesserung_Stadt_ID_Enum is Verbesserung_Enum range Leer_Verbesserung_Enum .. Stadt_Enum;
   subtype Verbesserung_Städte_Enum is Verbesserung_Stadt_ID_Enum range Hauptstadt_Enum .. Stadt_Enum;
   subtype Verbesserung_Gebilde_Enum is Verbesserung_Vorhanden_Enum range Farm_Enum .. Verbesserung_Vorhanden_Enum'Last;
   subtype Verbesserung_Gebilde_Friedlich_Enum is Verbesserung_Gebilde_Enum range Farm_Enum .. Mine_Enum;
   subtype Verbesserung_Gebilde_Kampf_Enum is Verbesserung_Gebilde_Enum range Festung_Enum .. Festung_Enum;

end KartenverbesserungDatentypen;
