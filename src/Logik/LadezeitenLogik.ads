with SystemDatentypenHTSEB;

with LadezeitenDatentypen;

package LadezeitenLogik is
   pragma Elaborate_Body;
   
   FortschrittRundenende : SystemDatentypenHTSEB.NullBisHundert;
   FortschrittSpeichernLaden : SystemDatentypenHTSEB.NullBisHundert;
      
   type FortschrittSpielweltArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittSpielwelt : FortschrittSpielweltArray;
   
   type FortschrittKIArray is array (LadezeitenDatentypen.KI_Rechnet_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittKI : FortschrittKIArray;
   
   type FortschrittSpeichernArray is array (LadezeitenDatentypen.Speichern_Neu_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittSpeichern : FortschrittSpeichernArray;

   procedure SpielweltNullsetzen;
   procedure KINullsetzenFortschritt;
   procedure RundenendeNullsetzen;
   procedure SpeichernLadenNullsetzen;
   procedure RundenendeSchreiben;
   procedure RundenendeMaximum;
   procedure SpeichernLadenMaximum;
   
   procedure SpeichernNullsetzen;
   procedure Speichern
     (WelcheBerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Neu_Enum;
      ErhöhungExtern : in SystemDatentypenHTSEB.NullBisHundert);
   
   procedure SpeichernMaximum
     (WelcheBerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Neu_Enum);
   
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
   
   AnfangLadezeit : constant SystemDatentypenHTSEB.NullBisHundert := SystemDatentypenHTSEB.NullBisHundert'First;
   EndeLadezeit : constant SystemDatentypenHTSEB.NullBisHundert := SystemDatentypenHTSEB.NullBisHundert'Last;
   
   type FortschrittSchritteArray is array (1 .. 5) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittSchritte : constant FortschrittSchritteArray := (
                                                               1 => 1,
                                                               2 => 1,
                                                               3 => 5,
                                                               4 => 14,
                                                               5 => 7
                                                              );

end LadezeitenLogik;
