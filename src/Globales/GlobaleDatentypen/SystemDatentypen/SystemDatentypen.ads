pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package SystemDatentypen is

   -- Wichtige Werte
   -- Sind keine Menü exklusiven Datentypen, deswegen sind die erst einmal noch hier.
   type Anfang_Ende_Enum is (
                             Anfangswert_Enum, Endwert_Enum
                            );
   
   type Welche_Eingabe_Enum is (
                                Keine_Eingabe_Enum,
                                
                                Zahlen_Eingabe_Enum, Text_Eingabe_Enum, Zeichen_Eingabe_Enum, Ja_Nein_Enum,
                                
                                Einheit_Auswahl_Enum
                               );
   
   subtype Eingaben_Vorhanden_Enum is Welche_Eingabe_Enum range Zahlen_Eingabe_Enum .. Welche_Eingabe_Enum'Last;
   subtype Eingaben_Fragen_Enum is Eingaben_Vorhanden_Enum range Zahlen_Eingabe_Enum .. Ja_Nein_Enum;
   
   -- Das dann mal überall einbauen und die KartenDatentypen.UmgebungsbereichEins/Boolean Varianten rauswerfen. äöü
   type Erweiterter_Boolean_Enum is (
                                     False_Enum, Neutral_Enum, True_Enum 
                                    );
   
   subtype Erweiterter_Boolean_Vereinfacht_Enum is Erweiterter_Boolean_Enum range Neutral_Enum .. True_Enum;
   
   -- Hier den Schwierigkeitsgrad_Enum einbauen? äöü
   -- Wichtige Werte
   
    
   
   -- Alles ab hier sollte woanders hin, oder? äöü
   -- Sonstiges
   type Staatsform_Enum is (
                            Anarchie_Enum,
                            Demokratie_Enum
                           );

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Sonstiges

end SystemDatentypen;
