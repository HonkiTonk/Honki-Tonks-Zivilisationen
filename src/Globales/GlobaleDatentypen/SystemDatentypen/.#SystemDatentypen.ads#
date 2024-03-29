package SystemDatentypen is
   pragma Pure;

   type Anfang_Ende_Enum is (
                             Anfangswert_Enum, Endwert_Enum
                            );
   
   
   
   type Erweiterter_Boolean_Enum is (
                                     True_Enum, Neutral_Enum, False_Enum
                                    );
   
   
      
   type Ende_Enum is (
                      Leer_Enum,
                      
                      Gewonnen_Enum, Verloren_Enum
                     );
   
   
   
   type Abspann_Enum is (
                         Leer_Abspann_Enum,
                         
                         Abspann_Eins_Enum
                        );
   
   subtype Abspann_Vorhanden_Enum is Abspann_Enum range Abspann_Enum'Succ (Abspann_Enum'First) .. Abspann_Enum'Last;
   
   
      
   type NullBisHundert is range 0 .. 100;
   subtype EinsBisHundert is NullBisHundert range 1 .. NullBisHundert'Last;
   
   
   
   type Task_Enum is (Logik_Task_Enum, Grafik_Task_Enum);
   
   
   
   -- Für vorzeichenlose Datentypen mod verwenden.
   -- Wird gespeichert als ein Byte.
   type Sichtbarkeitszahl is mod 2**6;
   
   -- Wird gespeichert als ein Byte.
   type FeldelementVorhanden is mod 2**8;

end SystemDatentypen;
