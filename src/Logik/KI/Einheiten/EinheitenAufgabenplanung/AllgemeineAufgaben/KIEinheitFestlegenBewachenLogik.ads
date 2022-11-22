with RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitFestlegenBewachenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenBewachenLogik;
