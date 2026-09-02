with SystemDatentypenHTSEB;

with LadezeitenDatentypen;

package LadezeitenLogik is
   pragma Elaborate_Body;
   
   FortschrittRundenende : SystemDatentypenHTSEB.NullBisHundert;
      
   type FortschrittKartengeneratorArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittKartengenerator : FortschrittKartengeneratorArray;
   
   type FortschrittKIArray is array (LadezeitenDatentypen.KI_Rechnet_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittKI : FortschrittKIArray;
   
   type FortschrittSpeichernLadenArray is array (LadezeitenDatentypen.Speichern_Laden_Enum'Range) of SystemDatentypenHTSEB.NullBisHundert;
   FortschrittSpeichernLaden : FortschrittSpeichernLadenArray;
   
   procedure RundenendeNullsetzen;
   procedure RundenendeSchreiben
     (ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure RundenendeMaximum;
   
   procedure SpeichernLadenNullsetzen;
   procedure SpeichernLaden
     (BerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Laden_Enum;
      ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure SpeichernLadenMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Laden_Enum);

   procedure KartengeneratorNullsetzen;
   procedure KartengeneratorSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum;
      ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure KartengeneratorMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure KINullsetzenFortschritt;
   procedure KISchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Rechnet_Enum;
      ZeitExtern : in Float)
     with
       Pre => (
                 ZeitExtern in 0.00 .. 100.00
              );
   
   procedure KIMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
private
   
   AnfangLadezeit : constant SystemDatentypenHTSEB.NullBisHundert := SystemDatentypenHTSEB.NullBisHundert'First;
   EndeLadezeit : constant SystemDatentypenHTSEB.NullBisHundert := SystemDatentypenHTSEB.NullBisHundert'Last;

end LadezeitenLogik;
