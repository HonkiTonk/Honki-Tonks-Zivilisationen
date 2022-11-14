with RassenDatentypen;
with SystemRecords;
with StadtRecords;
with SpielVariablen;

package TexteingabeLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   function StadtName
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return SystemRecords.TextEingabeRecord
     with
       Pre => (
                 if StadtRasseNummerExtern.Rasse /= RassenDatentypen.Keine_Rasse_Enum then SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   function SpielstandName
     return SystemRecords.TextEingabeRecord;
   
private
   
   Frage : Positive;
   
   Name : SystemRecords.TextEingabeRecord;
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecords.TextEingabeRecord;

end TexteingabeLogik;
