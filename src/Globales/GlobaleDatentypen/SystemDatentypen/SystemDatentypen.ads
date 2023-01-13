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
   
   
   
   subtype Zeug is Natural range 0 .. 53;
   subtype ZeugVorhanden is Zeug range 1 .. Zeug'Last;
   
   subtype Fragen is Natural range 0 .. 34;
   subtype FragenVorhanden is Fragen range 1 .. Fragen'Last;
     
   subtype Spielmeldungen is Natural range 0 .. 11;
   subtype SpielmeldungenVorhanden is Spielmeldungen range 1 .. Spielmeldungen'Last;
   
   
   
   type Abspann_Enum is (
                         Leer_Abspann_Enum,
                         
                         Abspann_Eins_Enum
                        );
   
   subtype Abspann_Vorhanden_Enum is Abspann_Enum range Abspann_Enum'Succ (Abspann_Enum'First) .. Abspann_Enum'Last;
   
   
      
   type NullBisHundert is range 0 .. 100;
   subtype EinsBisHundert is NullBisHundert range 1 .. NullBisHundert'Last;

end SystemDatentypen;
