with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with EinheitenDatentypen;
private with KartenRecords;

package KIEinheitFestlegenBewachenLogik is
   pragma Elaborate_Body;

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

end KIEinheitFestlegenBewachenLogik;
