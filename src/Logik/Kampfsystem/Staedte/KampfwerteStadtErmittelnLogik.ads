with RassenDatentypen;
with KampfDatentypen;
with StadtRecords;
with StadtKonstanten;

with LeseGrenzen;
with LeseRassenbelegung;

package KampfwerteStadtErmittelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              );
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
              );
   
private
   
   VerteidigungWert : KampfDatentypen.KampfwerteGroß;
   AngriffWert : KampfDatentypen.KampfwerteGroß;

end KampfwerteStadtErmittelnLogik;
