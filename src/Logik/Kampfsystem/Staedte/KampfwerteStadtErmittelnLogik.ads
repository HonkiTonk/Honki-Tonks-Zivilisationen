with RassenDatentypen;
with SpielVariablen;
with KampfDatentypen;
with StadtRecords;

with LeseGrenzen;

package KampfwerteStadtErmittelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              );
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              );
   
private
   
   VerteidigungWert : KampfDatentypen.KampfwerteGroß;
   AngriffWert : KampfDatentypen.KampfwerteGroß;

end KampfwerteStadtErmittelnLogik;
