pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;
with KartenRecords;
with SpielVariablen;

with KIDatentypen;

with Karten;

package KIBewegungAllgemein is
   
   function FeldBetreten
     (FeldKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
     with
       Pre =>
         (FeldKoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            FeldKoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);
   
private

   BlockierendeEinheit : RassenDatentypen.Rassen_Enum;
   BlockierendeStadt : RassenDatentypen.Rassen_Enum;
   
   function FeldAngreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Bewegung_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum);

end KIBewegungAllgemein;
