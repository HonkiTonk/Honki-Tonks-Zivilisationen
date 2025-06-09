package SystemDatentypen is
   pragma Pure;

   -- Das auch mal auslagern? äöü
   type Anfang_Ende_Enum is (
                             Anfangswert_Enum, Endwert_Enum
                            );
   
   
   
   -- Das auch mal auslagern? äöü
   type Erweiterter_Boolean_Enum is (
                                     True_Enum, Neutral_Enum, False_Enum
                                    );
   
   
      
   type Ende_Enum is (
                      Leer_Enum,
                      
                      Gewonnen_Enum, Verloren_Enum
                     );
   
   
   
   type Task_Enum is (
                      Logik_Task_Enum,
                      Grafik_Task_Enum
                     );
   
   
   
   -- Das auch mal auslagern? äöü
   type Spielstand_Enum is (
                            Manueller_Spielstand_Enum,
                            Automatischer_Spielstand_Enum
                           );
   
end SystemDatentypen;
