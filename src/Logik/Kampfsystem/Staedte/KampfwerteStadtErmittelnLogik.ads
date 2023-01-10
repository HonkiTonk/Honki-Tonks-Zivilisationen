with SpeziesDatentypen;
with KampfDatentypen;
with StadtRecords;
with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KampfwerteStadtErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;

   function AktuelleVerteidigungStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              );
   
   function AktuellerAngriffStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              );
   
private
   
   VerteidigungWert : KampfDatentypen.KampfwerteGroß;
   AngriffWert : KampfDatentypen.KampfwerteGroß;

end KampfwerteStadtErmittelnLogik;
