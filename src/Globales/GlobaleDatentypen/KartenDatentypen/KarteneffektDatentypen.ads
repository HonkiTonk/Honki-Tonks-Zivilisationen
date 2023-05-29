package KarteneffektDatentypen is
   pragma Pure;
   
   -- Das hier vielleicht auch nach Kartenextras oder was Eigenes verschieben? äöü
   type Effekt_Enum is (
                        Leer_Effekt_Enum,
                        
                        Strahlung_Enum, Biologisch_Enum, Chemisch_Enum,
                        
                        -- Das hier vielleicht in Müll und Smog aufteilen? äöü
                        Verschmutzt_Enum,
                        
                        Vernichtet_Enum
                       );
   
   subtype Effekt_Vorhanden_Enum is Effekt_Enum range Effekt_Enum'Succ (Effekt_Enum'First) .. Effekt_Enum'Last;
   
   subtype Effekt_Kartenfeld_Enum is Effekt_Enum range Effekt_Enum'First .. Effekt_Enum'Pred (Effekt_Enum'Last);
   subtype Effekt_Kartenfeld_Vorhanden_Enum is Effekt_Kartenfeld_Enum range Effekt_Enum'Succ (Effekt_Enum'First) .. Effekt_Kartenfeld_Enum'Last;

end KarteneffektDatentypen;
