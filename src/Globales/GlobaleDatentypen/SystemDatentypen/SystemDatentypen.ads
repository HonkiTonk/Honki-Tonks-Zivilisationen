pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Meldungstexte;

package SystemDatentypen is

   -- Wichtige Werte
   type Anfang_Ende_Enum is (
                             Anfangswert_Enum, Endwert_Enum
                            );
   
   
   
   -- Das dann mal überall einbauen wo es sinnvoll ist und die KartenDatentypen.UmgebungsbereichEins/Boolean Varianten rauswerfen. äöü
   type Erweiterter_Boolean_Enum is (
                                     False_Enum, Neutral_Enum, True_Enum 
                                    );
   
   subtype Erweiterter_Boolean_Vereinfacht_Enum is Erweiterter_Boolean_Enum range Neutral_Enum .. True_Enum;
   
   
   
   type Ende_Enum is (
                      Leer_Enum,
                      
                      Gewonnen_Enum, Verloren_Enum
                     );
   
   
      
   subtype Spielmeldungen is Natural range 0 .. Meldungstexte.Meldung'Last;
   subtype SpielmeldungenVorhanden is Spielmeldungen range 1 .. Spielmeldungen'Last;
   
   
   
   type Abspann_Enum is (
                         Leer_Abspann_Enum,
                         
                         Abspann_Eins_Enum
                        );
   
   subtype Abspann_Vorhanden_Enum is Abspann_Enum range Abspann_Eins_Enum .. Abspann_Enum'Last;

end SystemDatentypen;
