with RassenDatentypen;
with StadtRecords;
with SpielVariablen;

with LeseGrenzen;
with LeseRassenbelegung;

package StadtGebaeudeBauenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end StadtGebaeudeBauenLogik;
