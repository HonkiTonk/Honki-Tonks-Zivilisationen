with SystemRecordsHTSEB;

with SpeziesDatentypen;
with StadtRecords;
with SpeziesKonstanten;

with LeseSpeziesbelegung;

package TexteingabeLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   function StadtName
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauenExtern : in Boolean)
      return SystemRecordsHTSEB.TextEingabeRecord
     with
       Pre => (
                 if StadtSpeziesNummerExtern.Spezies /= SpeziesKonstanten.LeerSpezies then LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function SpielstandName
     return SystemRecordsHTSEB.TextEingabeRecord;
   
private
   
   Frage : Positive;
   
   Name : SystemRecordsHTSEB.TextEingabeRecord;
   
   
   
   function NameEingeben
     (WelcheFrageExtern : in Positive)
      return SystemRecordsHTSEB.TextEingabeRecord;

end TexteingabeLogik;
