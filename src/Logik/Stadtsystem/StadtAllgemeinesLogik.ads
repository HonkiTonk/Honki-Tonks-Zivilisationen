with RassenDatentypen;
with StadtRecords;
with SpielVariablen;

private with SystemRecords;

with LeseGrenzen;

package StadtAllgemeinesLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure NeuerStadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   NeuerName : SystemRecords.TextEingabeRecord;

end StadtAllgemeinesLogik;
