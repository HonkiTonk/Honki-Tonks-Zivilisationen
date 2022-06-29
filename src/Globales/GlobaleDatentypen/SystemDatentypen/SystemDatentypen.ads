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
                                
                                Zahlen_Eingabe_Enum, Text_Eingabe_Enum, Einheit_Auswahl_Enum, Ja_Nein_Enum
                               );
   
   --------------------- Hier den Schwierigkeitsgrad_Enum einbauen?
   -- Wichtige Werte
   
    
   
   ------------------------------------------ Alles ab hier sollte woanders hin, oder?
   -- Sonstiges
   type Staatsform_Enum is (
                            Anarchie_Enum,
                            Demokratie_Enum
                           );

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Sonstiges



   ------------------------------------------ Hier auch mal Sachen rausverschieben.
   -- Für Diplomatie
   type Status_Untereinander_Enum is (
                                      Unbekannt_Enum, Neutral_Enum, Nichtangriffspakt_Enum, Krieg_Enum
                                     );
   
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral_Enum .. Status_Untereinander_Enum'Last;
   -- Für Diplomatie

end SystemDatentypen;
