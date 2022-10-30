pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Meldungstexte;

package SystemDatentypen is

   -- Wichtige Werte
   type Anfang_Ende_Enum is (
                             Anfangswert_Enum, Endwert_Enum
                            );
   
   
      
   type Ende_Enum is (
                      Leer_Enum,
                      
                      Gewonnen_Enum, Verloren_Enum
                     );
   
   
   
   -- Das hier mal umbauen/verschieben, damit die Abhängigkeit von Meldungstexte verschwindet? äöü
   subtype Spielmeldungen is Natural range 0 .. Meldungstexte.Meldung'Last;
   subtype SpielmeldungenVorhanden is Spielmeldungen range 1 .. Spielmeldungen'Last;
   
   
   
   type Abspann_Enum is (
                         Leer_Abspann_Enum,
                         
                         Abspann_Eins_Enum
                        );
   
   subtype Abspann_Vorhanden_Enum is Abspann_Enum range Abspann_Eins_Enum .. Abspann_Enum'Last;
   
   
      
   type NullBisHundert is range 0 .. 100;
   subtype EinsBisHundert is NullBisHundert range 1 .. NullBisHundert'Last;

end SystemDatentypen;
