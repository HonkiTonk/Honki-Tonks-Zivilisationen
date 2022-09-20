pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LadezeitenDatentypen;

package LadezeitenLogik is
      
   type FortschrittSpielweltArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSpielwelt : FortschrittSpielweltArray;
   
   type FortschrittKIArray is array (LadezeitenDatentypen.KI_Rechnet_Enum'Range) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittKI : FortschrittKIArray;
   
   FortschrittRundenende : LadezeitenDatentypen.Ladefortschritt;
   FortschrittSpeichernLaden : LadezeitenDatentypen.Ladefortschritt;

   procedure SpielweltNullsetzen;
   procedure KINullsetzenFortschritt;
   procedure RundenendeNullsetzen;
   procedure SpeichernLadenNullsetzen;
   procedure RundenendeSchreiben;
   procedure RundenendeMaximum;
   procedure SpeichernLadenMaximum;
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittKISchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
   procedure FortschrittKIMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean);
   
private
   
   type FortschrittSchritteArray is array (1 .. 5) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSchritte : constant FortschrittSchritteArray := (
                                                               1 => 1,
                                                               2 => 1,
                                                               3 => 10,
                                                               4 => 14,
                                                               5 => 14
                                                              );

end LadezeitenLogik;
