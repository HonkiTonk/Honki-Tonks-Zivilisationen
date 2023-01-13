with SpeziesDatentypen;
with SystemRecords;
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
      return SystemRecords.TextEingabeRecord
     with
       Pre => (
                 if StadtSpeziesNummerExtern.Spezies /= SpeziesKonstanten.LeerSpezies then LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
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
