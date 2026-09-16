package KartenverbesserungDatentypen is
   pragma Pure;
   
   -- Wie mach ich das dann mit den Städten? äöü
   -- Prüfung ob eine Stadt dort ist und keine Verbesserungen zulassen?
   -- Verbesserungen zulassen und Städte wie eine behandeln?
   -- Städte und Verbesserungen separieren und Verbesserungen zulassen?
   -- Städte und Verbesserungen separieren und keine Verbesserungen zulassen?
   type Verbesserungen_Enum is (
                                Leer_Verbesserungen_Enum,
                                     
                                -- Städte
                                Hauptstadt_Enum, Stadt_Enum,
                                     
                                -- Wie weit will ich das überhaupt aufdrösseln? äöü
                                -- Friedlich
                                Farm_Enum, Mine_Enum,
                                     
                                -- Krieg
                                Festung_Enum
                               );
   
   subtype Verbesserungen_Vorhanden_Enum is Verbesserungen_Enum range Verbesserungen_Enum'Succ (Verbesserungen_Enum'First) .. Verbesserungen_Enum'Last;

   subtype Verbesserungen_Stadt_ID_Enum is Verbesserungen_Enum range Leer_Verbesserungen_Enum .. Stadt_Enum;
   subtype Verbesserungen_Städte_Enum is Verbesserungen_Stadt_ID_Enum range Hauptstadt_Enum .. Stadt_Enum;
   subtype Verbesserungen_Gebilde_Enum is Verbesserungen_Vorhanden_Enum range Farm_Enum .. Verbesserungen_Vorhanden_Enum'Last;
   subtype Verbesserungen_Gebilde_Friedlich_Enum is Verbesserungen_Gebilde_Enum range Farm_Enum .. Mine_Enum;
   subtype Verbesserungen_Gebilde_Kampf_Enum is Verbesserungen_Gebilde_Enum range Festung_Enum .. Festung_Enum;
   
   
   
   type Verbesserungenanzahl_Enum is (
                                      Verbesserung_Eins_Enum, Verbesserung_Zwei_Enum, Verbesserung_Drei_Enum, Verbesserung_Vier_Enum
                                     );
   pragma Ordered (Verbesserungenanzahl_Enum);

end KartenverbesserungDatentypen;
