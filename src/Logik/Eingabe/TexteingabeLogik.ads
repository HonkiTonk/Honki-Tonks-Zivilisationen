pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SystemRecords;
with StadtRecords;
with SpielVariablen;

package TexteingabeLogik is
   pragma Elaborate_Body;

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
