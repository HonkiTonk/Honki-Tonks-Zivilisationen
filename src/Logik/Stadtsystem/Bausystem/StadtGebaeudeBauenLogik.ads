with RassenDatentypen;
with StadtRecords;
with SpielVariablen;

with LeseGrenzen;

package StadtGebaeudeBauenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure GebäudeFertiggestellt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end StadtGebaeudeBauenLogik;
