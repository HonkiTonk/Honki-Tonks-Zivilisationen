with TextnummernKonstanten;

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
   
   
   
   -- Das hier mal in einen eigenen Bereich oder in die TextnummernKonstanten verschieben. äöü
   -- subtype Zeug is Natural range 0 .. TextnummernKonstanten.EndeZeug;
   subtype ZeugVorhanden is Positive range TextnummernKonstanten.AnfangZeug .. TextnummernKonstanten.EndeZeug;
   
   -- subtype Fragen is Natural range 0 .. TextnummernKonstanten.EndeFrage;
   subtype FragenVorhanden is Positive range TextnummernKonstanten.AnfangFrage .. TextnummernKonstanten.EndeFrage;
     
   subtype Spielmeldungen is Natural range 0 .. TextnummernKonstanten.EndeMeldung;
   subtype SpielmeldungenVorhanden is Positive range TextnummernKonstanten.AnfangMeldung .. Spielmeldungen'Last;
   
   subtype LadezeitVorhanden is Positive range TextnummernKonstanten.AnfangLadezeit .. TextnummernKonstanten.EndeLadezeit;
   
   
   
   type Abspann_Enum is (
                         Leer_Abspann_Enum,
                         
                         Abspann_Eins_Enum
                        );
   
   subtype Abspann_Vorhanden_Enum is Abspann_Enum range Abspann_Enum'Succ (Abspann_Enum'First) .. Abspann_Enum'Last;
   
   
      
   type NullBisHundert is range 0 .. 100;
   subtype EinsBisHundert is NullBisHundert range 1 .. NullBisHundert'Last;

end SystemDatentypen;
