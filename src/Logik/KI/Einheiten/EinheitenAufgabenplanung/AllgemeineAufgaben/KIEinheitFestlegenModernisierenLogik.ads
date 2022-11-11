with RassenDatentypen; use RassenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with StadtRecords;
private with KartenRecords;
private with KartenDatentypen;

package KIEinheitFestlegenModernisierenLogik is
   pragma Elaborate_Body;

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   Umgebung : KartenDatentypen.UmgebungsbereichDrei;
   
   NeueEinheitenID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   StadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   PlatzGefunden : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   function EinheitVerbessernPlatz
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 EinheitNummerExtern <= SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze
               and
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenModernisierenLogik;
