pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Meldungstexte;

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
   
   
   
   subtype Spielmeldungen is Natural range 0 .. Meldungstexte.Meldung'Last;
   subtype SpielmeldungenVorhanden is Spielmeldungen range 1 .. Spielmeldungen'Last;
   
   
   
   type Abspann_Enum is (
                         Leer_Abspann_Enum,
                         
                         Abspann_Eins_Enum
                        );
   
   subtype Abspann_Vorhanden_Enum is Abspann_Enum range Abspann_Eins_Enum .. Abspann_Enum'Last;

end SystemDatentypen;
