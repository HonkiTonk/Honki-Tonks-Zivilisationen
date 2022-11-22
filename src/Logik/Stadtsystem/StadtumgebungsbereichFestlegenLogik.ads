with RassenDatentypen;
with SpielVariablen;
with StadtRecords;
with ProduktionDatentypen;

private with KartenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package StadtumgebungsbereichFestlegenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure StadtumgebungsbereichFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   Einwohner : ProduktionDatentypen.Einwohner;
   
   procedure StadtumgebungErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end StadtumgebungsbereichFestlegenLogik;
